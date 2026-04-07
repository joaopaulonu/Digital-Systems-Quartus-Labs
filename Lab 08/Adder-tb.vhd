library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity somador_tb is
end somador_tb;

architecture sim of somador_tb is
    component adder is -- Nome atualizado
        port(SW : in std_logic_vector(3 downto 0); LEDR: out std_logic_vector(2 downto 0));
    end component;

    signal sw_in : std_logic_vector(3 downto 0) := (others => '0');
    signal ledr_out : std_logic_vector(2 downto 0);
begin
    uut: adder port map(SW => sw_in, LEDR => ledr_out);

    process
    begin
        -- Testa todas as 16 combinações de entrada (0000 a 1111) 
        for i in 0 to 15 loop
            sw_in <= std_logic_vector(to_unsigned(i, 4));
            wait for 10 ns;
        end loop;
        wait;
    end process;
end sim;