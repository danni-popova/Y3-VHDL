----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.11.2018 11:34:28
-- Design Name: 
-- Module Name: Debouncer - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Debouncer is
    Port ( Clock : in std_logic;
           Input : in STD_LOGIC;
           Output : out STD_LOGIC);
end Debouncer;



architecture Behavioral of Debouncer is

shared variable highCount : integer range 0 to 100000000;
signal lastState : std_logic;

begin



    debounce : process (input, clock)    
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
          
          if highCount = 6250000 then
            Output <= '1';
          end if;
          
          if highCount > 99999999 then 
            highCount := 0;
          end if;
      end if;
      
    end process debounce;

end Behavioral;
