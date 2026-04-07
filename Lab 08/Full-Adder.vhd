library IEEE;
use ieee.std_logic_1164.all;

entity full_adder is -- Ajustado para o nome do seu arquivo
    port (
        a, b, cin : in std_logic;
        sum, cout : out std_logic
    );
end full_adder;

architecture rtl of full_adder is
begin
    sum <= a xor b xor cin;
    cout <= (cin and (a xor b)) or (a and b);
end rtl;