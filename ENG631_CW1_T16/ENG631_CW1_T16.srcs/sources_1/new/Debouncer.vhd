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
