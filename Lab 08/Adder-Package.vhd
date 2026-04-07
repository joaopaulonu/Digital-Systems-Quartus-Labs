library IEEE;
use ieee.std_logic_1164.all;

package adder_package is -- Nome do package ajustado
    component half_adde is
        port (a, b: in std_logic; sum, carry: out std_logic);
    end component;

    component full_adder is
        port (a, b, cin: in std_logic; sum, cout: out std_logic);
    end component;
end package adder_package;