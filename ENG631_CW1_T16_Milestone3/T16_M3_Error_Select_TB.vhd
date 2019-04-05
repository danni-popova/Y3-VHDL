-- Team 16 - 782716, 780962

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ErrorSelect_TB is
--
end ErrorSelect_TB;

architecture Behavioral of ErrorSelect_TB is

component ErrorSelect is
    Port(
        inClock : in STD_LOGIC; 
        inData : in STD_LOGIC_VECTOR (7 downto 0);
        inSwitches : in STD_LOGIC_VECTOR(1 downto 0);
        inReset : in STD_LOGIC;
        outData : out STD_LOGIC_VECTOR(7 downto 0)
        );
end  component ErrorSelect;

signal sigClock : std_logic; 
signal sigData : std_logic_vector(7 downto 0); 
signal sigSwitches : std_logic_vector(1 downto 0);
signal sigReset : std_logic; 
signal sigOutData : std_logic_vector(7 downto 0);

begin

UUT : ErrorSelect 
port map (inClock => sigClock, inData => sigData, inSwitches => sigSwitches,
          inReset => sigReset, outData => sigOutData);

procClock : process 
begin 

    sigClock <= '0'; 
    wait for 100ns; 
    
    sigClock <= '1';
    wait for 100ns;
    
end process; 

-- Use I wave to test Error Select applied
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
