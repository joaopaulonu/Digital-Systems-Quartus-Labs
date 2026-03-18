library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity lab05_tb is
end lab05_tb;

architecture sim of lab05_tb is
    signal sw0, sw1, sw2 : std_logic := '0';
    signal ldr0, ldr1    : std_logic;
begin
    -- Instancia o componente
    uut: entity work.lab05 port map (
        SW0 => sw0, SW1 => sw1, SW2 => sw2,
        LDR0 => ldr0, LDR1 => ldr1
    );

    process
    begin
        -- Teste de todas as combinações (000 a 111)
        sw2 <= '0'; sw1 <= '0'; sw0 <= '0'; wait for 10 ns;
        sw2 <= '0'; sw1 <= '0'; sw0 <= '1'; wait for 10 ns;
        sw2 <= '0'; sw1 <= '1'; sw0 <= '0'; wait for 10 ns;
        sw2 <= '0'; sw1 <= '1'; sw0 <= '1'; wait for 10 ns;
        sw2 <= '1'; sw1 <= '0'; sw0 <= '0'; wait for 10 ns;
        sw2 <= '1'; sw1 <= '0'; sw0 <= '1'; wait for 10 ns;
        sw2 <= '1'; sw1 <= '1'; sw0 <= '0'; wait for 10 ns;
        sw2 <= '1'; sw1 <= '1'; sw0 <= '1'; wait for 10 ns;
        wait;
    end process;
end sim;