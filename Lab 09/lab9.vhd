library ieee; -- Importa a biblioteca padrão para trabalhar com lógica digital
use ieee.std_logic_1164.all; -- Carrega as definições básicas de sinais (como '0' e '1')

entity lab09_top is -- Inicia a definição do bloco principal do projeto
    port ( -- Começa a lista de entradas e saídas físicas
        CLOCK_50 : in  std_logic;                    -- Entrada do sinal de relógio (ritmo do sistema)
        SW       : in  std_logic_vector(4 downto 0); -- 5 chaves: 4 para dados e 1 para controle
        HEX1     : out std_logic_vector(6 downto 0)  -- Saída para os 7 segmentos do visor
    );
end entity lab09_top; -- Finaliza a definição do bloco principal

architecture rtl of lab09_top is -- Inicia a explicação de como o bloco funciona por dentro
    signal dado_registrado : std_logic_vector(3 downto 0); -- Canal interno para guardar o valor que sai do registrador

    component registrador is -- Avisa ao sistema para usar o componente chamado registrador
        port (
            clk    : in  std_logic; -- Entrada de clock do registrador
            enable : in  std_logic; -- Entrada para autorizar a gravação
            d      : in  std_logic_vector(3 downto 0); -- Entrada dos dados (4 bits)
            q      : out std_logic_vector(3 downto 0)  -- Saída dos dados guardados
        );
    end component; -- Finaliza a declaração do componente registrador

    component dec7seg is -- Avisa ao sistema para usar o componente decodificador do visor
        port (
            hex : in  std_logic_vector(3 downto 0); -- Entrada do valor em binário
            seg : out std_logic_vector(6 downto 0)  -- Saída formatada para acender os leds
        );
    end component; -- Finaliza a declaração do componente do visor

begin -- Inicia a conexão das peças
    -- Instância única do Registrador
    U_REG : registrador -- Conecta as chaves e o clock no componente registrador
        port map (
            clk    => CLOCK_50,       -- Liga o clock da placa no clock do componente
            enable => SW(4),          -- Usa a quinta chave para liberar a gravação
            d      => SW(3 downto 0), -- Usa as outras 4 chaves como o valor a ser guardado
            q      => dado_registrado -- Envia o valor guardado para o canal interno
        );

    -- Instância única do Decodificador
    U_DEC : dec7seg -- Conecta o valor guardado ao componente que controla o visor
        port map (
            hex => dado_registrado, -- Pega o valor do canal interno
            seg => HEX1             -- Envia para os pinos que acendem o visor HEX1
        );
end architecture rtl; -- Termina a descrição do funcionamento