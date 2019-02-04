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
    outSegments <=  "10000001" when "0000", -- 0
                    "11001111" when "0001", -- 1
                    "10010010" when "0010", -- 2
                    "10000110" when "0011", -- 3
                    "11001100" when "0100", -- 4
                    "10100100" when "0101", -- 5
                    "10100000" when "0110", -- 6
                    "10001111" when "0111", -- 7
                    "10000000" when "1000", -- 8
                    "10000100" when "1001", -- 9
                    "10001000" when "1010", -- A
                    "11100000" when "1011", -- B
                    "10110001" when "1100", -- C
                    "11000010" when "1101", -- D
                    "10110000" when "1110", -- E
                    "10111000" when "1111", -- F
                    "01111111" when others; -- (.) Other Case

end Behavioral;
