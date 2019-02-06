
-- Team 16 - 782716, 780962

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity T16_M2_Switch_Change_Reset_TB is
--  Port ( );
end T16_M2_Switch_Change_Reset_TB;

architecture Behavioral of T16_M2_Switch_Change_Reset_TB is

  component T16_M2_Switch_Change_Reset
  port (
    inClock       : in  STD_LOGIC;
    inSwitches    : in  STD_LOGIC_VECTOR (2 downto 0);
    outResetPulse : out STD_LOGIC
  );
  end component T16_M2_Switch_Change_Reset;


  signal sigClock : std_logic;
  signal sigOutput : std_logic;
  signal sigInput : std_logic_vector (2 downto 0);

begin

  UUT : T16_M2_Switch_Change_Reset
    port map (inClock => sigClock, outResetPulse => sigOutput, inSwitches => sigInput);

  stim : process
  begin
    sigInput <= "000";
    wait for 20ns;
    sigInput <= "010";
    wait for 20ns;
    sigInput <= "010";
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
