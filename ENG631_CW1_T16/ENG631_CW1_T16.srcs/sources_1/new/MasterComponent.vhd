----------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date: 23.10.2018 15:23:06
-- Design Name:
-- Module Name: MasterComponent - Behavioral
-- Project Name:
-- Target Devices:
-- Tool Versions:
-- Description:
--
-- Dependencies:
--
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MasterComponent is
    Port ( inReset : in std_logic;
           inFast  : in  STD_LOGIC;
           inClock : in STD_LOGIC;
           outDigit : out STD_LOGIC_VECTOR (7 downto 0);
           outSegmentSelector :out STD_LOGIC_VECTOR (3 downto 0));
end MasterComponent;

architecture Behavioral of MasterComponent is

--Component Declarations
 
  ------
  --Debouncer Component
  ------
  component Debouncer
  
  Port ( 
    Input : in STD_LOGIC;
    Output : out STD_LOGIC
    );
  
  end component Debouncer;
  
  ------
  --Counter Component
  ------
  component Counter
  generic (
    genMaxCount : integer
  );
  port (
    inClock  : in  STD_LOGIC;
    inReset  : in  STD_LOGIC;
    outCount : out STD_LOGIC_VECTOR (13 downto 0)
  );
  end component Counter;

  ------
  --Clock Divider Component
  ------
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


--Signals

signal sigSystemClock : std_logic;

signal sig1Hz : std_logic;

signal sig1000Hz : std_logic;

signal sigSelectedClock : std_logic;

signal sigDisplayClock : std_logic;

signal sigCount : std_logic_vector (13 downto 0);

signal sigSegment : std_logic_vector (1 downto 0);

signal sigResetPulse : std_logic;

begin

------
--Instantiate compopnents
------
--Connect ClockManager between input and system clocks
  compClockManager : ClockManager
    port map (out100MHz => sigSystemClock, in100MHz => inClock, reset => inReset, locked => open);

  compClock1Hz : ClockDivider
    generic map (MaxCount => 100000000) -- Counting to 100000000 gives a frequency of 1 hz
    port map (reset => inReset, clock => sigSystemClock, clockOut => sig1Hz);
    
  compClock250Hz : ClockDivider
    generic map (MaxCount => 100000) -- Counting to 100000000 gives a frequency of 1 hz
    port map (reset => inReset, clock => sigSystemClock, clockOut => sig1000Hz);

  comp9999Counter : Counter
    generic map (genMaxCount => 10000)
    port map (inClock => sigSelectedClock, inReset => inReset, outCount => sigCount);

  compDisplayDriver : DisplayDriver
    port map (inReset => inReset, inSelection => sigSegment, inNumber => sigCount, outDigit => outDigit);

  compSegmentCounter : Counter
    generic map (genMaxCount => 4)
    port map (inClock => sig1000Hz, inReset => inReset, outCount (1 downto 0) => sigSegment, outCount (13 downto 2) => open); -- Splits last two out... Look into doing with Logs

------
--Other Wiring
------

  with sigSegment select
    outSegmentSelector <= "1110" when "00",
                          "1101" when "01",
                          "1011" when "10",
                          "0111" when "11",
                          "1111" when others;
                          
  with inFast select
    sigSelectedClock <= sig1Hz   when '0',
                        sig1000Hz when '1';


end Behavioral;
