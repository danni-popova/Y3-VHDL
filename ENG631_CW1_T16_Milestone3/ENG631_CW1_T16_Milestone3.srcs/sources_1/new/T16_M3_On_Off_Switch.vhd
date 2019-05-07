-- Team 16 - 782716, 780962

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity OnOffSwitch is
    Port ( inClock : in std_logic;
           inPulse : in STD_LOGIC;
           outState : out STD_LOGIC);
end OnOffSwitch;

architecture Behavioral of OnOffSwitch is

signal sigOnOff : std_logic := '0';

signal lastState : std_logic := '0';

begin

    toggle : process (inClock)
    begin
        if rising_edge(inClock) then --Clock pulse to make sure it doesn't toggle constantly
            sigOnOff <= inPulse XOR sigOnOff; --Toggle! If both are high, set output to low, when the pulse is high and output is low set the output high
        end if;
    end process toggle;

     outState <= sigOnOff;

end Behavioral;
