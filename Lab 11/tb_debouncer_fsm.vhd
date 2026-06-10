library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_debouncer_fsm is
    -- testbench nao possui portas externas
end entity tb_debouncer_fsm;

architecture sim of tb_debouncer_fsm is

    -- declaracao do componente a ser testado (DUT)
    component debouncer_fsm is
        port (
            Clock       : in  std_logic;
            Reset       : in  std_logic;
            Botao       : in  std_logic;
            Botao_limpo : out std_logic
        );
    end component;

    -- sinais de estimulo (entradas do DUT)
    signal tb_clock      : std_logic := '0';
    signal tb_reset      : std_logic := '0';
    signal tb_botao      : std_logic := '1';   -- inicia solto (nivel alto)

    -- sinal de observacao (saida do DUT)
    signal tb_botao_limpo : std_logic;

    -- periodo do clock de simulacao: 20 ns 
    constant T_CLK : time := 20 ns;

begin

    -- instancia o DUT (Device Under Test)
    dut : debouncer_fsm
        port map (
            Clock       => tb_clock,
            Reset       => tb_reset,
            Botao       => tb_botao,
            Botao_limpo => tb_botao_limpo
        );

    -- geracao do clock: alterna a cada meio periodo
    tb_clock <= not tb_clock after (T_CLK / 2);

    -- processo de estimulos
    stim_proc : process
    begin
        -- ---- FASE 1: reset inicial ----
        tb_reset <= '1';
        wait for 5 * T_CLK;
        tb_reset <= '0';
        wait for 3 * T_CLK;

        -- ---- FASE 2: simula ruido ao pressionar (botao vai para 0 com bounces) ----
        -- primeiro pulso curto (ruido): nao deve mudar estado
        tb_botao <= '0';
        wait for 2 * T_CLK;
        tb_botao <= '1';    -- ruido: volta para alto brevemente
        wait for 1 * T_CLK;

        -- segundo pulso curto (ruido):
        tb_botao <= '0';
        wait for 3 * T_CLK;
        tb_botao <= '1';
        wait for 1 * T_CLK;

        -- pressao estavel por longo periodo (supera limiar no hardware real)
        -- na simulacao, representa o sinal estabilizado
        tb_botao <= '0';
        wait for 50 * T_CLK;   -- representa periodo estavel

        -- ---- FASE 3: simula ruido ao soltar ----
        tb_botao <= '1';
        wait for 2 * T_CLK;
        tb_botao <= '0';    -- ruido: volta brevemente
        wait for 1 * T_CLK;

        -- sinal solto de forma estavel
        tb_botao <= '1';
        wait for 50 * T_CLK;

        -- ---- FASE 4: reset durante operacao ----
        tb_reset <= '1';
        wait for 5 * T_CLK;
        tb_reset <= '0';
        wait for 10 * T_CLK;

        -- encerra simulacao
        wait;
    end process;

end architecture sim;
