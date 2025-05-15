library ieee;
use  ieee.std_logic_1164.all;

entity mux2to1_5bit is
    Port(
        IN0, IN1   :in STD_LOGIC_VECTOR(4 downto 0);
        SEL   :in STD_LOGIC;
        OUT0      :out STD_LOGIC_VECTOR(4 downto 0));
end mux2to1_5bit;

architecture struct of mux2to1_5bit is

    signal S: std_logic_vector(4 downto 0);
begin

    S <= (others => SEL);

    OUT0 <= (IN0 and not(S)) or (IN1 and S);
    
end architecture;