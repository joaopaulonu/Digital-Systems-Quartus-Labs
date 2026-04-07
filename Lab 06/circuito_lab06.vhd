library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Lab_06 is
    Port ( 
        sw   : in  STD_LOGIC_VECTOR (3 downto 0); -- sw(3)=x1, sw(2)=x2, sw(1)=x3, sw(0)=x4 [cite: 20]
        f3   : out STD_LOGIC; -- LED vermelho 0 [cite: 20]
        f4   : out STD_LOGIC  -- LED verde 7 [cite: 20]
    );
end Lab_06;

architecture Behavioral of Lab_06 is
    signal p1_int : std_logic;
begin
    -- Cálculo de P1: 
    p1_int <= (not sw(3)) and sw(2) and sw(1) and (not sw(0));
    
    -- Função f3: 
    f3 <= ((not sw(3)) and sw(0)) or (sw(3) and sw(2) and sw(0)) or p1_int;
    
    -- Função f4: 
    f4 <= p1_int or ((not sw(2)) and sw(0));
end Behavioral;