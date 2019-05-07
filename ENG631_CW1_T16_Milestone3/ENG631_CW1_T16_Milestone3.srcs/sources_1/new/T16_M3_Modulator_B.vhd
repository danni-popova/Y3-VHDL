-- Team 16 - 782716, 780962

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ModulatorB is
    Port ( inClock : in STD_LOGIC;
           inData : in STD_LOGIC_VECTOR (1 downto 0);
           outI : out STD_LOGIC_VECTOR (7 downto 0);
           outQ : out STD_LOGIC_VECTOR (7 downto 0));
end ModulatorB;

architecture Behavioral of ModulatorB is

type waveArray is array (7 downto 0) of std_logic_vector (7 downto 0);

   -- I
   constant zeroWave : waveArray := ("01100000", "01000000", "01100000", "10000000", "10100000", "11000000", "10100000", "10000000");
   -- Q
   constant oneWave : waveArray := ("10100000", "11000000", "10100000", "10000000", "01100000", "01000000", "01100000", "10000000");
   
   
   signal firstBits : std_logic_vector (1 downto 0);
   
   signal lastBits : std_logic_vector (1 downto 0);
   
   signal count : integer range 0 to 15 := 0;

begin

transmit : process (inClock)
begin
    --Transmit data here
    --I Wave
    if rising_edge(inClock) then
    
        case inData is
            when "00" =>
                outI <= zeroWave(count);
                outQ <= "10000000";
            when "10" =>
                outI <= "10000000";
                outQ <= zeroWave(count);
            when "11" =>
                outI <= oneWave(count);
                outQ <= "10000000";
            when "01" =>
                outI <= "10000000";
                outQ <= oneWave(count);
            when others =>
                outI <= "10000000";
                outQ <= "10000000";
        end case;
            
        if count < 7 then
            count <= count + 1;
        else
            count <= 0;
        end if;
        
    end if;
    

end process transmit;


end Behavioral;
