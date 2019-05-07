--Team 16 - 780962 / 782716

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity T16_M2_Segment_Selector_TB is
--  Port ( );
end T16_M2_Segment_Selector_TB;

architecture Behavioral of T16_M2_Segment_Selector_TB is

component SegmentSelector
  port (
    inDecimal   : in  STD_LOGIC_VECTOR (3 downto 0);
    outSegments : out  STD_LOGIC_VECTOR (7 downto 0)
  );
  end component SegmentSelector;

--Signals

signal sigDecimal : STD_LOGIC_VECTOR (3 downto 0) := "0000";
signal sigSegments : STD_LOGIC_VECTOR (7 downto 0);


begin

UUT : SegmentSelector
    port map (inDecimal => sigDecimal, outSegments => sigSegments);

  procClock : process
  begin
    sigDecimal <= "0000"; -- 0
    wait for 100ns;
    sigDecimal <= "0001"; -- 1
    wait for 100ns;
    sigDecimal <= "0010"; -- 2
    wait for 100ns;
    sigDecimal <= "0011"; -- 3
    wait for 100ns;
    sigDecimal <= "0100"; -- 4
    wait for 100ns;
    sigDecimal <= "0101"; -- 5
    wait for 100ns;
    sigDecimal <= "0110"; -- 6
    wait for 100ns;
    sigDecimal <= "0111"; -- 7
    wait for 100ns;
    sigDecimal <= "1000"; -- 8
    wait for 100ns;
    sigDecimal <= "1001"; -- 9
    wait for 100ns;
    sigDecimal <= "0000"; -- for others 
    wait;
  end process;

end Behavioral;
