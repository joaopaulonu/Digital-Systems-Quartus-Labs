library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Lab2_1 is
    Port ( x1 : in  STD_LOGIC;
           x2 : in  STD_LOGIC;
           x3 : in  STD_LOGIC;
           x4 : in  STD_LOGIC;
           f1 : out STD_LOGIC);
end Lab2_1;

architecture Behavioral of Lab2_1 is
begin
    -- f1 simplificada usando a porta XNOR
    f1 <= not (x1 xor x3) and not (x2 xor x4);
end Behavioral;
