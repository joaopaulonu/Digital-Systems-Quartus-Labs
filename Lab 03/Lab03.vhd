library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity LAB03_1 is
    Port ( x1, x2, x3 : in  STD_LOGIC;
           f1, f2     : out STD_LOGIC);
end LAB03_1;

architecture Behavioral of LAB03_1 is
begin
    -- Implementação da função f1 
    f1 <= ( (x1 or x2) and x3 ) or x2;

    -- Implementação da função f2 
    f2 <= (x1 and x2 and x3) or 
          (x1 and (not x2) and x3) or 
          (not x1 and x2 and x3) or 
          (x1 and x2 and (not x3)) or 
          (not x1 and x2 and (not x3));
end Behavioral;