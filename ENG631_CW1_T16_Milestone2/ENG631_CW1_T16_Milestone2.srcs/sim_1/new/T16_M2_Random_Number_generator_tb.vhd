-- Team 16 - 782716, 780962

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity T16_M2_Random_Number_generator_tb is
--  Port ( );
end T16_M2_Random_Number_generator_tb;

architecture Behavioral of T16_M2_Random_Number_generator_tb is

  component RandomNumberGenerator
    port (
      clock         : in  STD_LOGIC;
      reset         : in  STD_LOGIC;
      oRandomNumber : out STD_LOGIC_VECTOR (3 downto 0)
    );
  end component RandomNumberGenerator;


  signal sigClock : std_logic;
  signal sigInput : std_logic;
  signal sigOutput : std_logic_vector (3 downto 0);

begin

  UUT : RandomNumberGenerator
    port map (clock => sigClock, reset => sigInput, oRandomNumber => sigOutput);

  stim : process
  begin
    sigInput <= '0';
    wait for 2000ns;
    sigInput <= '1';
    wait for 10ns;
  end process;

  clock : process
  begin

    sigClock <= '0';
    wait for 10ns;
    sigClock <= '1';
    wait for 10ns;
  end process;

end Behavioral;
