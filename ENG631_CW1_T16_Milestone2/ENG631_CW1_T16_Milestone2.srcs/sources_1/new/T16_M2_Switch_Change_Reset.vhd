-- Team 16 - 782716, 780962

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity T16_M2_Switch_Change_Reset is
    Port ( inClock : in STD_LOGIC;
           inSwitches : in STD_LOGIC_VECTOR (2 downto 0);
           outResetPulse : out STD_LOGIC);
end T16_M2_Switch_Change_Reset;

architecture Behavioral of T16_M2_Switch_Change_Reset is

signal lastState : std_logic_vector (2 downto 0) := "000";
signal changeDetected : std_logic := '0';
shared variable pulseWidth : integer range 0 to 5;

begin


    reset : process (inClock, inSwitches)
    begin
        if rising_edge(inClock) then
            if ( lastState /= inSwitches ) then
                outResetPulse <= '1';
            else outResetPulse <= '0';
            end if;
            
            lastState <= inSwitches;
            
        end if;
    end process reset;
    
    --outResetPulse <= changeDetected;

end Behavioral;