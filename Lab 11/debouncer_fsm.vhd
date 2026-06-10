library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity debouncer_fsm is
    port (
        clk    : in  std_logic;
        reset  : in  std_logic;
        botao  : in  std_logic;
        saida  : out std_logic
    );
end entity;

architecture arq of debouncer_fsm is
    constant LIMIAR : integer := 1000000;
    type estado_t is (SOLTO, CONTANDO_PRESS, PRESSIONADO, CONTANDO_SOLTA);
    signal estado : estado_t := SOLTO;
    signal count  : integer range 0 to LIMIAR := 0;
    signal s_saida : std_logic := '1';
begin
    process(clk, reset)
    begin
        if reset = '0' then
            estado <= SOLTO;
            count <= 0;
            s_saida <= '1';
        elsif rising_edge(clk) then
            case estado is
                when SOLTO =>
                    if botao = '0' then estado <= CONTANDO_PRESS; end if;
                when CONTANDO_PRESS =>
                    if count >= LIMIAR then estado <= PRESSIONADO; s_saida <= '0'; count <= 0;
                    elsif botao = '1' then estado <= SOLTO; count <= 0;
                    else count <= count + 1; end if;
                when PRESSIONADO =>
                    if botao = '1' then estado <= CONTANDO_SOLTA; end if;
                when CONTANDO_SOLTA =>
                    if count >= LIMIAR then estado <= SOLTO; s_saida <= '1'; count <= 0;
                    elsif botao = '0' then estado <= PRESSIONADO; count <= 0;
                    else count <= count + 1; end if;
            end case;
        end if;
    end process;
    saida <= s_saida;
end architecture;