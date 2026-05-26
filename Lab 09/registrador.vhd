library ieee; -- Importa a biblioteca padrão para lógica digital
use ieee.std_logic_1164.all; -- Carrega as definições de sinais para o projeto

entity registrador is -- Inicia a definição do componente que guarda informações
    port (
        clk    : in  std_logic; -- Entrada para o sinal de sincronismo (clock)
        enable : in  std_logic; -- Entrada que autoriza ou bloqueia a gravação
        d      : in  std_logic_vector(3 downto 0); -- Entrada dos dados de 4 bits
        q      : out std_logic_vector(3 downto 0)  -- Saída dos dados que foram memorizados
    );
end entity registrador; -- Finaliza a estrutura externa do registrador

architecture rtl of registrador is -- Começa a descrever como a memória interna funciona
    signal reg : std_logic_vector(3 downto 0) := "0000"; -- Cria um espaço de memória interna começando em zero
begin
    process(clk) -- Inicia um procedimento que observa as mudanças no clock
    begin
        if rising_edge(clk) then -- Verifica se o sinal de clock subiu (momento da ação)
            if enable = '1' then -- Testa se a autorização de gravação está ativa
                reg <= d; -- Copia o valor da entrada para a memória interna
            end if;
        end if;
    end process; -- Finaliza o procedimento de observação do clock
    q <= reg; -- Envia o valor guardado na memória interna para a saída do componente
end architecture rtl; -- Termina a descrição do comportamento interno