----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 23.10.2018 16:06:47
-- Design Name: 
-- Module Name: ClockDivider_tb - Behavioral
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

entity ClockDivider_tb is
--  Port ( );
end ClockDivider_tb;

architecture Behavioral of ClockDivider_tb is

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

    uut : ClockDivider
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
