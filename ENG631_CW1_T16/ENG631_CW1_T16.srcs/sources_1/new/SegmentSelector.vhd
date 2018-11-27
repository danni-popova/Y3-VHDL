library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SegmentSelector is
    Port ( inputDigit : in STD_LOGIC_VECTOR (3 downto 0);
           outputSegments : in STD_LOGIC_VECTOR(6 downto 0));
end SegmentSelector;

architecture Behavioral of SegmentSelector is


begin

--with inputDigit select
--    outputSegments <= "0000001" when 0, 
--                     "1001111" when 1, 
--                     "0010010" when 2,
--                     "0000110" when 3,
--                     "1001100" when 4,
--                     "0100100" when 5,
--                     "0100000" when 6,
--                     "0001111" when 7,
--                     "0000000" when 8,
--                     "0000100" when 9,
--                     "0000000" when others;

end Behavioral;
