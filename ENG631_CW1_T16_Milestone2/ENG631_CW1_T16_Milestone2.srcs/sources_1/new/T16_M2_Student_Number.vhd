-- Team 16 - 782716, 780962

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity StudentNumber is

    Port(
         inClock : in std_logic;
         inReset : in std_logic;
         inSetting : in std_logic_vector (2 downto 0);
         outData : out std_logic_vector (3 downto 0));
  
end StudentNumber;

architecture Behavioral of StudentNumber is

   type studentNumberArray is array (5 downto 0) of std_logic_vector (3 downto 0); 
   
   -- first student number
   constant constStudentNumberDanni : studentNumberArray := ("0110", "0001", "0111", "0010", "1000", "0111");
   
   -- second student number 
   constant constStudentNumberTom : studentNumberArray := ("0010", "0110", "1001", "0000", "1000", "0111");
   
   -- for switching between the digits
   signal signalCounter : integer range 0 to 5;
   
   -- to assign digit to
   signal signalDigit : std_logic_vector (3 downto 0); 

begin

    changeDigit : Process(inClock, inReset) 
    begin
            if inReset = '1' then 
               signalCounter <= 0; 
           elsif rising_edge(inClock)then
               if signalCounter < 5 then 
                    signalCounter <= signalCounter + 1; 
               else signalCounter <= 0;
               end if;
           end if;
   end process changeDigit;

with inSetting select 
        signalDigit <= constStudentNumberDanni(signalCounter) when "110",
                       constStudentNumberTom(signalCounter) when "111", 
                       "0000" when others;
        
outData <= signalDigit; 

end Behavioral;
