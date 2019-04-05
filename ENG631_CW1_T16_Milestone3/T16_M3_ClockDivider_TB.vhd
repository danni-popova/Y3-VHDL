-- Team 16 - 782716, 780962

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity T16_M2_ClockDivider_TB is

end T16_M2_ClockDivider_TB;

architecture Behavioral of T16_M2_ClockDivider_TB is

component ClockDivider 
    Generic ( MaxCount : integer range 0 to 400000000 );
    Port ( reset : in STD_LOGIC;
           clock : in STD_LOGIC;
           clockOut : out STD_LOGIC );
    end component;
    
    signal reset : std_logic := '0'; 
    signal clock : std_logic := '0'; 
    signal clockOut : std_logic :='0' ;

begin

    UUT : ClockDivider
    generic map(MaxCount => 10)
    port map (reset => reset, clock => clock, clockOut => clockOut);
    
    sysClock: process
    begin 
        clock <= '0';
        wait for 100ns;
        clock <= '1';
        wait for 100ns;
    end process;

end Behavioral;
