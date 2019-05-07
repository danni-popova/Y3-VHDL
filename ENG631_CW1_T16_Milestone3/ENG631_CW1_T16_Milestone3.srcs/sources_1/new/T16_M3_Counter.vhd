-- Team 16 - 782716, 780962

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity Counter is
    Generic( genMaxCount : integer range 1 to 10000);
    Port ( inClock : in STD_LOGIC;
           inReset : in STD_LOGIC;
           outCount : out STD_LOGIC_VECTOR (13 downto 0));
end Counter;

architecture Behavioral of Counter is

signal sigCounter : integer range 0 to 9999; -- Will keep track of counting

begin

  --Sets the Counter's output to the value stored in the internal Counter
  --Casts from Integer to SLV of the same size as the length of the Output
  outCount <= std_logic_vector(to_unsigned(sigCounter, outCount'length));

  procCounter : process (inClock, inReset)
  begin

    if inReset ='1' then
      sigCounter <= 0; --If reset is high we reset the clock, no counting is needed
    elsif rising_edge(inClock) then
      --In this block means we need to count, this decides to either wrap around or increment
      if sigCounter >= genMaxCount - 1 then
        sigCounter <= 0;
      else
        sigCounter <= sigCounter + 1;
      end if;
    end if;

  end process procCounter;

end Behavioral;
