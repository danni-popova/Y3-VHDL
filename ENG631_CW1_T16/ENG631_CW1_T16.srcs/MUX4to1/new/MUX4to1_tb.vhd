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

entity MUX4to1_tb is
--  Port ( );
end MUX4to1_tb;



architecture Behavioral of MUX4to1_tb is
--Component Declaration
component MUX4to1 is
    Port ( inSelection : in STD_LOGIC_VECTOR (1 downto 0);
           in0 : in STD_LOGIC_VECTOR (3 downto 0);
           in1 : in STD_LOGIC_VECTOR (3 downto 0);
           in2 : in STD_LOGIC_VECTOR (3 downto 0);
           in3 : in STD_LOGIC_VECTOR (3 downto 0);
           out0 : out STD_LOGIC_VECTOR (3 downto 0));
end component MUX4to1;

--Signals
  signal sigSelect : STD_LOGIC_vector (1 downto 0) := "00";
  signal sigIn0 : STD_LOGIC_vector (3 downto 0) := "0000";
  signal sigIn1 : STD_LOGIC_vector (3 downto 0) := "0010";
  signal sigIn2 : STD_LOGIC_vector (3 downto 0) := "0100";
  signal sigIn3 : STD_LOGIC_vector (3 downto 0) := "1000";
  signal sigOut : STD_LOGIC_VECTOR (3 downto 0);

begin

  uut : MUX4to1
    port map (inSelection => sigSelect, in0 => sigIn0, in1 => sigIn1, in2 => sigIn2, in3 => sigIn3, out0 => sigOut);

  procClock : process
  begin
    sigSelect <= "00";
    wait for 100ns;
    sigSelect <= "01";
    wait for 100ns;
    sigSelect <= "10";
    wait for 100ns;
    sigSelect <= "11";
    wait for 100ns;
  end process;


end Behavioral;
