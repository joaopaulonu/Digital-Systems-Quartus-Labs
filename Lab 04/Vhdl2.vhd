library ieee;
use ieee.std_logic_1164.all;

entity lab04_tb is
end entity lab04_tb;

architecture tb of lab04_tb is
    signal vetor_e: std_logic_vector(1 downto 0);
    signal vetor_s: std_logic_vector(0 downto 0);
begin
    uut: entity work.lab04 port map( SW => vetor_e, LEDR => vetor_s );
    
    process
    begin
        vetor_e <= "00";
        wait for 100 ps;
        vetor_e <= "01";
        wait for 100 ps;
        vetor_e <= "10";
        wait for 100 ps;
        vetor_e <= "11";
        wait for 100 ps;
        wait;
    end process;
end architecture tb;