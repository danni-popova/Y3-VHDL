library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

-- Generates a random number and adds it on to the input

entity compError is
    Port(
        inClock : in STD_LOGIC; 
        inData : in STD_LOGIC_VECTOR (7 downto 0);
        inSwitches : in STD_LOGIC_VECTOR(1 downto 0);
        inReset : in STD_LOGIC;
        outData : out STD_LOGIC_VECTOR(7 downto 0)
        );
end compError;

architecture Behavioral of compError is

    signal sigErrorSelect : integer range 0 to 128; 
    signal sigResult : std_logic_vector(7 downto 0);
    signal sigRandomNumber : std_logic_vector (19 downto 0); 
    signal sigErrorValue : std_logic_vector (7 downto 0);

----------------------------------------------
-- Random number generator for error injection
----------------------------------------------
 
  component RandomNumberGenerator is
  Port ( clock : in STD_LOGIC;
         reset : in STD_LOGIC;
         oRandomNumber : out STD_LOGIC_VECTOR (19 downto 0));
  end component RandomNumberGenerator;

begin

-- NB --
-- Change range of generated number using sigErrorSelect
-- NB --
 rng64Bit : RandomNumberGenerator
   port map (clock => inClock, reset => inReset, oRandomNumber => sigRandomNumber);
       
injectError : process(inClock)
begin
    if(rising_edge(inClock)) then
        if sigRandomNumber(8) = '1' then
            sigResult <= std_logic_vector(unsigned(inData) + unsigned(sigErrorValue));
        else 
            sigResult <= std_logic_vector(unsigned(inData) - unsigned(sigErrorValue));
        end if; 
    end if;
end process injectError; 

-- SW12, SW11 - Error Select - add or subtract a random value to the transmitted I and Q
-- Error Select Switches control the range of the random number  
with inSwitches select 
        sigErrorValue <= "00000000" when "00", 
                         "00"&sigRandomNumber(5 downto 0) when "01",
                         "0"&sigRandomNumber(6 downto 0) when "10",
                         sigRandomNumber(7 downto 0) when "11",
                         "00000000" when others;  
     

-- should see the data randomised 
outData <= sigResult;

-- for debugging

end Behavioral;
