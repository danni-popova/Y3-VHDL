
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Mod_TB is



end Mod_TB;

architecture Behavioral of Mod_TB is

component Modulator is
    Port ( inClock : in STD_LOGIC;
           inData : in STD_LOGIC_VECTOR (3 downto 0);
           outI : out STD_LOGIC_VECTOR (7 downto 0);
           outQ : out STD_LOGIC_VECTOR (7 downto 0);
           counter : out std_logic_vector (3 downto 0));
           
end component Modulator;

--Signals
  signal sigClock : STD_LOGIC := '0';
  signal sigData : STD_LOGIC_VECTOR (3 downto 0);
  signal sigI : STD_LOGIC_VECTOR (7 downto 0);
  signal sigQ : STD_LOGIC_VECTOR (7 downto 0); 
  signal counter : std_logic_vector (3 downto 0);

begin

UUT : Modulator
    port map (inClock => sigClock, inData => sigData, outI => sigI, outQ => sigQ, counter => counter);

  procClock : process
  begin
    sigClock <= '0';
    wait for 100ns;
    sigClock <= '1';
    wait for 100ns;
  end process;

sigData <= "0000";

end Behavioral;
