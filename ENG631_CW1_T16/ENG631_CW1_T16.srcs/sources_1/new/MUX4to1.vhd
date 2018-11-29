--Team 16 - 780962 / 782716
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MUX4to1 is
    Port ( inSelection : in STD_LOGIC_VECTOR (1 downto 0);
           in0 : in STD_LOGIC_VECTOR (3 downto 0);
           in1 : in STD_LOGIC_VECTOR (3 downto 0);
           in2 : in STD_LOGIC_VECTOR (3 downto 0);
           in3 : in STD_LOGIC_VECTOR (3 downto 0);
           out0 : out STD_LOGIC_VECTOR (3 downto 0));
end MUX4to1;

architecture Behavioral of MUX4to1 is

begin
  --An Encapsulated MUX
  with inSelection select
      out0 <= in0 when "00",
              in1 when "01",
              in2 when "10",
              in3 when "11",
              "0000" when others;


end Behavioral;
