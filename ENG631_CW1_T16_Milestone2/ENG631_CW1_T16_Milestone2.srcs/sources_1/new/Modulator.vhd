----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 29.03.2019 10:57:10
-- Design Name: 
-- Module Name: Modulator - Behavioral
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
use ieee.std_logic_arith.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Modulator is
    Port ( inClock : in STD_LOGIC;
           inData : in STD_LOGIC_VECTOR (3 downto 0);
           outI : out STD_LOGIC_VECTOR (7 downto 0);
           outQ : out STD_LOGIC_VECTOR (7 downto 0);
           counter : out STD_LOGIC_VECTOR (3 downto 0));
end Modulator;

architecture Behavioral of Modulator is

type waveArray is array (7 downto 0) of std_logic_vector (7 downto 0);

   -- I
    constant zeroWave : waveArray := ("01100000", "01000000", "01100000", "10000000", "10100000", "11000000", "10100000", "10000000");
   -- Q
   constant oneWave : waveArray := ("10100000", "11000000", "10100000", "10000000", "01100000", "01000000", "01100000", "10000000");
   
   
   signal firstBits : std_logic_vector (1 downto 0);
   
   signal lastBits : std_logic_vector (1 downto 0);
   
   signal count : integer range 0 to 15;

begin

--Split Vector

firstBits <= inData(3 downto 2);
lastBits <= inData(1 downto 0);
counter <= conv_std_logic_vector(count, counter'length);


transmit : process (inClock)
begin
    --Transmit data here
    --I Wave
    if rising_edge(inClock) then
            
        if count < 8 then
            if firstBits(1) = '1' then
                outI <= oneWave(count);
            elsif firstBits(1) = '0' then
                outI <= zeroWave(count);
            end if;
            
            if firstBits(0) = '1' then
                outQ <= oneWave(count);
            elsif firstBits(0) = '0' then
                outQ <= zeroWave(count);
            end if;
        elsif count < 16 then
            if lastBits(1) = '1' then
                outI <= oneWave(count - 8);
            elsif lastBits(1) = '0' then
                outI <= zeroWave(count - 8);
            end if;
            
            if lastBits(0) = '1' then
                outQ <= oneWave(count - 8);
            elsif lastBits(0) = '0' then
                outQ <= zeroWave(count - 8);
            end if;
        end if;
        
        if count < 15 then
            count <= count + 1;
        else
            count <= 0;
        end if;
        
    end if;
    

end process transmit;

end Behavioral;
