-- Team 16 - 782716, 780962

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Debouncer is
    Port ( Clock : in std_logic;
           Input : in STD_LOGIC;
           Output : out STD_LOGIC);
end Debouncer;

architecture Behavioral of Debouncer is

shared variable highCount : integer range 0 to 1000000000;
signal lastState : std_logic;

begin

    debounce : process (clock)
    begin
      if rising_edge(clock) then
          output <= '0';
          lastState <= input;

          if input = '1' then
              if lastState = input then --if the states are different this means there was a bounce, this is what smothes that out
                highCount := highCount + 1; --High count stores the number of times it has been consectuively high
              else
                highCount := 0;
              end if;
          end if;

          if highCount = 5000000 then --When it has been high for the selected number of times a pulse is created
            Output <= '1';
          end if;

          --Means that if you hold the button it will repeat the pulse every second.
          if highCount > 100000000 then --After it reaches this number it wraps back to zero.
            highCount := 0;
          end if;
      end if;

    end process debounce;

end Behavioral;
