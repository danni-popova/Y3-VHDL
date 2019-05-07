-- Team 16 - 782716, 780962

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TopComponent is
    Port ( inReset : in STD_LOGIC;
           inFast : in STD_LOGIC;
           inClock : in STD_LOGIC;
           inSwitches : in STD_LOGIC_VECTOR (2 downto 0);
           inOnOff : in STD_Logic;
           outDigit : out STD_LOGIC_VECTOR (7 downto 0);
           outSegmentSelector : out STD_LOGIC_VECTOR (3 downto 0);
           outRunning : out std_logic);
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
         oRandomNumber : out STD_LOGIC_VECTOR (19 downto 0));
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

  ----
  -- Reset Pulse Generator
  ----

  component SwitchChangeReset is
      Port ( inClock : in STD_LOGIC;
             inSwitches : in STD_LOGIC_VECTOR (2 downto 0);
             outResetPulse : out STD_LOGIC);
  end component SwitchChangeReset;

  ---
  -- On/Off switch
  ---

  component OnOffSwitch is
      Port ( inClock : in std_logic;
             inPulse : in STD_LOGIC;
             outState : out STD_LOGIC);
  end component OnOffSwitch;
  
  component ModemA is
      Port ( inClock : in STD_LOGIC;
         inClock2hz : in std_logic;
         inData : in STD_LOGIC_VECTOR (3 downto 0);
         inSwitches : in std_logic_vector (1 downto 0);
         outData : out STD_LOGIC_VECTOR (3 downto 0));
  end component ModemA;

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

signal sigAutoReset : std_logic;

signal sigResetButton : std_logic;

signal sigRunning : std_logic;

signal sigOnOffButton : std_Logic;

signal sigDisplayOut : std_logic_vector (3 downto 0);

signal sig16Hz : std_logic;

signal modulatedData : std_logic_vector (3 downto 0);

begin

------
--Instantiate compopnents
------

--Connect ClockManager between input and system clocks
  compClockManager : ClockManager
    port map (out100MHz => sigSystemClock, in100MHz => inClock, reset => '0', locked => open);

  --This is the 1Hz Clock for the various data generators such as the counter
  compClock1Hz : ClockDivider
    generic map (MaxCount => 100000000) -- Counting to 100000000 gives a frequency of 1 hz
    port map (reset => sigResetPulse, clock => sigSystemClock, clockOut => sig1Hz);

  --This is the 2Hz clock for the last two digits that display the binary number
  compClock2Hz : ClockDivider
        generic map (MaxCount => 50000000) -- Counting to 100000000 gives a frequency of 1 hz
        port map (reset => sigResetPulse, clock => sigSystemClock, clockOut => sig2Hz);

  --This is the clock for the multiplexer on the display
  compClock250Hz : ClockDivider
    generic map (MaxCount => 100000) -- Counting to 100000000 gives a frequency of 1 hz
    port map (reset => sigResetPulse, clock => sigSystemClock, clockOut => sig1000Hz);

  compClock16Hz : ClockDivider
    generic map (MaxCount => 6250000)
    port map (reset => sigResetPulse, clock => sigSystemClock, clockOut => sig16Hz);

  --The 0-f counter
  compFCounter : Counter
    generic map (genMaxCount => 16)
    port map (inClock => sigSelectedClock, inReset => sigResetPulse, outCount (3 downto 0) => sigCount, outCount (13 downto 4) => open);

  --This is the counter for the display multiplexer to decide which digit to illuminate
  compSegmentCounter : Counter
    generic map (genMaxCount => 4)
    port map (inClock => sig1000Hz, inReset => sigResetPulse, outCount (1 downto 0) => sigSegment, outCount (13 downto 2) => open); -- Splits last two out... Look into doing with Logs

  --The Random number generator
  compRNG : RandomNumberGenerator
    port map (clock => sigSelectedClock, reset => sigResetPulse, oRandomNumber(3 downto 0) =>  sigRNG, oRandomNumber(19 downto 4) => open);

  --Debouncer for the reset button
  compResetDebouncer : Debouncer
    port map (clock => inClock, input => inReset, output => sigResetButton);

  --debouncer for the on off button
  compOnOffDebouncer : Debouncer
    port map (clock => inClock, input => inOnOff, output => sigOnOffButton);

  --Segment selector takes in a 0-f value and decides which segments to illuminate
  compSegSelect : SegmentSelector
    port map (inDecimal => sigDisplayOut, outSegments => outDigit);

  --Generates the number sequence for our student numbers
  compStudentNumber : StudentNumber
    port map (inClock => sigSelectedClock, inReset => sigResetPulse, inSetting => inSwitches, outData => sigStudentNumber);

  --Takes in a four bit number, and clocks through two bit outputs
  compBinaryDisplay : BitSplitter
    port map (inClock => sig2Hz, inBits => modulatedData, inReset => sigResetPulse, outMSB => sigMSB, outLSB => sigLSB);

  --This detects a change on the input switches, and will output a pulse if their state changes
  compChangeReset : SwitchChangeReset
    port map (inClock => sigSystemClock, inSwitches => inSwitches, outResetPulse => sigAutoReset);

  --This is a T-FlipFlop-esque component that changes it's output from high to low when you provide it a pulse
  --Creates the on-off functionality
  compOnOff : OnOffSwitch
    port map (inClock => sigSystemClock, inPulse => sigOnOffButton, outState => sigRunning);
    
  ModemA1 : ModemA
    port map(inData => sigData , inClock => sig16Hz, outData => modulatedData, inSwitches => "00", inClock2Hz => sig2Hz); --Needs a 16Hz Clock

------
--Other Wiring
------

  --MUX to select which segment to light up
  with sigSegment select
    outSegmentSelector <= "1110" when "00",
                          "1101" when "01",
                          "1011" when "10",
                          "0111" when "11",
                          "1111" when others;

  --MUX to select the right data to display when the relevant segment is illuminated
  with sigSegment select --Multiplex to display
    sigBinaryOut <=  sigLSB when "00",
                     sigMSB when "01",
                     modulatedData when "10",
                     "0" & inSwitches when "11";

  --Displays all zeroes when running isn't high i.e. the system has stopped
  with sigRunning select
    sigDisplayOut <= "0000" when '0',
                     sigBinaryOut when '1';

  --Disoconnects the clocks to pause the system when the on off button is pressed
  with sigRunning select
    sigSelectedClock <= sig1Hz   when '1',
                        '0'      when '0';

  --Choses the data to put through the data digit on the display
  with inSwitches select
    sigData <= "0001" when "000",           --1
               "0111" when "001",           --7
               "1110" when "010",           --E
               "1000" when "011",           --8
               sigCount when "100",         --0-f counter
               sigRNG(3 downto 0) when "101",           --Random Number
               sigStudentNumber when "110", --Danni's Student Number
               sigStudentNumber when "111"; --Tom's Student Number

  --This combines the reset button with the automatic reset from the switches on the board
  sigResetPulse <= sigAutoReset OR sigResetButton;

  --Sig Runing is toggled high by the start button, this turns on a light on the board when it is 'on'
  outRunning <= sigRunning;

end Behavioral;
