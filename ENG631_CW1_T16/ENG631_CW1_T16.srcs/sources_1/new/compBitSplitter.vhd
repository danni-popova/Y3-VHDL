----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04.02.2019 14:10:59
-- Design Name: 
-- Module Name: compBitSplitter - Behavioral
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

entity compBitSplitter is
    Port ( inBits : in STD_LOGIC_VECTOR (3 downto 0);
           inClock : in std_logic;
           inReset : in std_logic;
           outMSB : out STD_LOGIC_VECTOR (3 downto 0);
           outLSB : out STD_LOGIC_VECTOR (3 downto 0));
end compBitSplitter;

architecture Behavioral of compBitSplitter is

signal sigDataScroll : std_logic := '0';
signal sigHalfOne : std_logic_vector (1 downto 0);
signal sigHalfTwo : std_logic_vector (1 downto 0);

begin

    clock : process(inReset, inClock, inBits)
    begin
        if inReset = '1' then -- changes if the reset is high or the input changes
            sigDataScroll <= '0';
        elsif rising_edge(inClock) then
            sigDataScroll <= NOT sigDataScroll;
        end if;
    end process clock;
    
    sigHalfOne <= inBits(3 downto 2);
    sigHalfTwo <= inBits(1 downto 0);
    
    with sigDataScroll select outMSB <= 
        "000" & sigHalfOne(1) when '0',
        "000" & sigHalfTwo(1) when '1';
        
    with sigDataScroll select outLSB <= 
        "000" & sigHalfOne(0) when '0',
        "000" & sigHalfTwo(0) when '1';
        


end Behavioral;
