-- Team 16 - 782716, 780962

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ModemB is
    Port ( inClock : in STD_LOGIC;
           inData : in STD_LOGIC_VECTOR (1 downto 0);
           inSwitches : in STD_LOGIC_VECTOR (1 downto 0);
           outData : out STD_LOGIC_VECTOR (1 downto 0));
end ModemB;

architecture Behavioral of modemB is

component DemodulatorB is
    Port ( inClock : in STD_LOGIC;
       inI : in STD_LOGIC_VECTOR (7 downto 0);
       inQ : in STD_LOGIC_VECTOR (7 downto 0);
       outData : out STD_LOGIC_VECTOR (1 downto 0));
end component DemodulatorB;


component ModulatorB is
    Port ( inClock : in STD_LOGIC;
       inData : in STD_LOGIC_VECTOR (1 downto 0);
       outI : out STD_LOGIC_VECTOR (7 downto 0);
       outQ : out STD_LOGIC_VECTOR (7 downto 0));
end component ModulatorB;


component ErrorSelect is
    Port(
        inClock : in STD_LOGIC;
        inData : in STD_LOGIC_VECTOR (7 downto 0);
        inSwitches : in STD_LOGIC_VECTOR(1 downto 0);
        inReset : in STD_LOGIC;
        outData : out STD_LOGIC_VECTOR(7 downto 0)
        );
end component ErrorSelect;

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

modulator : ModulatorB
port map (inClock => sigClock, inData => siginData, outI => sigI, outQ => sigQ);
demodulator : DemodulatorB
port map (inClock => sigClock, outData => sigoutData, inI => sigIError, inQ => sigQError);

errorI : ErrorSelect
port map (inClock => sigClock, inData => sigI, outData => sigIerror, inReset => '0', inSwitches => sigSwitches);
errorQ : ErrorSelect
port map (inClock => sigClock, inData => sigQ, outData => sigQerror, inReset => '0', inSwitches => sigSwitches);

sigClock <= inClock;

sigSwitches <= inSwitches;

outData <= sigOutData;
sigInData <= inData;
end Behavioral;
