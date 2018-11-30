--Team 16 - 780962 / 782716

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Counter_tb is
--  Port ( );
end Counter_tb;



architecture Behavioral of Counter_tb is
--Component Declaration
  component Counter
  generic (
    genMaxCount : integer
  );
  port (
    inClock  : in  STD_LOGIC;
    inReset  : in  STD_LOGIC;
    outCount : out STD_LOGIC_VECTOR (13 downto 0)
  );
  end component Counter;

--Signals
  signal sigClock : STD_LOGIC := '0';
  signal sigReset : STD_LOGIC := '0';
  signal sigCount : STD_LOGIC_VECTOR (13 downto 0);

begin

  uut : Counter
    generic map (genMaxCount => 4)
    port map (inClock => sigClock, inReset => sigReset, outCount => sigCount);

  procClock : process
  begin
    sigClock <= '0';
    wait for 100ns;
    sigClock <= '1';
    wait for 100ns;
  end process;


end Behavioral;
