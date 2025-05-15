library ieee;
use ieee.std_logic_1164.all;

entity mux4to1_1Bit is
    port (
        sel: in std_logic_vector(1 downto 0);
        input: in std_logic_vector(3 downto 0);
        output: out std_logic
    );
end entity;

architecture structural of mux4to1_1Bit is

    signal internal1, internal2, internal3, internal4 : std_logic;

begin

    internal1 <= input(0) and not sel(1) and not sel(0);
    internal2 <= input(1) and not sel(1) and sel(0);
    internal3 <= input(2) and sel(1) and not sel(0);
    internal4 <= input(3) and sel(1) and sel(0);

    output <= internal1 or internal2 or internal3 or internal4;

end architecture;
