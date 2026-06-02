library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all; -- permite soma direta em std_logic_vector

entity contador is
    port (
        KEY  : in  std_logic_vector(3 downto 0); -- botões (ativos em '0')
        SW   : in  std_logic_vector(0 downto 0); -- chaves (ativas em '1')
        LEDR : out std_logic_vector(3 downto 0); -- LEDs vermelhos 0 a 3
        HEX0 : out std_logic_vector(6 downto 0)  -- display de 7 segmentos
    );
end entity contador;

architecture estrutural of contador is

    -- Declaração do componente decodificador definido em hex0decoder.vhd
    component hex0decoder is
        port (
            bin_in  : in  std_logic_vector(3 downto 0);
            hex_out : out std_logic_vector(6 downto 0)
        );
    end component;

    -- Sinal interno que armazena o valor atual do contador
    signal contador : std_logic_vector(3 downto 0) := "0000";

    -- Aliases para facilitar leitura do código
    alias clk    : std_logic is KEY(3); -- KEY(3) usado como clock
    alias resetn : std_logic is KEY(0); -- KEY(0) reset assíncrono (ativo baixo)
    alias enable : std_logic is SW(0);  -- SW(0) como enable

begin

    -- Processo de contagem: sensível ao clock e ao reset
    -- Reset assíncrono: atua independente do clock quando KEY(0) = '0'
    process(clk, resetn)
    begin
        if resetn = '0' then
            -- Reset assíncrono: zera o contador imediatamente
            contador <= "0000";

        elsif falling_edge(clk) then
            -- KEY(3) é ativo baixo, então o pressionamento gera borda de descida
            if enable = '1' then
                -- Incrementa somente se o enable estiver ativo
                contador <= contador + 1; -- overflow natural de 1111 para 0000
            end if;
        end if;
    end process;

    -- Conexão da saída binária nos LEDs vermelhos (bits 0 a 3)
    LEDR <= contador;

    -- Instância do decodificador para o display HEX0
    U1 : hex0decoder
        port map (
            bin_in  => contador,
            hex_out => HEX0
        );

end architecture estrutural;