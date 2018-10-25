----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/24/2018 06:01:06 PM
-- Design Name: 
-- Module Name: BinaryDecimalConverter - Behavioral
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

entity BinaryDecimalConverter is
    Port ( inBinaryNumber : in STD_LOGIC_VECTOR (13 downto 0);
           outUnits : in STD_LOGIC_VECTOR (4 downto 0);
           outTens : in STD_LOGIC_VECTOR (4 downto 0);
           outHundreds : in STD_LOGIC_VECTOR (4 downto 0);
           outThousands : in STD_LOGIC_VECTOR (4 downto 0));
end BinaryDecimalConverter;

architecture Behavioral of BinaryDecimalConverter is

begin


end Behavioral;
