-- Team 16 - 782716, 780962

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Modem_B_Component_TB is
--  Port ( );
end Modem_B_Component_TB;

architecture Behavioral of Modem_B_Component_TB is

component ModemB is
    Port ( inClock : in STD_LOGIC;
           inData : in STD_LOGIC_VECTOR (1 downto 0);
           inSwitches : in std_logic_vector (1 downto 0);
           outData : out STD_LOGIC_VECTOR (1 downto 0));
end component ModemB;

signal sigInData : std_logic_vector (1 downto 0);
signal sigoutData : std_logic_vector (1 downto 0);
signal sigSwitches : std_logic_vector (1 downto 0);
signal sigClock : std_logic ;



begin

UUTmodem : ModemB
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

-- Test with different values of switches - 00 , 01, 10, 11
sigSwitches <= "00";

end Behavioral;
