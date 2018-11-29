--Team 16 - 780962 / 782716

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

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


  --This converts the variable integers created and converts them to signals
  outUnits <= std_logic_vector(to_unsigned(sigUnits, outUnits'length));
  outTens <= std_logic_vector(to_unsigned(sigTens, outUnits'length));
  outHundreds <= std_logic_vector(to_unsigned(sigHundreds, outUnits'length));
  outThousands <= std_logic_vector(to_unsigned(sigThousands, outUnits'length));

  --Whenever the input changes calculate the binary sigNumber
  --A running total is used to keep divisions small, this way each step is identical
  procConverter : process (inBinaryNumber)
  begin
    --Convert SLV input to an integer to be worked with
    sigNumber := to_integer(unsigned(inBinaryNumber));

    --This step numeric value of the Least significant digit, it then removes it
    --from the running total, this means each iteration breaks off the next sigNumber
    --e.g. -> 1234 (4) -> 1230 -> 123 (3) -> 120 -> 12 (2) -> 10 -> 1 (1)
    sigUnits := sigNumber mod 10;
    sigNumber := (sigNumber - sigUnits) / 10;

    sigTens := sigNumber mod 10;
    sigNumber := (sigNumber - sigTens) / 10;

    sigHundreds := sigNumber mod 10;
    sigNumber := (sigNumber - sigHundreds) / 10;

    sigThousands := sigNumber; --Can do this because we will have worked our way to the last number by here

  end process;

end Behavioral;
