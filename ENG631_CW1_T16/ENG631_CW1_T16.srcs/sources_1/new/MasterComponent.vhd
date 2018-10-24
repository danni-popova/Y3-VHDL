----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 23.10.2018 15:23:06
-- Design Name: 
-- Module Name: MasterComponent - Behavioral
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

entity MasterComponent is
    Port ( clock : in STD_LOGIC;
           digit : out STD_LOGIC_VECTOR (7 downto 0);
           segmentSelector :out STD_LOGIC_VECTOR (3 downto 0));
end MasterComponent;

architecture Behavioral of MasterComponent is

-- signals 



begin


end Behavioral;
