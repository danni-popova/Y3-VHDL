library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity Demodulator is
    Port ( inClock : in STD_LOGIC;
           inI : in STD_LOGIC_VECTOR (7 downto 0);
           inQ : in STD_LOGIC_VECTOR (7 downto 0);
           outData : out STD_LOGIC_VECTOR (3 downto 0));
end Demodulator;

architecture Behavioral of Demodulator is

signal accumulatorI : integer range -30000 to 30000 := 0;

signal accumulatorQ : integer range -30000 to 30000 := 0;

signal tempI : integer range -30000 to 30000 := 0;

signal tempQ : integer range -30000 to 30000 := 0;

signal firstBits : std_logic_vector(1 downto 0);

signal lastBits : std_logic_vector(1 downto 0);

signal count : integer range 0 to 17 := 1;

type referenceWaveArray is array (7 downto 0) of integer range -64 to 64;

constant referenceWave : referenceWaveArray := (0, 32, 64, 32, 0, -32, -64, -32);

begin

--updatePins : process ()
--begin



--end process updatePins;

demodulate : process (inClock)
begin

  if rising_edge(inClock) then
    --Accumulator Logic
    if count = 16 then
        outData(3 downto 2) <= firstBits;
        
        outData(1 downto 0) <= lastBits;
        count <= 0;
        accumulatorQ <= 0;
        accumulatorI <= 0;
    end if;
    if count = 8 then
            if accumulatorI > 0 then
                firstBits(1) <= '0';
            else
                firstBits(1) <= '1';
            end if;
            
            if accumulatorQ > 0 then
                firstBits(0) <= '0';
            else
                firstBits(0) <= '1';
            end if;
            
            accumulatorQ <= 0;
            accumulatorI <= 0;
        end if;
        
        if count = 16 then
            if accumulatorI > 0 then
                lastBits(1) <= '1';
            else
                lastBits(1) <= '0';
            end if;
            
            if accumulatorQ > 0 then
                lastBits(0) <= '1';
            else
                lastBits(0) <= '0';
            end if;
        end if;
    
    if count < 8 then
        accumulatorI <= accumulatorI + (referenceWave(7 - count) * to_integer(unsigned(inI)));
        accumulatorQ <= accumulatorQ + (referenceWave(7 - count) * to_integer(unsigned(inQ)));
    elsif count = 8 then
        accumulatorI <= 0 + (referenceWave(7 - (count - 8)) * to_integer(unsigned(inI)));
        accumulatorQ <= 0 + (referenceWave(7 - (count - 8)) * to_integer(unsigned(inQ)));       
    elsif count < 16 then
        accumulatorI <= accumulatorI + (referenceWave(7 - (count - 8)) * to_integer(unsigned(inI)));
        accumulatorQ <= accumulatorQ + (referenceWave(7 - (count - 8)) * to_integer(unsigned(inQ)));        
    end if;
    
    count <= count + 1;
    
    

  end if;

end process demodulate;

end Behavioral;
