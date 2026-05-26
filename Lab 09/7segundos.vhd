library ieee; -- Importa a biblioteca padrão para lógica digital
use ieee.std_logic_1164.all; -- Carrega as definições de sinais necessárias

entity dec7seg is -- Inicia a definição do componente decodificador para o visor
    port (
        hex : in  std_logic_vector(3 downto 0); -- Entrada do valor binário (4 bits)
        seg : out std_logic_vector(6 downto 0)  -- Saída para controlar os 7 leds do visor
    );
end entity dec7seg; -- Finaliza a estrutura externa do decodificador

architecture rtl of dec7seg is -- Começa a descrever como a conversão de dados funciona
begin
    process(hex) -- Inicia um procedimento que reage a qualquer mudança na entrada hex
    begin
        case hex is -- Avalia o valor da entrada para escolher o desenho no visor
            -- Define qual segmento acende (0) ou apaga (1) para cada caso
            when "0000" => seg <= "1000000"; -- Configura os leds para formar o número 0
            when "0001" => seg <= "1111001"; -- Configura os leds para formar o número 1
            when "0010" => seg <= "0100100"; -- Configura os leds para formar o número 2
            when "0011" => seg <= "0110000"; -- Configura os leds para formar o número 3
            when "0100" => seg <= "0011001"; -- Configura os leds para formar o número 4
            when "0101" => seg <= "0010010"; -- Configura os leds para formar o número 5
            when "0110" => seg <= "0000010"; -- Configura os leds para formar o número 6
            when "0111" => seg <= "1111000"; -- Configura os leds para formar o número 7
            when "1000" => seg <= "0000000"; -- Configura os leds para formar o número 8
            when "1001" => seg <= "0010000"; -- Configura os leds para formar o número 9
            when "1010" => seg <= "0001000"; -- Configura os leds para formar a letra A
            when "1011" => seg <= "0000011"; -- Configura os leds para formar a letra b
            when "1100" => seg <= "1000110"; -- Configura os leds para formar a letra C
            when "1101" => seg <= "0100001"; -- Configura os leds para formar a letra d
            when "1110" => seg <= "0000110"; -- Configura os leds para formar a letra E
            when others => seg <= "0001110"; -- Configura os leds para qualquer outro caso (letra F)
        end case; -- Finaliza a escolha dos padrões
    end process; -- Termina o procedimento de conversão
end architecture rtl; -- Finaliza a descrição do comportamento do componente