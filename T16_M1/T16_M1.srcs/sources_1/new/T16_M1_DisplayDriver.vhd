--Team 16 - 780962 / 782716

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

--This Component only functions to combine elements that form a display driver

entity DisplayDriver is
    Port ( inReset : in STD_LOGIC;
           inSelection : in STD_LOGIC_VECTOR (1 downto 0);
           inNumber : in STD_LOGIC_VECTOR (13 downto 0);
           outDigit : out STD_LOGIC_VECTOR (7 downto 0));
end DisplayDriver;

architecture Behavioral of DisplayDriver is

------
-- Components
------

  ------
  -- Segment Selector - Based on binary input decides which segments to illuminate to draw a number
  ------
  component SegmentSelector
  port (
    inDecimal   : in  STD_LOGIC_VECTOR (3 downto 0);
    outSegments : out  STD_LOGIC_VECTOR (7 downto 0)
  );
  end component SegmentSelector;

  ------
  -- MUX Will choose which number from the Binary-Decimal converter to output
  ------
  component MUX4to1
  port (
    inSelection : in  STD_LOGIC_VECTOR (1 downto 0);
    in0         : in  STD_LOGIC_VECTOR (3 downto 0);
    in1         : in  STD_LOGIC_VECTOR (3 downto 0);
    in2         : in  STD_LOGIC_VECTOR (3 downto 0);
    in3         : in  STD_LOGIC_VECTOR (3 downto 0);
    out0        : out  STD_LOGIC_VECTOR (3 downto 0)
  );
  end component MUX4to1;

  ------
  -- Binary to Decimal Converter - Takes in binary integer and outputs 1s, 10s, 100s, 1000s.
  ------
  component BinaryDecimalConverter
  port (
    inBinaryNumber : in  STD_LOGIC_VECTOR (13 downto 0);
    outUnits       : out  STD_LOGIC_VECTOR (3 downto 0);
    outTens        : out  STD_LOGIC_VECTOR (3 downto 0);
    outHundreds    : out  STD_LOGIC_VECTOR (3 downto 0);
    outThousands   : out  STD_LOGIC_VECTOR (3 downto 0)
  );
  end component BinaryDecimalConverter;


------
-- Signals
------
  --These will carry the numbers from the BCD to the MUX
  signal sigUnits : std_logic_vector (3 downto 0);
  signal sigTens : std_logic_vector (3 downto 0);
  signal sigHundreds : std_logic_vector (3 downto 0);
  signal sigThousands : std_logic_vector (3 downto 0);

  --This will carry the digit to be converted for the 7-seg
  signal sigOutputDigit : std_logic_vector (3 downto 0);


begin

  compSegmentSelector : SegmentSelector
    port map ( inDecimal => sigOutputDigit, outSegments => outDigit );

  compMUX : MUX4to1
    port map ( inSelection => inSelection, in0 => sigUnits, in1 => sigTens, in2 => sigHundreds, in3 => sigThousands, out0 => sigOutputDigit );

  compBinaryDecimalConverter : BinaryDecimalConverter
    port map ( inBinaryNumber => inNumber, outUnits => sigUnits, outTens => sigTens, outHundreds => sigHundreds, outThousands => sigThousands );

end Behavioral;
