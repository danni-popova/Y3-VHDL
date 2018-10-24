----------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date: 23.10.2018 15:30:21
-- Design Name:
-- Module Name: ClockDivider - Behavioral
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

entity ClockDivider is
    Generic ( MaxCount : integer range 0 to 400000000 );
    Port ( reset : in STD_LOGIC;
           clock : in STD_LOGIC;
           clockOut : out STD_LOGIC );
end ClockDivider;

architecture Behavioral of ClockDivider is

--signals
signal counter : integer range 0 to 400000000;

begin

    clockEnable : process (clock, reset)
    begin
        if reset = '1' then
            counter <= 0;
            clockOut <= '0'; --Check with Neils about this
        elsif rising_edge(clock) then
            clockOut <= '0'; --Check with Neils about this
            if counter < MaxCount - 1 then
                counter <= counter +1;
            else
                counter <= 0;
                clockOut <= '1';
            end if;
        end if;


    end process clockEnable;

end Behavioral;
