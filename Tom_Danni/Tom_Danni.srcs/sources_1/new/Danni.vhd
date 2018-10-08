----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Danni and Tom 
-- 
-- Create Date: 02.10.2018 15:21:20
-- Design Name: Crap
-- Module Name: Danni - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Danni is
    Port ( i_C100Mhz : in STD_LOGIC;
           i_Reset : in STD_LOGIC;
           i_Fast : in STD_LOGIC;
           o_LEDs : out STD_LOGIC_VECTOR (15 downto 0);
           o_SegmentCathodes : out STD_LOGIC_VECTOR (6 downto 0);
           o_SegmentDP : out STD_LOGIC;
           o_SegmentAnodes : out STD_LOGIC_VECTOR (3 downto 0));
end Danni;

architecture Behavioral of Danni is

signal r_SystemClock : std_logic; 

signal r_Counter : integer range 0 to 50000000;

signal r_CE2Hz : std_logic; 

signal r_DisplayCount : integer range 0 to 8;

signal r_Pattern : std_logic_vector(7 downto 0);

component clk_wiz_0 is 
    Port ( 
  clk_out1 : out STD_LOGIC;
  reset : in STD_LOGIC;
  locked : out STD_LOGIC;
  clk_in1 : in STD_LOGIC
);

end component;

begin

Demo_DCM : clk_wiz_0 port map ( clk_out1 => r_SystemClock,
    reset => i_Reset, clk_in1 => i_C100MHz); 
    
    clock_divider: Process (i_Reset, r_SystemClock, i_Fast, r_Counter)
    begin 
        if i_Reset = '1' then 
            r_Counter <= 0;
        elsif rising_edge(r_SystemClock) then 
            if r_Counter >= (50000000-1) then 
               r_Counter <= 0;
            else 
                if i_Fast = '1' then 
                    r_Counter <= r_Counter + 1000; 
                else 
                    r_Counter <= r_Counter + 1; 
                end if;
            end if;
        end if;
    end process clock_divider;
    
    signal_gen: Process (i_Reset, r_SystemClock, r_Counter)
    begin
        if i_Reset = '1' then 
            r_CE2Hz <= '0';
        elsif falling_edge(r_SystemClock) then 
            if r_Counter >= (50000000-1) then 
                r_CE2Hz <= '1';
            else 
                r_CE2Hz <= '0';
            end if; 
        end if;
    end process signal_gen;
    
    display_sequence: process(i_Reset, r_SystemClock, r_CE2Hz, r_DisplayCount)
    begin 
        if i_Reset = '1' then 
            r_DisplayCount <= 0;
       elsif rising_edge(r_SystemClock) then 
        if r_CE2Hz = '1' then 
            if r_DisplayCount < 8 then 
                r_DisplayCount <= r_DisplayCount + 1; 
            else
                r_DisplayCount <= 0;
            end if; 
        end if;
    end if;
    end process display_sequence;
    
    with r_DisplayCount select 
    o_SegmentCathodes <= "1111111" when 0, 
                         "1101111" when 1, 
                         "1111110" when 2,
                         "1111101" when 3,
                         "0111111" when 4,
                         "1011111" when 5,
                         "1111110" when 6,
                         "1111011" when 7,
                         "1110111" when others;
                         
     o_SegmentDP <= '0' when r_DisplayCount = 0 else '1';
     
     o_SegmentAnodes <= "1111" when i_Reset = '1' else "0000";
     
     -- LED pattern 
     with r_DisplayCount select 
     r_Pattern <= "10000000" when 0, 
                  "11000000" when 1, 
                  "10100000" when 2,
                  "10010000" when 3,
                  "10001000" when 4,
                  "10000100" when 5,
                  "10000010" when 6,
                  "10000001" when 7,
                  "10000000" when others;
                  
      o_LEDs( 15 downto 8) <= r_Pattern;
      o_LEDs( 7 downto 0) <= r_Pattern;
               
end Behavioral;
