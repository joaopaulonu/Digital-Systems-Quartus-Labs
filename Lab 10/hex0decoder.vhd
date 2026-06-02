library ieee;
use ieee.std_logic_1164.all;

entity hex0decoder is
    port (
        bin_in  : in  std_logic_vector(3 downto 0); -- valor binário de entrada (0..15)
        hex_out : out std_logic_vector(6 downto 0)  -- segmentos: g f e d c b a (ativo em '0')
    );
end entity hex0decoder;

architecture combinacional of hex0decoder is
begin

    -- Processo sensível a qualquer mudança na entrada
    process(bin_in)
    begin
        case bin_in is
            --                    gfedcba
            when "0000" => hex_out <= "1000000"; -- 0
            when "0001" => hex_out <= "1111001"; -- 1
            when "0010" => hex_out <= "0100100"; -- 2
            when "0011" => hex_out <= "0110000"; -- 3
            when "0100" => hex_out <= "0011001"; -- 4
            when "0101" => hex_out <= "0010010"; -- 5
            when "0110" => hex_out <= "0000010"; -- 6
            when "0111" => hex_out <= "1111000"; -- 7
            when "1000" => hex_out <= "0000000"; -- 8
            when "1001" => hex_out <= "0010000"; -- 9
            when "1010" => hex_out <= "0001000"; -- A
            when "1011" => hex_out <= "0000011"; -- b
            when "1100" => hex_out <= "1000110"; -- C
            when "1101" => hex_out <= "0100001"; -- d
            when "1110" => hex_out <= "0000110"; -- E
            when "1111" => hex_out <= "0001110"; -- F
            when others => hex_out <= "1111111"; -- display apagado para entradas inválidas
        end case;
    end process;

end architecture combinacional;