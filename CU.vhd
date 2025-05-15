library IEEE;
use IEEE.std_logic_1164.all;

entity CU is
    port(
        OPCODE : in std_logic_vector(5 downto 0);
        Zero, Hazard : in std_logic;
        RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, Bne, Jump, IF_Flush : out std_logic;
        ALUOp : out std_logic_vector(1 downto 0)
    );
end entity;

architecture structural of CU is

signal rformat, lw, sw, beq, bne_int, jump_int : std_logic;

begin

rformat <= not OPCODE(5) and not OPCODE(4) and not OPCODE(3) and not OPCODE(2) and not OPCODE(1) and not OPCODE(0);
lw <= OPCODE(5) and not OPCODE(4) and not OPCODE(3) and not OPCODE(2) and OPCODE(1) and OPCODE(0);
sw <= OPCODE(5) and not OPCODE(4) and OPCODE(3) and not OPCODE(2) and OPCODE(1) and OPCODE(0);
jump_int  <= not OPCODE(5) and not OPCODE(4) and not OPCODE(3) and not OPCODE(2) and OPCODE(1) and not OPCODE(0);
beq <= not OPCODE(5) and not OPCODE(4) and not OPCODE(3) and OPCODE(2) and not OPCODE(1) and not OPCODE(0);
bne_int <= not OPCODE(5) and not OPCODE(4) and not OPCODE(3) and OPCODE(2) and not OPCODE(1) and OPCODE(0);

RegDst <= rformat;
ALUSrc <= lw or sw;
MemtoReg <= lw and not Hazard; --M
RegWrite <= (rformat or lw) and not Hazard; --WB
MemRead <= lw and not Hazard; --M
MemWrite <= sw and not Hazard; --M
Branch <= beq;
Bne <= bne_int;
Jump <= jump_int;
ALUOp(1) <= rformat;
ALUOp(0) <= beq or bne_int;
IF_Flush <= (bne_int and not(Zero)) or (beq and Zero) or jump_int;

end;