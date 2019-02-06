----------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date: 05.02.2019 13:12:39
-- Design Name:
-- Module Name: T16_M2_On_Off_Switch - Behavioral
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

entity T16_M2_On_Off_Switch is
    Port ( inClock : in std_logic;
           inPulse : in STD_LOGIC;
           outState : out STD_LOGIC);
end T16_M2_On_Off_Switch;

architecture Behavioral of T16_M2_On_Off_Switch is

signal sigOnOff : std_logic := '0';

signal lastState : std_logic := '0';

begin

    toggle : process (inClock)
    begin
        if rising_edge(inClock) then --Clock pulse to make sure it doesn;t toggle constantly
            sigOnOff <= inPulse XOR sigOnOff; --Toggle! If both are high, set output to low, when the pulse is high and output is low set the output high
        end if;
    end process toggle;

     outState <= sigOnOff;

end Behavioral;
