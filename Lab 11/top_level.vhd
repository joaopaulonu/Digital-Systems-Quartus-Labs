library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity top_level is
    port (
        CLOCK_50 : in std_logic;
        KEY      : in std_logic_vector(3 downto 0); -- KEY0 (Reset) e KEY3 (Botão)
        SW       : in std_logic_vector(0 downto 0); -- SW0 (Enable)
        LEDR     : out std_logic_vector(3 downto 0); -- LEDs vermelhos (Binário)
        HEX0     : out std_logic_vector(6 downto 0)  -- Display 7 segmentos (Hexa)
    );
end entity;

architecture rtl of top_level is
    signal debounced_key3 : std_logic;
    signal debounced_key3_reg : std_logic := '1';
    signal count : unsigned(3 downto 0) := "0000";
begin

    -- 1. Instancia o Debouncer 
    u_debouncer : entity work.debouncer_fsm
    port map (
        clk    => CLOCK_50,
        reset  => KEY(0),
        botao  => KEY(3),
        saida  => debounced_key3
    );

    -- 2. Processo do Contador 
    process(debounced_key3, KEY(0))
    begin
        if KEY(0) = '0' then -- Reset Assíncrono
            count <= "0000";
            debounced_key3_reg <= '1';
        elsif rising_edge(debounced_key3) then
            -- Guarda o estado anterior do botão com debounce
            debounced_key3_reg <= debounced_key3;

            -- Detecta a borda de descida (quando o botão é fisicamente apertado)
            if debounced_key3 = '1'  then
                if SW(0) = '1' then -- Só conta se o Enable (SW0) estiver ativado
                    count <= count + 1;
                end if;
            end if;
        end if;
    end process;

    -- 3. Saída para os LEDs em binário
    LEDR(3 downto 0) <= std_logic_vector(count);

    -- 4. Decodificador para o Display de 7 Segmentos (HEX0)
    process(count)
    begin
        case count is
            when "0000" => HEX0 <= "1000000"; -- 0
            when "0001" => HEX0 <= "1111001"; -- 1
            when "0010" => HEX0 <= "0100100"; -- 2
            when "0011" => HEX0 <= "0110000"; -- 3
            when "0100" => HEX0 <= "0011001"; -- 4
            when "0101" => HEX0 <= "0010010"; -- 5
            when "0110" => HEX0 <= "0000010"; -- 6
            when "0111" => HEX0 <= "1111000"; -- 7
            when "1000" => HEX0 <= "0000000"; -- 8
            when "1001" => HEX0 <= "0010000"; -- 9
            when "1010" => HEX0 <= "0001000"; -- A
            when "1011" => HEX0 <= "0000011"; -- b
            when "1100" => HEX0 <= "1000110"; -- C
            when "1101" => HEX0 <= "0100001"; -- d
            when "1110" => HEX0 <= "0000110"; -- E
            when "1111" => HEX0 <= "0001110"; -- F
            when others => HEX0 <= "1111111"; -- Apagado
        end case;
    end process;

end architecture;