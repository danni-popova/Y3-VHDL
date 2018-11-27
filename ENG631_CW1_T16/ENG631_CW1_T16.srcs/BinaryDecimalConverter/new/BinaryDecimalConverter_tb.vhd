----------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date: 10/24/2018 02:40:06 PM
-- Design Name:
-- Module Name: Counter_tb - Behavioral
-- Project Name:
-- Target Devices:
-- Tool Versions:
-- Description:
--
-- Dependencies:
--
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
----------------------------------------------------------------------------------
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

signal sigBinaryNumber : STD_LOGIC_VECTOR (13 downto 0);
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
    
    for i in 0 to 100 loop
        temp := i;
        --wait for 100ns; 
        --my_slv <= std_logic_vector(to_unsigned(my_int, my_slv'length));
    end loop;
  
    -- sigBinaryNumber <= "00000001000000";
    --sigBinaryNumber <= std_logic_vector(unsigned(sigBinaryNumber) + 1);
  end process;


end Behavioral;
