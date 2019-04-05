----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01.04.2019 13:41:16
-- Design Name: 
-- Module Name: Demodulator_tb - Behavioral
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

entity DemodulatorA_tb is
--  Port ( );
end DemodulatorA_tb;

architecture Behavioral of DemodulatorA_tb is

component DemodulatorA is
    Port ( inClock : in STD_LOGIC;
           inI : in STD_LOGIC_VECTOR (7 downto 0);
           inQ : in STD_LOGIC_VECTOR (7 downto 0);
           outData : out STD_LOGIC_VECTOR (1 downto 0));
end component DemodulatorA;

signal sigClock : STD_LOGIC := '0';
signal sigData : STD_LOGIC_VECTOR (1 downto 0);
signal sigI : STD_LOGIC_VECTOR (7 downto 0);
signal sigQ : STD_LOGIC_VECTOR (7 downto 0); 
signal run : integer range 0 to 1 := 0;
--signal counter : std_logic_vector (3 downto 0);

begin

UUT : DemodulatorA
    port map (inClock => sigClock, outData => sigData, inI => sigI, inQ => sigQ);
    
procClock : process
begin
    sigClock <= '0';
    wait for 100ns;
    sigClock <= '1';
    wait for 100ns;
end process;
  
procDataprocess: process
begin
    if run = 0 then
    wait for 100ns;
    run <= 1;
    end if;
    
    sigI <= "10100000";
    sigQ <= "01100000";
    wait for 200ns;
    sigI <= "11000000";
    sigQ <= "01000000";
    wait for 200ns;
    sigI <= "10100000";
    sigQ <= "01100000";
    wait for 200ns;
    sigI <= "10000000";
    sigQ <= "10000000";
    wait for 200ns;
    sigI <= "01100000";
    sigQ <= "10100000";
    wait for 200ns;
    sigI <= "01000000";
    sigQ <= "11000000";
    wait for 200ns;
    sigI <= "01100000";
    sigQ <= "10100000";
    wait for 200ns;
    sigI <= "10000000";
    sigQ <= "10000000";
    wait for 200ns;
    
    sigI <= "10100000";
    sigQ <= "10100000";
    wait for 200ns;
    sigI <= "11000000";
    sigQ <= "11000000";
    wait for 200ns;
    sigI <= "10100000";
    sigQ <= "10100000";
    wait for 200ns;
    sigI <= "10000000";
    sigQ <= "10000000";
    wait for 200ns;
    sigI <= "01100000";
    sigQ <= "01100000";
    wait for 200ns;
    sigI <= "01000000";
    sigQ <= "01000000";
    wait for 200ns;
    sigI <= "01100000";
    sigQ <= "01100000";
    wait for 200ns;
    sigI <= "10000000";
    sigQ <= "10000000";
    wait for 200ns;
    
    sigI <= "10100000";
    sigQ <= "10100000";
    wait for 200ns;
    sigI <= "11000000";
    sigQ <= "11000000";
    wait for 200ns;
    sigI <= "10100000";
    sigQ <= "10100000";
    wait for 200ns;
    sigI <= "10000000";
    sigQ <= "10000000";
    wait for 200ns;
    sigI <= "01100000";
    sigQ <= "01100000";
    wait for 200ns;
    sigI <= "01000000";
    sigQ <= "01000000";
    wait for 200ns;
    sigI <= "01100000";
    sigQ <= "01100000";
    wait for 200ns;
    sigI <= "10000000";
    sigQ <= "10000000";
    wait for 200ns;
                        

end process;


end Behavioral;
