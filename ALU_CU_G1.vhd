library IEEE;
use IEEE.std_logic_1164.all;

entity ALU_CU_G1 is
    port(
        F       : in  std_logic_vector(5 downto 0);
        ALUOp       : in  std_logic_vector(1 downto 0);
        OPCODE     : out std_logic_vector(2 downto 0)
    );
end entity ALU_CU_G1;

architecture struct of ALU_CU_G1 is

begin

    OPCODE(0) <= (ALUOp(1) and (F(3) or F(0)));
    OPCODE(1) <= (not(ALUOp(1)) or not(F(2)));
    OPCODE(2) <= (ALUOp(0) or (ALUOp(1) and F(1)));

end architecture struct;