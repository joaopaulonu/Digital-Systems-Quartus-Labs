library IEEE;
use ieee.std_logic_1164.all;
use work.adder_package.all; -- Importa o package acima

entity adder is -- Agora o nome da Entity é igual ao nome do Arquivo
    port(
        SW : in std_logic_vector(3 downto 0);
        LEDR: out std_logic_vector(2 downto 0)
    );
end adder;

architecture arc_somador of adder is
    signal c0, cout_final: std_logic;
    signal A, B, SUM: std_logic_vector(1 downto 0);
begin
    -- Mapeamento conforme o roteiro [cite: 7]
    A <= SW(1 downto 0); -- SW0 e SW1
    B <= SW(3 downto 2); -- SW2 e SW3

    -- Instanciação dos componentes [cite: 95]
    U0: half_adde port map (a => A(0), b => B(0), sum => SUM(0), carry => c0);
    U1: full_adder port map (a => A(1), b => B(1), cin => c0, sum => SUM(1), cout => cout_final);

    -- Saídas para os LEDs [cite: 8]
    LEDR(0) <= SUM(0);
    LEDR(1) <= SUM(1);
    LEDR(2) <= cout_final; -- Carry out no LED 2
end arc_somador;