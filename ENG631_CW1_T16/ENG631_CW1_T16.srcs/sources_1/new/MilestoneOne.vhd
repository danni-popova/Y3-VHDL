library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL; 

entity MilestoneOne is
    Port ( inputClock : in STD_LOGIC;
           inputReset : in STD_LOGIC;
           inputFast : in STD_LOGIC;
           --outputLEDs : out STD_LOGIC_VECTOR (15 downto 0);
           outputSegmentCathodes : out STD_LOGIC_VECTOR (6 downto 0);
           outputSegmentDP : out STD_LOGIC;
           outputSegmentAnodes : out STD_LOGIC_VECTOR (3 downto 0));
end MilestoneOne;

architecture Behavioral of MilestoneOne is

    -- buffered clock output from DCM
    signal sigSystemClock : std_logic;
    
    -- main counter register
    signal sigCounter : integer range 0 to 40000000;
    
    -- clock enable for demo
    signal sigClockEnable : std_logic; 
    
    -- LED and seven segment output
    signal sigDisplayCount : integer range 0 to 8;
    
    -- DCM generated component declaration, copied from stub
    component clk_wiz_0 is 
        Port (
        clk_out1 : out STD_LOGIC;
        reset : in STD_LOGIC;
        locked: out STD_LOGIC;
        clk_in1 : in STD_LOGIC
        );
        
    end component; 

begin

Demo_DCM : clk_wiz_0 port map ( clk_out1 => sigSystemClock,
    reset => inputReset, clk_in1 => inputClock); 
    
    clock_divider: Process (inputReset, sigSystemClock, inputFast, sigCounter)
    begin 
        if inputReset = '1' then 
            sigCounter <= 0;
        elsif rising_edge(sigSystemClock) then 
            if sigCounter >= (50000000-1) then 
               sigCounter <= 0;
            else 
                if inputFast = '1' then 
                    sigCounter <= sigCounter + 1000; 
                else 
                    sigCounter <= sigCounter + 1; 
                end if;
            end if;
        end if;
    end process clock_divider;
    
    signal_gen: Process (inputReset, sigSystemClock, sigCounter)
    begin
        if inputReset = '1' then 
            sigClockEnable <= '0';
        elsif falling_edge(sigSystemClock) then 
            if sigCounter >= (40000000-1) then 
                sigClockEnable <= '1';
            else 
                sigClockEnable <= '0';
            end if; 
        end if;
    end process signal_gen;
    
    display_sequence: process(inputReset, sigSystemClock, sigClockEnable, sigDisplayCount)
    begin 
        if inputReset = '1' then 
            sigDisplayCount <= 0;
       elsif rising_edge(sigSystemClock) then 
        if sigClockEnable = '1' then 
            if sigDisplayCount < 8 then 
                sigDisplayCount <= sigDisplayCount + 1; 
            else
                sigDisplayCount <= 0;
            end if; 
        end if;
    end if;
    end process display_sequence;
    
    with sigDisplayCount select 
    outputSegmentCathodes <= "1111110" when 0, 
                             "1111100" when 1, 
                             "1111110" when 2,
                             "1111100" when 3,
                             "1111110" when 4,
                             "1111100" when 5,
                             "1111110" when 6,
                             "1111100" when 7,
                             "1111110" when others;
                         
     outputSegmentDP <= '0' when sigDisplayCount = 0 else '1';
     
     outputSegmentAnodes <= "1111" when inputReset = '1' else "0000";

end Behavioral;
