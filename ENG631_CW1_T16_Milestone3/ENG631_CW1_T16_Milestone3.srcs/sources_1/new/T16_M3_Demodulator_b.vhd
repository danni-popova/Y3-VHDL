-- Team 16 - 782716, 780962

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity DemodulatorB is
    Port ( inClock : in STD_LOGIC;
           inI : in STD_LOGIC_VECTOR (7 downto 0);
           inQ : in STD_LOGIC_VECTOR (7 downto 0);
           outData : out STD_LOGIC_VECTOR (1 downto 0));
end DemodulatorB;

architecture Behavioral of DemodulatorB is

signal accumulatorI : integer range -30000 to 30000 := 0;

signal accumulatorQ : integer range -30000 to 30000 := 0;

signal tempI : integer range -30000 to 30000 := 0;

signal tempQ : integer range -30000 to 30000 := 0;

signal firstBits : std_logic_vector(1 downto 0);

signal lastBits : std_logic_vector(1 downto 0);

signal count : integer range 0 to 8 := 6;

type referenceWaveArray is array (7 downto 0) of integer range -64 to 64;

constant referenceWave : referenceWaveArray := (-32, -64, -32, 0, 32, 64, 32, 0);

begin


accumulate : process (inClock)
begin
    if rising_edge(inClock) then
        --Firstly when the count is zero we can use the accumulated value to determine the outputs
        --Decision Logic
        if count = 0 then
            if abs(accumulatorI) > abs(accumulatorQ) then
            --signal is on I
                if accumulatorI > 0 then
                    outData(1) <= '0';
                    outdata(0) <= '0';
                else
                    outdata(1) <= '1';
                    outdata(0) <= '1';
                end if;
            
            else
                --signal is on Q
                if accumulatorQ > 0 then
                    outData(0) <='0';
                    outdata(1) <= '1';
                else
                    outdata(0) <='1';
                    outdata(1) <= '0';
                end if;
            end if;
        end if;
    
    
        if count = 0 then
        --Accumulate without past value, this is because it's a new loop
            accumulatorI <= referenceWave(count) * to_integer(unsigned(inI));
            accumulatorQ <= referenceWave(count) * to_integer(unsigned(inQ));
        else
            --Accumulate onto new value
            accumulatorI <= accumulatorI + referenceWave(count) * to_integer(unsigned(inI));
            accumulatorQ <= accumulatorQ + referenceWave(count) * to_integer(unsigned(inQ));
        end if;
        
        if count < 7 then
        --While the counter is less than 7 we can increment
            count <= count + 1;
        else
        --On the seventh pass it needs to be reset.
            count <= 0;
        end if;
    end if;
    
end process accumulate;

--decide : process (inClock)
--begin

--end process decide;

end Behavioral;
