----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/24/2018 06:01:06 PM
-- Design Name: 
-- Module Name: DisplayDriver - Behavioral
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

entity DisplayDriver is
    Port ( inReset : in STD_LOGIC;
           inClock : in STD_LOGIC;
           inNumber : in STD_LOGIC_VECTOR (13 downto 0);
           outDigit : out STD_LOGIC_VECTOR (7 downto 0);
           outSegment : out STD_LOGIC_VECTOR (3 downto 0));
end DisplayDriver;

architecture Behavioral of DisplayDriver is

begin


end Behavioral;
