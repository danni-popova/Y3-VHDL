-- Team 16 - 782716, 780962

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SwitchChangeReset is
    Port ( inClock : in STD_LOGIC;
           inSwitches : in STD_LOGIC_VECTOR (2 downto 0);
           outResetPulse : out STD_LOGIC);
end SwitchChangeReset;

architecture Behavioral of SwitchChangeReset is

signal lastState : std_logic_vector (2 downto 0) := "000";
signal changeDetected : std_logic := '0';
shared variable pulseWidth : integer range 0 to 5;

begin


    reset : process (inClock, inSwitches)
    begin
        if rising_edge(inClock) then
            if ( lastState /= inSwitches ) then
                --when the switches arent in the same state as the last time, set the output high
                outResetPulse <= '1';
            else
                --If there hasn;t been a change keep the output low
                outResetPulse <= '0';
            end if;
            -- store the state of the switches for comaprison
            lastState <= inSwitches;
        end if;
    end process reset;

end Behavioral;
