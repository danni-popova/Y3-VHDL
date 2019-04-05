-- Team 16 - 782716, 780962

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity T16_M2_Bit_Splitter_tb is
end T16_M2_Bit_Splitter_tb;

architecture Behavioral of T16_M2_Bit_Splitter_tb is

  component BitSplitter
    port (
      inBits  : in  STD_LOGIC_VECTOR (3 downto 0);
      inClock : in  std_logic;
      inReset : in  std_logic;
      outMSB  : out STD_LOGIC_VECTOR (3 downto 0);
      outLSB  : out STD_LOGIC_VECTOR (3 downto 0)
    );
  end component BitSplitter;


  signal sigClock : std_logic;
  signal reset : std_logic;
  signal sigInput : std_logic_vector (3 downto 0);
  signal sigOutputOne : std_logic_vector (3 downto 0);
  signal sigOutputTwo : std_logic_vector (3 downto 0);

begin

  UUT : BitSplitter
    port map (inClock => sigClock, inBits => sigInput, outMSB => sigOutputOne, outLSB => sigOutputTwo, inReset => reset);

  stim : process
  begin
    sigInput <= "0011";
    wait for 50ns;
    sigInput <= "1010";
    wait for 50ns;
    sigInput <= "0101";
    wait for 50ns;
    sigInput <= "1000";
    wait for 50ns;
    sigInput <= "0011";
    wait for 50ns;
    sigInput <= "1001";
    wait for 50ns;
  end process;

  clock : process
  begin
    sigClock <= '0';
    wait for 10ns;
    sigClock <= '1';
    wait for 10ns;
  end process;

end Behavioral;
