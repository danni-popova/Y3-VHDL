library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Counter is

    Port ( inClock : in STD_LOGIC;
           inReset : in STD_LOGIC;
           outDigitOne : out integer;
           outDigitTwo : out integer;
           outDigitThree : out integer;
           outDigitZero : out integer);

end Counter;

architecture Behavioral of Counter is

-- signals 

    type ta is array(0 to 3) of integer range 0 to 9;
    signal sigDigitToDisplay: ta := (0, 0, 0, 0);
    
begin

increment_digit_one: Process(inClock, sigDigitToDisplay)
    begin 
    if rising_edge(inClock) then 
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
end process increment_digit_one;

-- send array to output
outDigitZero <= sigDigitToDisplay(0);
outDigitOne <= sigDigitToDisplay(1);
outDigitTwo <= sigDigitToDisplay(2);
outDigitThree <= sigDigitToDisplay(3);

end Behavioral;
