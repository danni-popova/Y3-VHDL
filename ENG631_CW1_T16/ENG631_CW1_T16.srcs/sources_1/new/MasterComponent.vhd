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
           inClock : in STD_LOGIC;
           outDigit : out STD_LOGIC_VECTOR (7 downto 0);
           outSegmentSelector :out STD_LOGIC_VECTOR (3 downto 0));
end MasterComponent;

architecture Behavioral of MasterComponent is

--Component Declarations

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

--Signals

signal sigSystemClock : std_logic;


begin

------
--Instantiate compopnents
------
--Connect ClockManager between input and system clocks
  compClockManager : ClockManager
    port map (out100MHz => sigSystemClock, in100MHz => inClock, reset => inReset, locked => open);


end Behavioral;
