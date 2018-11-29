--Team 16 - 780962 / 782716

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SegmentSelector is
    Port ( inDecimal : in STD_LOGIC_VECTOR (3 downto 0);
           outSegments : out STD_LOGIC_VECTOR (7 downto 0));
end SegmentSelector;

architecture Behavioral of SegmentSelector is

begin

  --A lookup table that takes an input number, and turns on the corresponding
  --bits on the 7-segment display
  --Decimal point is the MSB
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
                    "01111111" when others; -- (.) Other Case

end Behavioral;
