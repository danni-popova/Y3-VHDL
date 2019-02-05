-- Team 16 - 782716, 780962

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TopComponent is
    Port ( inReset : in STD_LOGIC;
           inFast : in STD_LOGIC;
           inClock : in STD_LOGIC;
           inSwitches : in STD_LOGIC_VECTOR (2 downto 0);
           outDigit : out STD_LOGIC_VECTOR (7 downto 0);
           outSegmentSelector : out STD_LOGIC_VECTOR (3 downto 0));
end TopComponent;

architecture Behavioral of TopComponent is

------------------------------
-- Counter
------------------------------

    component Counter
    generic (genMaxCount : integer);
    port (
    inClock  : in  STD_LOGIC;
    inReset  : in  STD_LOGIC;
    outCount : out STD_LOGIC_VECTOR (13 downto 0));
    end component Counter;

------------------------------
-- Random Number Generator
------------------------------

  component RandomNumberGenerator is
  Port ( clock : in STD_LOGIC;
         reset : in STD_LOGIC;
         oRandomNumber : out STD_LOGIC_VECTOR (3 downto 0));
  end component RandomNumberGenerator;

------------------------------
-- Clock Divider
------------------------------

  component ClockDivider
  generic (
    MaxCount : integer
  );
  port (
    reset    : in  STD_LOGIC;
    clock    : in  STD_LOGIC;
    clockOut : out STD_LOGIC
  );
  end component ClockDivider;

  ------
  --Clock Manager Component
  ------
  component ClockManager
  port (
    out100MHz : out STD_LOGIC;
    reset     : in  STD_LOGIC;
    locked    : out STD_LOGIC;
    in100MHz  : in  STD_LOGIC
  );
  end component ClockManager;

  ------
  --Display Driver Component
  ------
  component DisplayDriver
  port (
    inReset     : in  STD_LOGIC;
    inSelection : in  STD_LOGIC_VECTOR (1 downto 0);
    inNumber    : in  STD_LOGIC_VECTOR (13 downto 0);
    outDigit    : out STD_LOGIC_VECTOR (7 downto 0)
  );
  end component DisplayDriver;
  
  ----
  --Debouncer
  ----
  
  component Debouncer is
      Port ( Clock : in std_logic;
             Input : in STD_LOGIC;
             Output : out STD_LOGIC);
  end component Debouncer;
  
  ---
  --Segment Selector
  ---
  component SegmentSelector is
      Port ( inDecimal : in STD_LOGIC_VECTOR (3 downto 0);
             outSegments : out STD_LOGIC_VECTOR (7 downto 0));
  end component SegmentSelector;
  
  ---
  --Student number selector
  ---
  
  component StudentNumber is
  
      Port(
           inClock : in std_logic;
           inReset : in std_logic;
           inSetting : in std_logic_vector (2 downto 0);
           outData : out std_logic_vector (3 downto 0));
    
  end component StudentNumber;
  
  ---
  --Bit Splitter
  ---
  component BitSplitter is
      Port ( inBits : in STD_LOGIC_VECTOR (3 downto 0);
             inClock : in std_logic;
             inReset : in std_logic;
             outMSB : out STD_LOGIC_VECTOR (3 downto 0);
             outLSB : out STD_LOGIC_VECTOR (3 downto 0));
  end component BitSplitter;
  
--Signals

signal sigSystemClock : std_logic;

signal sig1Hz : std_logic;

signal sig2Hz : std_logic;

signal sig1000Hz : std_logic;

signal sigSelectedClock : std_logic;

signal sigDisplayClock : std_logic;

signal sigCount : std_logic_vector (3 downto 0);

signal sigSegment : std_logic_vector (1 downto 0);

signal sigResetPulse : std_logic;

signal sigBinaryOut : std_logic_vector (3 downto 0);

signal sigBinaryData : std_logic_vector (3 downto 0);

signal sigLSB : std_logic_vector (3 downto 0);
signal sigMSB : std_logic_vector (3 downto 0);

signal sigData : std_logic_vector (3 downto 0);

signal sigRNG : std_logic_vector (3 downto 0);

signal sigStudentNumber : std_logic_vector (3 downto 0);

begin

------
--Instantiate compopnents
------

--Connect ClockManager between input and system clocks
  compClockManager : ClockManager
    port map (out100MHz => sigSystemClock, in100MHz => inClock, reset => sigResetPulse, locked => open);

  compClock1Hz : ClockDivider
    generic map (MaxCount => 100000000) -- Counting to 100000000 gives a frequency of 1 hz
    port map (reset => sigResetPulse, clock => sigSystemClock, clockOut => sig1Hz);
    
  compClock2Hz : ClockDivider
        generic map (MaxCount => 50000000) -- Counting to 100000000 gives a frequency of 1 hz
        port map (reset => sigResetPulse, clock => sigSystemClock, clockOut => sig2Hz);
    
  compClock250Hz : ClockDivider
    generic map (MaxCount => 100000) -- Counting to 100000000 gives a frequency of 1 hz
    port map (reset => sigResetPulse, clock => sigSystemClock, clockOut => sig1000Hz);

  compFCounter : Counter
    generic map (genMaxCount => 16)
    port map (inClock => sigSelectedClock, inReset => inReset, outCount (3 downto 0) => sigCount, outCount (13 downto 4) => open);

--  compDisplayDriver : DisplayDriver
--    port map (inReset => sigResetPulse, inSelection => sigSegment, inNumber => sigCount, outDigit => outDigit);

  compSegmentCounter : Counter
    generic map (genMaxCount => 4)
    port map (inClock => sig1000Hz, inReset => sigResetPulse, outCount (1 downto 0) => sigSegment, outCount (13 downto 2) => open); -- Splits last two out... Look into doing with Logs
    
  compRNG : RandomNumberGenerator
    port map (clock => sigSelectedClock, reset => sigResetPulse, oRandomNumber =>  sigRNG);
    
  compDebouncer : Debouncer
    port map (clock => inClock, input => inReset, output => sigResetPulse);
    
  compSegSelect : SegmentSelector
    port map (inDecimal => sigBinaryOut, outSegments => outDigit);
    
  compStudentNumber : StudentNumber
    port map (inClock => sigSelectedClock, inReset => sigResetPulse, inSetting => inSwitches, outData => sigStudentNumber);
    
  compBinaryDisplay : BitSplitter
    port map (inClock => sig2Hz, inBits => sigData, inReset => sigResetPulse, outMSB => sigMSB, outLSB => sigLSB);

------
--Other Wiring
------

  with sigSegment select
    outSegmentSelector <= "1110" when "00",
                          "1101" when "01",
                          "1011" when "10",
                          "0111" when "11",
                          "1111" when others;
  
  with sigSegment select --Multiplex to display
    sigBinaryOut <=  sigLSB when "00",
                     sigMSB when "01",
                     sigData when "10",
                     "0" & inSwitches when "11";
                     
  with inFast select
    sigSelectedClock <= sig1Hz   when '0',
                        sig1000Hz when '1';
                          
  with inSwitches select
    sigData <= "0001" when "000",
               "0111" when "001",
               "1110" when "010",
               "1000" when "011",
               sigCount when "100",
               sigRNG when "101",
               sigStudentNumber when "110",
               sigStudentNumber when "111";

end Behavioral;
