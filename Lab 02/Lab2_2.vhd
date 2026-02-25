library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Lab2_2 is
    Port ( x1 : in  STD_LOGIC;
           x2 : in  STD_LOGIC;
           x3 : in  STD_LOGIC;
           x4 : in  STD_LOGIC;
           f2 : out STD_LOGIC);
end Lab2_2;

architecture Behavioral of Lab2_2 is
begin
    -- f2 simplificada usando a porta XOR
    f2 <= (x1 xor x3) and (x2 xor x4);
end Behavioral;
