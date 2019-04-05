-- Team 16 - 782716, 780962


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity T16_M2_On_Off_Switch_tb is
end T16_M2_On_Off_Switch_tb;

architecture Behavioral of T16_M2_On_Off_Switch_tb is

  component OnOffSwitch
  port (
    inClock  : in  std_logic;
    inPulse  : in  STD_LOGIC;
    outState : out STD_LOGIC
  );
  end component OnOffSwitch;

  signal sigClock : std_logic;
  signal sigInput : std_logic;
  signal sigOutput : std_logic;

begin

  UUT : OnOffSwitch
    port map (inClock => sigClock, inPulse => sigInput, outState => sigOutput);

  stim : process
  begin
    sigInput <= '0';
    wait for 200ns;
    sigInput <= '1';
    wait for 20ns;
  end process;

  clock : process
  begin

    sigClock <= '0';
    wait for 10ns;
    sigClock <= '1';
    wait for 10ns;
  end process;

end Behavioral;
