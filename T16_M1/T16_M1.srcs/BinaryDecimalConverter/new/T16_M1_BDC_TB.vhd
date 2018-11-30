-- Team 16 - 780962 / 782716

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity BinaryDecimalConverter_tb is
--  Port ( );
end BinaryDecimalConverter_tb;


architecture Behavioral of BinaryDecimalConverter_tb is
  
  component BinaryDecimalConverter
    port (
      inBinaryNumber : in  STD_LOGIC_VECTOR (13 downto 0);
      outUnits       : out  STD_LOGIC_VECTOR (3 downto 0);
      outTens        : out  STD_LOGIC_VECTOR (3 downto 0);
      outHundreds    : out  STD_LOGIC_VECTOR (3 downto 0);
      outThousands   : out  STD_LOGIC_VECTOR (3 downto 0)
    );
    end component BinaryDecimalConverter;

--Signals

signal sigBinaryNumber : STD_LOGIC_VECTOR (13 downto 0) := "00000000000000";
signal sigUnits : STD_LOGIC_VECTOR (3 downto 0);
signal sigTens : STD_LOGIC_VECTOR (3 downto 0);
signal sigHundreds : STD_LOGIC_VECTOR (3 downto 0);
signal sigThousands : STD_LOGIC_VECTOR (3 downto 0);

shared variable temp : integer;

begin

  uut : BinaryDecimalConverter
    port map (inBinaryNumber => sigBinaryNumber, outUnits => sigUnits, outTens => sigTens, outHundreds => sigHundreds, outThousands => sigThousands);

    sigBinaryNumber <= std_logic_vector(to_unsigned(temp, sigBinaryNumber'length));

  procClock : process
  begin
    
    sigBinaryNumber <= "00000000000000";
    wait for 100ns; 

    sigBinaryNumber <= "00000000000001";
    wait for 100ns;
    
    sigBinaryNumber <= "00000000000011";
    wait for 100ns; 
    
    sigBinaryNumber <= "00000000000111";
    wait for 100ns; 
    
    sigBinaryNumber <= "11111111111111";
    wait for 100ns; 
    
  end process;


end Behavioral;
