-- Team 16 - 782716, 780962

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity BitSplitter is
    Port ( inBits : in STD_LOGIC_VECTOR (3 downto 0);
           inClock : in std_logic;
           inReset : in std_logic;
           outMSB : out STD_LOGIC_VECTOR (3 downto 0);
           outLSB : out STD_LOGIC_VECTOR (3 downto 0));
end BitSplitter;

architecture Behavioral of BitSplitter is

signal sigDataScroll : std_logic := '0';
signal sigHalfOne : std_logic_vector (1 downto 0);
signal sigHalfTwo : std_logic_vector (1 downto 0);

begin

    clock : process(inReset, inClock, inBits)
    begin
        if inReset = '1' then --This reset means that when the switches change this can be reset back to the first two bits
            sigDataScroll <= '0';
        elsif rising_edge(inClock) then
            sigDataScroll <= NOT sigDataScroll; --Toggle bits to scroll display
        end if;
    end process clock;

    --The following break each bit out and create the two outputs that will be scrolled thorugh

    --Break the 4 bits into two halves
    sigHalfOne <= inBits(3 downto 2);
    sigHalfTwo <= inBits(1 downto 0);

    --Places the left bit from the pair into the output
    with sigDataScroll select outMSB <=
        "000" & sigHalfOne(1) when '0',
        "000" & sigHalfTwo(1) when '1';

    --places the right bit form the pair into the output
    with sigDataScroll select outLSB <=
        "000" & sigHalfOne(0) when '0',
        "000" & sigHalfTwo(0) when '1';

end Behavioral;
