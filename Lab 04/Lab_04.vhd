library ieee;
use ieee.std_logic_1164.all;

entity lab04 is
port (
    SW: in std_logic_vector (1 downto 0);
    LEDR: out std_logic_vector (0 downto 0)
);
end entity lab04;

architecture bhv of lab04 is
begin
    LEDR(0) <= (NOT SW(0) AND SW(1)) OR (SW(0) AND NOT SW(1));
end architecture bhv;