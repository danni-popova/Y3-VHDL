----------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date: 10/24/2018 06:01:06 PM
-- Design Name:
-- Module Name: SegmentSelector - Behavioral
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

entity SegmentSelector is
    Port ( inDecimal : in STD_LOGIC_VECTOR (3 downto 0);
           outSegments : out STD_LOGIC_VECTOR (7 downto 0));
end SegmentSelector;

architecture Behavioral of SegmentSelector is

begin

  with inDecimal select
    outSegments <=  "00000010" when "0000", -- 0
                    "10011110" when "0001", -- 1
                    "00100100" when "0010", -- 2
                    "00001100" when "0011", -- 3
                    "10011000" when "0100", -- 4
                    "01001000" when "0101", -- 5
                    "01000000" when "0110", -- 6
                    "00011110" when "0111", -- 7
                    "00000000" when "1000", -- 8
                    "00001000" when "1001", -- 9
                    "00000001" when others; -- (.) Other Case

end Behavioral;
