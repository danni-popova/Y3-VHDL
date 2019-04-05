-- Team 16 - 782716, 780962

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ModB_tb is
--  Port ( );
end ModB_tb;

    architecture Behavioral of ModB_tb is
    component ModulatorB is
        Port ( inClock : in STD_LOGIC;
               inData : in STD_LOGIC_VECTOR (1 downto 0);
               outI : out STD_LOGIC_VECTOR (7 downto 0);
               outQ : out STD_LOGIC_VECTOR (7 downto 0));
               
    end component ModulatorB;
    
    --Signals
      signal sigClock : STD_LOGIC := '0';
      signal sigData : STD_LOGIC_VECTOR (1 downto 0);
      signal sigI : STD_LOGIC_VECTOR (7 downto 0);
      signal sigQ : STD_LOGIC_VECTOR (7 downto 0); 
    
    begin
    
    UUT : ModulatorB
        port map (inClock => sigClock, inData => sigData, outI => sigI, outQ => sigQ);
    
      procClock : process
      begin
        sigClock <= '0';
        wait for 100ns;
        sigClock <= '1';
        wait for 100ns;
      end process;
    
    sigData <= "11";
end Behavioral;
