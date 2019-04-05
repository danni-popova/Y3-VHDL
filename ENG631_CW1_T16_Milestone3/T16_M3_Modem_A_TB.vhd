-- Team 16 - 782716, 780962

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity ModemA_tb is
--  Port ( );
end ModemA_tb;

architecture Behavioral of ModemA_tb is

component DemodulatorA is
    Port ( inClock : in STD_LOGIC;
       inI : in STD_LOGIC_VECTOR (7 downto 0);
       inQ : in STD_LOGIC_VECTOR (7 downto 0);
       outData : out STD_LOGIC_VECTOR (1 downto 0));
end component DemodulatorA;

component ModulatorA is
    Port ( inClock : in STD_LOGIC;
           inData : in STD_LOGIC_VECTOR (1 downto 0);
           outI : out STD_LOGIC_VECTOR (7 downto 0);
           outQ : out STD_LOGIC_VECTOR (7 downto 0);
           counter : out std_logic_vector (3 downto 0));
           
end component ModulatorA;

signal sigClock : STD_LOGIC := '0';
signal siginData : STD_LOGIC_VECTOR (1 downto 0);
signal sigoutdata : std_logic_vector(1 downto 0);
signal sigI : STD_LOGIC_VECTOR (7 downto 0);
signal sigQ : STD_LOGIC_VECTOR (7 downto 0); 
signal sigOutI : STD_LOGIC_VECTOR (7 downto 0);
signal sigOutQ : STD_LOGIC_VECTOR (7 downto 0); 
signal run : integer range 0 to 1 := 0;

begin

UUTmodulator : ModulatorA
port map (inClock => sigClock, inData => siginData, outI => sigI, outQ => sigQ, counter => open);
UUTdemodulator : DemodulatorA
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
--    if run = 0 then
--    wait for 0ns;
--    run <= 1;
--    end if;
    
    sigInData <= "00";
    wait for 1600ns;
    sigInData <= "01";
    wait for 1600ns;
    sigInData <= "10";
    wait for 1600ns;
    sigInData <= "11";
end process;

end Behavioral;
