library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity lab07_tb is
end lab07_tb;

architecture sim of lab07_tb is
    -- Sinais para conexão com o componente
    signal sw_s    : std_logic_vector(2 downto 0);
    signal h7, h5, h3, h1 : std_logic_vector(0 to 6);
begin
    -- Instanciação da Unidade Sob Teste (UUT)
    uut: entity work.lab07
        port map (
            SW => sw_s, HEX7 => h7, HEX5 => h5, HEX3 => h3, HEX1 => h1
        );

    -- Processo de estímulo com loop [cite: 101, 104]
    stim_proc: process
    begin
        for i in 0 to 7 loop
            -- Converte o índice do loop para vetor de 3 bits [cite: 105, 106]
            sw_s <= std_logic_vector(to_unsigned(i, 3));
            wait for 20 ns;
        end loop;
        wait;
    end process;
end sim;