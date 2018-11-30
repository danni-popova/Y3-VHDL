--Team 16 - 780962 / 782716

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ClockDivider is
    Generic ( MaxCount : integer range 0 to 400000000 );
    Port ( reset : in STD_LOGIC;
           clock : in STD_LOGIC;
           clockOut : out STD_LOGIC );
end ClockDivider;

architecture Behavioral of ClockDivider is

--signals
shared variable counter : integer range 0 to 400000000;

begin

    clockEnable : process (clock, reset)
    begin
        if reset = '1' then
            --When the reset is high, the counter can be reset, and the output would be low
            counter := 0;
            clockOut <= '0';
        elsif rising_edge(clock) then
            --If this wasn't triggered by a reset, we need to make sure the output is low
            clockOut <= '0';
            if counter < MaxCount - 1 then
                --If we haven't reached our target, increase the counter
                counter := counter + 1;
            else
                --if we've reached the target the pulse is set high and the counter reset
                --Doing this here means that on the next cycle it is reset low,
                --creating the pulse equal to the width of a clock pulse
                counter := 0;
                clockOut <= '1';
            end if;
        end if;


    end process clockEnable;

end Behavioral;
