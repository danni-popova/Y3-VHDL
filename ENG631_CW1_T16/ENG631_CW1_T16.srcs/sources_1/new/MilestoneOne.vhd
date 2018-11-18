library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL; 

entity MilestoneOne is
    Port ( inputClock : in STD_LOGIC;
           inputReset : in STD_LOGIC;
           inputFast : in STD_LOGIC;
           outputSegmentCathodes : out STD_LOGIC_VECTOR (6 downto 0);
           outputSegmentAnodes : out STD_LOGIC_VECTOR (3 downto 0));
end MilestoneOne;

architecture Behavioral of MilestoneOne is

    -- buffered clock output from DCM
    signal sigSystemClock : std_logic;
    
    -- main counter register
    signal sigCounter : integer range 0 to 40000000;
    
    -- secondary count register to drive display
    signal sigCounter2 : integer range 0 to 400000;
    
    -- clock enable for demo
    signal sigClockEnable : std_logic; 
    signal sigClockEnable2 : std_logic; 
    
    -- LED and seven segment output
    signal sigDisplayCount : integer range 0 to 9;
    
    -- Counter for anodes change vhdl 
    signal sigAnodesPattern : std_logic_vector (3 downto 0);
    signal sigAnodesCounter : integer range 0 to 3;
    
    type ta is array(0 to 3) of integer range 0 to 9;
    signal sigDigitToDisplay: ta := (0, 0, 0, 0);
    
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
    
    proc_counter: Process(sigSystemClock, sigClockEnable, sigDigitToDisplay)
    begin 
    if rising_edge(sigSystemClock) then 
        if sigClockEnable = '1' then
            if sigDigitToDisplay(0) < 9 then
                sigDigitToDisplay(0) <= sigDigitToDisplay(0) + 1;
            else 
                sigDigitToDisplay(0) <= 0; 
                if sigDigitToDisplay(1) < 9 then 
                    sigDigitToDisplay(1)<= sigDigitToDisplay(1) + 1;
                else 
                    sigDigitToDisplay(1) <= 0; 
                    if sigDigitToDisplay(2) < 9 then
                       sigDigitToDisplay(2)<= sigDigitToDisplay(2) + 1;
                    else 
                        sigDigitToDisplay(2) <= 0;
                        if sigDigitToDisplay(3)< 9 then
                           sigDigitToDisplay(3)<= sigDigitToDisplay(3) + 1;
                       else 
                           sigDigitToDisplay(0) <= 0;
                           sigDigitToDisplay(1) <= 0;
                           sigDigitToDisplay(2) <= 0;
                           sigDigitToDisplay(3) <= 0;
                       end if;
                     end if;
                 end if; 
            end if;
        end if;
    end if;            
    end process proc_counter;
    
    clock_divider: Process (inputReset, sigSystemClock, inputFast, sigCounter)
    begin 
        if inputReset = '1' then 
            sigCounter <= 0;
        elsif rising_edge(sigSystemClock) then 
            if sigCounter >= (40000000-1) then 
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
    
    clock_divider2: Process (inputReset, sigSystemClock, inputFast, sigCounter2)
        begin 
            if inputReset = '1' then 
                sigCounter2 <= 0;
            elsif rising_edge(sigSystemClock) then 
                if sigCounter2 >= (400000-1) then 
                   sigCounter2 <= 0;
                else 
                    if inputFast = '1' then 
                        sigCounter2 <= sigCounter2 + 1000; 
                    else 
                        sigCounter2 <= sigCounter2 + 1; 
                    end if;
                end if;
            end if;
        end process clock_divider2;
    
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
    
    signal_gen2: Process (inputReset, sigSystemClock, sigCounter2)
        begin
            if inputReset = '1' then 
                sigClockEnable2 <= '0';
            elsif falling_edge(sigSystemClock) then 
                if sigCounter2 >= (400000-1) then 
                    sigClockEnable2 <= '1';
                else 
                    sigClockEnable2 <= '0';
                end if; 
            end if;
        end process signal_gen2;
    
    display_sequence: process(inputReset, sigSystemClock, sigClockEnable, sigDisplayCount)
    begin 
        if inputReset = '1' then 
            sigDisplayCount <= 0;
       elsif rising_edge(sigSystemClock) then 
        if sigClockEnable = '1' then 
            if sigDisplayCount < 9 then 
                sigDisplayCount <= sigDisplayCount + 1; 
            else
                sigDisplayCount <= 0;
            end if; 
        end if;
    end if;
    end process display_sequence;
    
    anodes_counter: Process (sigSystemClock, sigAnodesCounter)
        begin 
        if rising_edge(sigSystemClock)then
            if sigClockEnable2 = '1' then
                if sigAnodesCounter < 3 then
                    sigAnodesCounter <= sigAnodesCounter + 1;
                else sigAnodesCounter <= 0;
                end if;
            end if;
         end if;
        end process anodes_counter;
    
    with sigDigitToDisplay(sigAnodesCounter) select
    outputSegmentCathodes <= "0000001" when 0, 
                                 "1001111" when 1, 
                                 "0010010" when 2,
                                 "0000110" when 3,
                                 "1001100" when 4,
                                 "0100100" when 5,
                                 "0100000" when 6,
                                 "0001111" when 7,
                                 "0000000" when 8,
                                 "0000100" when 9,
                                 "0000000" when others;
     
     with sigAnodesCounter select 
     sigAnodesPattern <= "1110" when 0,
                         "1101" when 1,
                         "1011" when 2,
                         "0111" when 3,
                         "0000" when others;
                         
    -- set anodes to the anodes pattern
     outputSegmentAnodes <= sigAnodesPattern;

end Behavioral;
