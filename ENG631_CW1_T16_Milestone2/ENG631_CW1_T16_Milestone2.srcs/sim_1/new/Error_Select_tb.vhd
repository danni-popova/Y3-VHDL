library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity Error_Select_tb is
end Error_Select_tb;

architecture Behavioral of Error_Select_tb is

component compError is
    Port(
        inClock : in STD_LOGIC; 
        inData : in STD_LOGIC_VECTOR (7 downto 0);
        inSwitches : in STD_LOGIC_VECTOR(1 downto 0);
        inReset : in STD_LOGIC;
        outData : out STD_LOGIC_VECTOR(7 downto 0)
        );
end  component compError;

signal sigClock : std_logic; 
signal sigData : std_logic_vector(7 downto 0); 
signal sigSwitches : std_logic_vector(1 downto 0);
signal sigReset : std_logic; 
signal sigOutData : std_logic_vector(7 downto 0);

begin

UUT : compError 
port map (inClock => sigClock, inData => sigData, inSwitches => sigSwitches,
          inReset => sigReset, outData => sigOutData);

procClock : process 
begin 

    sigClock <= '0'; 
    wait for 100ns; 
    
    sigClock <= '1';
    wait for 100ns;
    
end process; 

--("01100000", "01000000", "01100000", "10000000",   "10100000", "11000000", "10100000", "10000000");

procData: process 
begin 
    sigData <= "01100000";
    wait for 200ns;
    
    sigData <= "01000000";
        wait for 200ns;
        
    sigData <= "01100000";
        wait for 200ns;

    sigData <= "10000000";
        wait for 200ns;
        
        --
        
    sigData <= "10100000";
    wait for 200ns;
        
    sigData <= "11000000";
    wait for 200ns;
            
    sigData <= "10100000";
    wait for 200ns;
    
    sigData <= "10000000";
    wait for 200ns;

end process; 

sigSwitches <= "01";

end Behavioral;
