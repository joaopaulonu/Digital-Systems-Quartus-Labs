library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity lab05 is
    Port ( 
        SW0  : in  STD_LOGIC; -- Operando A
        SW1  : in  STD_LOGIC; -- Operando B
        SW2  : in  STD_LOGIC; -- Carry-in
        LDR0 : out STD_LOGIC; -- Soma
        LDR1 : out STD_LOGIC  -- Carry-out
    );
end lab05;

architecture Behavioral of lab05 is
begin
    -- Lógica do Somador Completo
    LDR0 <= SW0 xor SW1 xor SW2;
    LDR1 <= (SW0 and SW1) or (SW2 and (SW0 xor SW1));
end Behavioral;