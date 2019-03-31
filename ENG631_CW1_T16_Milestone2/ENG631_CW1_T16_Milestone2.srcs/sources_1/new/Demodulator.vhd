----------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date: 03/31/2019 02:56:37 PM
-- Design Name:
-- Module Name: Demodulator - Behavioral
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
use ieee.std_logic_arith.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Demodulator is
    Port ( inClock : in STD_LOGIC;
           inI : in STD_LOGIC_VECTOR (3 downto 0);
           inQ : in STD_LOGIC_VECTOR (3 downto 0);
           outData : out STD_LOGIC_VECTOR (3 downto 0));
end Demodulator;

architecture Behavioral of Demodulator is

shared variable accumulatorI : integer range -30000 to 30000;

shared variable accumulatorQ : integer range -30000 to 30000;

signal firstBits : std_logic_vector(1 downto 0);

signal lastBits : std_logic_vector(1 downto 0);

signal count : integer range 0 to 15;

type referenceWaveArray is array (7 downto 0) of integer range -64 to 64;

constant referenceWave : referenceWaveArray := ("0", "32", "64", "32", "0", "-32", "-64", "-32");

begin


outData(3 downto 2) <= firstBits;

outData(1 downto 0) <= lastBits;


demodulate : process (inClock)
begin

  if rising_edge(inClock) then
    --Accumulator Logic
    if count < 8 then
        accumulatorI := accumulatorI + (referenceWave(count) * to_integer(unsigned(inI)));
        accumulatorQ := accumulatorQ + (referenceWave(count) * to_integer(unsigned(inQ)));
    elsif count < 16 then

    end if;

    if count < 15 then
        count <= count + 1;
    else
        count <= 0;
    end if;

  end if;

end process demodulate;

end Behavioral;
