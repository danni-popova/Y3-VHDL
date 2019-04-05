-- Team 16 - 782716, 780962

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ModemA is
    Port ( inClock : in STD_LOGIC;
           inClock2hz : in std_logic;
           inData : in STD_LOGIC_VECTOR (3 downto 0);
           inSwitches : in std_logic_vector (1 downto 0);
           outData : out STD_LOGIC_VECTOR (3 downto 0));
end ModemA;

architecture Behavioral of ModemA is

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

signal wholeIn : std_logic_vector(3 downto 0);
signal wholeOut : std_logic_vector(3 downto 0);

signal toggle : std_logic :='1';

begin

bitBreakerProcess : process (inClock2hz)
begin
    toggle <= NOT(toggle);

    if toggle = '1' then
        sigInData <= inData(3 downto 2);
        wholeOut(3 downto 2) <= sigOutData;
        outData <= wholeOut;
    else
        sigInData <= inData(1 downto 0);
        wholeOut(1 downto 0) <= sigOutData;
    end if;

end process bitBreakerProcess;

crazyNewProcess : process(inClock2Hz)
begin
    if toggle = '1' then

    end if;

end process;


modulator : ModulatorA
port map (inClock => sigClock, inData => siginData, outI => sigI, outQ => sigQ, counter => open);
demodulator : DemodulatorA
port map (inClock => sigClock, outData => sigoutData, inI => sigIError, inQ => sigQError);

errorI : ErrorSelect
port map (inClock => sigClock, inData => sigI, outData => sigIerror, inReset => '0', inSwitches => sigSwitches);
errorQ : ErrorSelect
port map (inClock => sigClock, inData => sigQ, outData => sigQerror, inReset => '0', inSwitches => sigSwitches);

sigClock <= inClock;

sigSwitches <= inSwitches;


end Behavioral;
