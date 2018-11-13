----------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date: 10/24/2018 06:01:06 PM
-- Design Name:
-- Module Name: BinaryDecimalConverter - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity BinaryDecimalConverter is
    Port ( inBinaryNumber : in STD_LOGIC_VECTOR (13 downto 0);
           outUnits : out STD_LOGIC_VECTOR (3 downto 0);
           outTens : out STD_LOGIC_VECTOR (3 downto 0);
           outHundreds : out STD_LOGIC_VECTOR (3 downto 0);
           outThousands : out STD_LOGIC_VECTOR (3 downto 0));
end BinaryDecimalConverter;

architecture Behavioral of BinaryDecimalConverter is

------
-- Signals to store/calculate values
------
  shared variable sigUnits : integer range 0 to 9;
  shared variable sigTens : integer range 0 to 9;
  shared variable sigHundreds : integer range 0 to 9;
  shared variable sigThousands : integer range 0 to 9;

  shared variable sigNumber : integer range 0 to 9999;


begin

  outUnits <= std_logic_vector(to_unsigned(sigUnits, outUnits'length));
  outTens <= std_logic_vector(to_unsigned(sigTens, outUnits'length));
  outHundreds <= std_logic_vector(to_unsigned(sigHundreds, outUnits'length));
  outThousands <= std_logic_vector(to_unsigned(sigThousands, outUnits'length));

  procConverter : process (inBinaryNumber)
  begin
    sigNumber := to_integer(unsigned(inBinaryNumber));

    sigUnits := sigNumber mod 10;
    sigNumber := (sigNumber - sigUnits) / 10;

    sigTens := sigNumber mod 10;
    sigNumber := (sigNumber - sigTens) / 10;

    sigHundreds := sigNumber mod 10;
    sigNumber := (sigNumber - sigHundreds) / 10;

    sigThousands := sigNumber; --Can do this because we will have worked our way to the last number by here

  end process;

end Behavioral;
