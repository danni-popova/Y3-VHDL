library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity ClockDivider is
    Port ( inputReset : in STD_LOGIC;
           inputClock : in STD_LOGIC;
           inputFast : in STD_LOGIC;
           outputClock : out STD_LOGIC);
end ClockDivider;

architecture Behavioral of ClockDivider is

    signal sigCounter : integer range 0 to 400000000;

begin

    clock_divider: Process (inputReset, inputClock, inputFast, sigCounter)
    begin 
        if inputReset = '1' then 
            sigCounter <= 0;
        elsif rising_edge(inputClock) then 
            if sigCounter >= (40000000-1) then 
               sigCounter <= 0;
            else 
                if inputFast = '1' then 
                    sigCounter <= sigCounter + 1000; 
                else 
                    sigCounter <= sigCounter + 1; 
                end if;
            end if;
        end if;
    end process clock_divider;
    
end Behavioral;
