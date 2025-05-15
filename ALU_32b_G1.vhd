library IEEE;
use IEEE.std_logic_1164.all;

entity ALU_32b_G1 is
    port(
        A      : in  std_logic_vector(31 downto 0);
        B      : in  std_logic_vector(31 downto 0);
        S     : out std_logic_vector(31 downto 0)
    );
end entity ALU_32b_G1;

architecture struct of ALU_32b_G1 is

    signal C   : std_logic_vector(32 downto 0);

begin

    FA_GEN: for i in 0 to 31 generate
        FA_inst: entity work.FA_G1(structural)
            port map(
                x    => A(i),
                y    => B(i),
                cin  => C(i),
                s    => S(i),
                cout => C(i+1)
            );
end generate;


end architecture struct;