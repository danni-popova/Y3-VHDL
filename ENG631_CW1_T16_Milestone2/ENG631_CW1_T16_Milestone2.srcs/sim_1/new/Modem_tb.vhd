----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01.04.2019 15:10:37
-- Design Name: 
-- Module Name: Modem_tb - Behavioral
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

entity Modem_tb is
--  Port ( );
end Modem_tb;

architecture Behavioral of Modem_tb is

component Demodulator is
    Port ( inClock : in STD_LOGIC;
       inI : in STD_LOGIC_VECTOR (7 downto 0);
       inQ : in STD_LOGIC_VECTOR (7 downto 0);
       outData : out STD_LOGIC_VECTOR (3 downto 0));
end component Demodulator;

component Modulator is
    Port ( inClock : in STD_LOGIC;
           inData : in STD_LOGIC_VECTOR (3 downto 0);
           outI : out STD_LOGIC_VECTOR (7 downto 0);
           outQ : out STD_LOGIC_VECTOR (7 downto 0);
           counter : out std_logic_vector (3 downto 0));
           
end component Modulator;

signal sigClock : STD_LOGIC := '0';
signal siginData : STD_LOGIC_VECTOR (3 downto 0);
signal sigoutdata : std_logic_vector(3 downto 0);
signal sigI : STD_LOGIC_VECTOR (7 downto 0);
signal sigQ : STD_LOGIC_VECTOR (7 downto 0); 
signal sigOutI : STD_LOGIC_VECTOR (7 downto 0);
signal sigOutQ : STD_LOGIC_VECTOR (7 downto 0); 
signal run : integer range 0 to 1 := 0;

begin

UUTmodulator : Modulator
port map (inClock => sigClock, inData => siginData, outI => sigI, outQ => sigQ, counter => open);
UUTdemodulator : Demodulator
port map (inClock => sigClock, outData => sigoutData, inI => sigI, inQ => sigQ);

procClock : process
begin
    sigClock <= '0';
    wait for 100ns;
    sigClock <= '1';
    wait for 100ns;
end process;

procData : process
begin
    if run = 0 then
    wait for 2900ns;
    run <= 1;
    end if;
    
    sigInData <= "0000";
    wait for 3200ns;
    sigInData <= "0001";
    wait for 3200ns;
    sigInData <= "0010";
    wait for 3200ns;
    sigInData <= "0011";
    wait for 3200ns;
    sigInData <= "0100";
    wait for 3200ns;
end process;

end Behavioral;
