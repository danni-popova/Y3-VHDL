----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02.04.2019 12:16:57
-- Design Name: 
-- Module Name: modB_tb - Behavioral
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

entity modB_tb is
--  Port ( );
end modB_tb;

    architecture Behavioral of modB_tb is
    component ModulatorB is
        Port ( inClock : in STD_LOGIC;
               inData : in STD_LOGIC_VECTOR (1 downto 0);
               outI : out STD_LOGIC_VECTOR (7 downto 0);
               outQ : out STD_LOGIC_VECTOR (7 downto 0));
               
    end component ModulatorB;
    
    --Signals
      signal sigClock : STD_LOGIC := '0';
      signal sigData : STD_LOGIC_VECTOR (1 downto 0);
      signal sigI : STD_LOGIC_VECTOR (7 downto 0);
      signal sigQ : STD_LOGIC_VECTOR (7 downto 0); 
    
    begin
    
    UUT : ModulatorB
        port map (inClock => sigClock, inData => sigData, outI => sigI, outQ => sigQ);
    
      procClock : process
      begin
        sigClock <= '0';
        wait for 100ns;
        sigClock <= '1';
        wait for 100ns;
      end process;
    
    sigData <= "11";
end Behavioral;
