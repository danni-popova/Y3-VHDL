----------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date: 10/24/2018 02:40:06 PM
-- Design Name:
-- Module Name: Counter_tb - Behavioral
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

entity Counter_tb is
--  Port ( );
end Counter_tb;



architecture Behavioral of Counter_tb is
--Component Declaration
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

--Signals
  signal sigClock : STD_LOGIC := '0';
  signal sigReset : STD_LOGIC := '0';
  signal sigCount : STD_LOGIC_VECTOR (13 downto 0);

begin

  uut : Counter
    generic map (genMaxCount => 3)
    port map (inClock => sigClock, inReset => sigReset, outCount => sigCount);

  procClock : process
  begin
    sigClock <= '0';
    wait for 100ns;
    sigClock <= '1';
    wait for 100ns;
  end process;


end Behavioral;
