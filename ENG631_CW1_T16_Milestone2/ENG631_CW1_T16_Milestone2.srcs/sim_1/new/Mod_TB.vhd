
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ModA_TB is



end ModA_TB;

architecture Behavioral of ModA_TB is

component ModulatorA is
    Port ( inClock : in STD_LOGIC;
           inData : in STD_LOGIC_VECTOR (1 downto 0);
           outI : out STD_LOGIC_VECTOR (7 downto 0);
           outQ : out STD_LOGIC_VECTOR (7 downto 0);
           counter : out std_logic_vector (3 downto 0));
           
end component ModulatorA;

--Signals
  signal sigClock : STD_LOGIC := '0';
  signal sigData : STD_LOGIC_VECTOR (1 downto 0);
  signal sigI : STD_LOGIC_VECTOR (7 downto 0);
  signal sigQ : STD_LOGIC_VECTOR (7 downto 0); 
  signal counter : std_logic_vector (3 downto 0);

begin

UUT : ModulatorA
    port map (inClock => sigClock, inData => sigData, outI => sigI, outQ => sigQ, counter => counter);

  procClock : process
  begin
    sigClock <= '0';
    wait for 100ns;
    sigClock <= '1';
    wait for 100ns;
  end process;

sigData <= "01";

end Behavioral;
