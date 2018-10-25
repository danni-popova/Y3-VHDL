----------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date: 10/24/2018 06:01:06 PM
-- Design Name:
-- Module Name: MUX4to1 - Behavioral
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

entity MUX4to1 is
    Port ( inSelection : in STD_LOGIC_VECTOR (2 downto 0);
           in0 : in STD_LOGIC_VECTOR (4 downto 0);
           in1 : in STD_LOGIC_VECTOR (4 downto 0);
           in2 : in STD_LOGIC_VECTOR (4 downto 0);
           in3 : in STD_LOGIC_VECTOR (4 downto 0);
           out0 : in STD_LOGIC_VECTOR (7 downto 0));
end MUX4to1;

architecture Behavioral of MUX4to1 is

begin


end Behavioral;
