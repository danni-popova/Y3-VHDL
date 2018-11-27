----------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date: 10/24/2018 02:40:06 PM
-- Design Name:
-- Module Name: Counter_tb - Behavioral
-- Project Name:
-- Target Devices:
-- Tool Versions:
-- Description:
--
-- Dependencies:
--
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Debouncer_tb is
--  Port ( );
end Debouncer_tb;



architecture Behavioral of Debouncer_tb is
--Component Declaration
  component Debouncer
  
  Port ( 
    Clock : in STD_LOGIC;
    Input : in STD_LOGIC;
    Output : out STD_LOGIC
    );
  
  end component Debouncer;

--Signals
  signal sigClock : STD_LOGIC := '0';
  signal sigInput : STD_LOGIC := '0';
  signal sigOutput : STD_LOGIC := '0';

begin

  uut : Debouncer
    port map (Clock => sigClock, input => sigInput, output => sigOutput);

  procInput : process
  begin
    sigInput <= '0';
    wait for 100ns;
    sigInput <= '1';
    wait for 100ns;
  end process;
  
  procClock : process
  begin
  
    sigClock <= '0';
    wait for 10ns;
    sigClock <= '1';
    wait for 10ns;
  end process;


end Behavioral;
