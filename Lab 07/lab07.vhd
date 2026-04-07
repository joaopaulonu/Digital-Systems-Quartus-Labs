library ieee;
use ieee.std_logic_1164.all;

entity lab07 is
    port(
        SW   : in  std_logic_vector(2 downto 0); -- Entradas [cite: 16]
        HEX7 : out std_logic_vector(0 to 6);     -- Exibe cin (SW0) [cite: 8]
        HEX5 : out std_logic_vector(0 to 6);     -- Exibe b   (SW1) [cite: 8]
        HEX3 : out std_logic_vector(0 to 6);     -- Exibe a   (SW2) [cite: 8]
        HEX1 : out std_logic_vector(0 to 6)      -- Exibe Resultado [cite: 8, 17]
    );
end lab07;

architecture behavioral of lab07 is
    signal a, b, cin : std_logic;
    signal res_soma  : std_logic_vector(1 downto 0);
begin
    -- Atribuição das entradas conforme roteiro [cite: 53, 54, 55]
    a   <= SW(2);
    b   <= SW(1);
    cin <= SW(0);

    -- Lógica do Somador Completo (Full Adder) [cite: 57, 58]
    res_soma(0) <= a xor b xor cin; -- Bit de soma
    res_soma(1) <= (a and b) or (cin and (a xor b)); -- Bit de carry-out

    -- Decodificador 7 Segmentos (Lógica Negativa: '0' liga o segmento)
    -- Mapeamento para HEX7 (cin), HEX5 (b), HEX3 (a) [cite: 60, 61, 73, 75]
    HEX7 <= "0000001" when cin = '0' else "1001111";
    HEX5 <= "0000001" when b   = '0' else "1001111";
    HEX3 <= "0000001" when a   = '0' else "1001111";

    -- Mapeamento para HEX1 (Resultado da Soma: 0 a 3) [cite: 86, 87, 88]
    with res_soma select
        HEX1 <= "0000001" when "00", -- 0
                "1001111" when "01", -- 1
                "0010010" when "10", -- 2
                "0000110" when "11", -- 3
                "1111111" when others;
end behavioral;