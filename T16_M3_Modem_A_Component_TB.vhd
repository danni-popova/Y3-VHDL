library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity modemAComponent_tb is
--  Port ( );
end modemAComponent_tb;

architecture Behavioral of Modem_A_Component_TB is

component ModemA is
    Port ( inClock : in STD_LOGIC;
           inClock2hz : in std_logic;
           inData : in STD_LOGIC_VECTOR (3 downto 0);
           inSwitches : in std_logic_vector (1 downto 0);
           outData : out STD_LOGIC_VECTOR (3 downto 0));
end component ModemA;

signal sigInData : std_logic_vector (3 downto 0);
signal sigoutData : std_logic_vector (3 downto 0);
signal sigSwitches : std_logic_vector (1 downto 0);
signal sigClock : std_logic ;
signal sigClock2Hz : std_logic;



begin

UUTmodem : ModemA
    port map(inData => sigInData, inClock => sigClock, outData => sigOutData, inSwitches => sigSwitches, inClock2Hz => sigClock2Hz);

clock : process
begin
    sigClock <= '0';
    wait for 100ns;
    sigClock <= '1';
    wait for 100ns;
end process;

clock2 : process
begin
    sigClock2Hz <= '0';
    wait for 1500ns;
    sigClock2Hz <= '1';
    wait for 100ns;
end process;

procData : process
begin    
    sigInData <= "1111";
    wait for 1600ns;
    sigInData <= "1111";
    wait for 1600ns;
    sigInData <= "0000";
    wait for 1600ns;
    sigInData <= "1111";
    wait for 1600ns;
    sigInData <= "1111";
    wait for 1600ns;
    sigInData <= "1111";
    wait for 1600ns;
    sigInData <= "1010";
    wait for 1600ns;
    sigInData <= "1111";
    wait for 1600ns;
end process;

sigSwitches <= "00";


end Behavioral;
