----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02.04.2019 13:47:42
-- Design Name: 
-- Module Name: modemAComponent_tb - Behavioral
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

entity modemAComponent_tb is
--  Port ( );
end modemAComponent_tb;

architecture Behavioral of modemAComponent_tb is

component modemA is
    Port ( inClock : in STD_LOGIC;
           inData : in STD_LOGIC_VECTOR (1 downto 0);
           inSwitches : in std_logic_vector (1 downto 0);
           outData : out STD_LOGIC_VECTOR (1 downto 0));
end component modemA;

signal sigInData : std_logic_vector (1 downto 0);
signal sigoutData : std_logic_vector (1 downto 0);
signal sigSwitches : std_logic_vector (1 downto 0);
signal sigClock : std_logic ;



begin

UUTmodem : modemA
    port map(inData => sigInData, inClock => sigClock, outData => sigOutData, inSwitches => sigSwitches);

clock : process
begin
    sigClock <= '0';
    wait for 100ns;
    sigClock <= '1';
    wait for 100ns;
end process;

procData : process
begin    
    sigInData <= "00";
    wait for 1600ns;
    sigInData <= "01";
    wait for 1600ns;
    sigInData <= "10";
    wait for 1600ns;
    sigInData <= "11";
    wait for 1600ns;
end process;

sigSwitches <= "00";


end Behavioral;
