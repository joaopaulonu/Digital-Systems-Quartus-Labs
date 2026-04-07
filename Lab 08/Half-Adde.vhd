library IEEE;
use ieee.std_logic_1164.all;

entity half_adde is -- Ajustado para o nome do seu arquivo
    port (
        a, b : in std_logic;
        sum, carry : out std_logic
    );
end half_adde;

architecture rtl of half_adde is
begin
    sum <= a xor b;
    carry <= a and b;
end rtl;