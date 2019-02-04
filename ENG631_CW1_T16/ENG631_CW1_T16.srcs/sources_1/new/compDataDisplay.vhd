library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity compDataDisplay is

        Port( inSwitches : in std_logic_vector (2 downto 0);
              inClock : in std_logic;
              inReset : in std_logic;
              
              
              
              outData : out std_logic);

        -- ports    

end compDataDisplay;

architecture Behavioral of compDataDisplay is

       -- signals
       
       
       
       -- student numbers constants
       type studentNumberArray is array (5 downto 0) of integer range 0 to 9; 
       constant constStudentNumberDanni : studentNumberArray := (7, 8, 2, 7, 1, 6);
       constant constStudentNumberTom : studentNumberArray := (7, 8, 0, 9, 6, 2);
       
       signal signalDisplaySetting :  integer range 1 to 5; 
    
     -- Takes 4 bit binary number, outputs an 8 bit binary number pattern necessary to display that 4 bit number
     component SegmentSelector
     port (
       inDecimal   : in  STD_LOGIC_VECTOR (3 downto 0); -- 0001 
       outSegments : out  STD_LOGIC_VECTOR (7 downto 0) -- pattern for display
     );
     end component SegmentSelector;


begin




end Behavioral;
