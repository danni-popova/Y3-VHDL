-- Team 16 - 782716, 780962

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ClockDivider is
    Generic ( MaxCount : integer range 0 to 400000000 );
    Port ( reset : in STD_LOGIC;
           clock : in STD_LOGIC;
           clockOut : out STD_LOGIC );
end ClockDivider;

architecture Behavioral of ClockDivider is

shared variable counter : integer range 0 to 400000000;

begin

    --Counter that will count to the nimber from the generic, and then send a Pulse
    --at the maximum number and wrap round to zero, in effect creating a slower clock

    clockEnable : process (clock, reset)
    begin
        if reset = '1' then
            counter := 0;
            clockOut <= '0';
        elsif rising_edge(clock) then
            clockOut <= '0';
            if counter < MaxCount - 1 then
                counter := counter + 1;
            else
                counter := 0;
                clockOut <= '1';
            end if;
        end if;


    end process clockEnable;

end Behavioral;
