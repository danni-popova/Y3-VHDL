library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity RandomNumberGenerator is

Port ( clock : in STD_LOGIC;
       reset : in STD_LOGIC;
       oRandomNumber : out STD_LOGIC_VECTOR (13 downto 0));

end RandomNumberGenerator;

architecture Behavioral of RandomNumberGenerator is

signal sSeed: STD_LOGIC_VECTOR(19 downto 0) := "10101010101010101010";

begin

PROCESS(clock)
variable newBit : STD_LOGIC := '0';
BEGIN

IF rising_edge(clock) THEN
   IF (reset='1') THEN
      sSeed <= "10101010101010101010";
   else
        --From xilinx paper, with a 20 bit number, XNOR bits 20 and 19 (However that is starting from one)
    newBit := sSeed(19) XNOR sSeed(16);
    sSeed <= newBit & sSeed(19 downto 1);
    end if;

END IF;
END PROCESS;

oRandomNumber <= sSeed(13 downto 0);

end Behavioral;
