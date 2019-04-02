----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02.04.2019 13:44:03
-- Design Name: 
-- Module Name: modemA - Behavioral
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

entity modemA is
    Port ( inClock : in STD_LOGIC;
           inData : in STD_LOGIC_VECTOR (1 downto 0);
           inSwitches : in std_logic_vector (1 downto 0);
           outData : out STD_LOGIC_VECTOR (1 downto 0));
end modemA;

architecture Behavioral of modemA is

component DemodulatorA is
    Port ( inClock : in STD_LOGIC;
       inI : in STD_LOGIC_VECTOR (7 downto 0);
       inQ : in STD_LOGIC_VECTOR (7 downto 0);
       outData : out STD_LOGIC_VECTOR (1 downto 0));
end component DemodulatorA;


component ModulatorA is
    Port ( inClock : in STD_LOGIC;
       inData : in STD_LOGIC_VECTOR (1 downto 0);
       outI : out STD_LOGIC_VECTOR (7 downto 0);
       outQ : out STD_LOGIC_VECTOR (7 downto 0);
       counter : out std_logic_vector (3 downto 0));
end component ModulatorA;


component compError is
    Port(
        inClock : in STD_LOGIC; 
        inData : in STD_LOGIC_VECTOR (7 downto 0);
        inSwitches : in STD_LOGIC_VECTOR(1 downto 0);
        inReset : in STD_LOGIC;
        outData : out STD_LOGIC_VECTOR(7 downto 0)
        );
end component compError;





signal sigClock : STD_LOGIC := '0';
signal siginData : STD_LOGIC_VECTOR (1 downto 0);
signal sigoutdata : std_logic_vector(1 downto 0);
signal sigI : STD_LOGIC_VECTOR (7 downto 0);
signal sigQ : STD_LOGIC_VECTOR (7 downto 0); 

signal sigSwitches : std_logic_vector (1 downto 0);

signal sigIError : STD_LOGIC_VECTOR (7 downto 0);
signal sigQError : STD_LOGIC_VECTOR (7 downto 0); 

signal sigOutI : STD_LOGIC_VECTOR (7 downto 0);
signal sigOutQ : STD_LOGIC_VECTOR (7 downto 0); 

begin

modulator : ModulatorA
port map (inClock => sigClock, inData => siginData, outI => sigI, outQ => sigQ, counter => open);
demodulator : DemodulatorA
port map (inClock => sigClock, outData => sigoutData, inI => sigIError, inQ => sigQError);

errorI : compError
port map (inClock => sigClock, inData => sigI, outData => sigIerror, inReset => '0', inSwitches => sigSwitches);
errorQ : compError
port map (inClock => sigClock, inData => sigQ, outData => sigQerror, inReset => '0', inSwitches => sigSwitches);

sigClock <= inClock; 

sigSwitches <= inSwitches;

outData <= sigOutData;
sigInData <= inData;


end Behavioral;
