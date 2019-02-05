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
              if lastState = input then 
                highCount := highCount + 1;
              else 
                highCount := 0;
              end if;
          end if;
          
          if highCount = 20000000 then
            Output <= '1';
          end if;
          
          if highCount > 100000000 then 
            highCount := 0;
          end if;
      end if;
      
    end process debounce;

end Behavioral;
