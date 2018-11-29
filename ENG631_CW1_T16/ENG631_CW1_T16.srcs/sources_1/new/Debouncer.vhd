--Team 16 - 780962 / 782716

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

---------------------------------------------------------------
--THIS IS UNUSED, PLANNED TO BE INCLUDED IN FUTURE MILESTONES--
---------------------------------------------------------------

entity Debouncer is
    Port ( Clock : in std_logic;
           Input : in STD_LOGIC;
           Output : out STD_LOGIC);
end Debouncer;

architecture Behavioral of Debouncer is

    shared variable lastState : std_logic;

begin





    debounce : process (input, clock)
    begin

        if rising_edge (input) then
            output <= input;
        else
            output <= '0';
        end if;


    end process debounce;

end Behavioral;
