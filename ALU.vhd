library ieee;
use ieee.std_logic_1164.all;


entity ALU is

	port (
		A, B : in std_logic_vector(7 downto 0);
		OPCODE : in std_logic_vector(2 downto 0);
		ALUResult : out std_logic_vector(7 downto 0);
		Zero : out std_logic
	);
end entity;

architecture structural of ALU is

	signal adderSubOut, muxOut, ALessThanB7, AandB7, AorB7 : std_logic_vector(7 downto 0);
	signal adderSubCout, ALessThanB : std_logic;

begin

AandB7 <= A and B;
AorB7 <= A or B;

zero <= (muxOut(0) xnor '0') and (muxOut(1) xnor '0') and (muxOut(2) xnor '0') and (muxOut(3) xnor '0') and (muxOut(4) xnor '0') and (muxOut(5) xnor '0') and (muxOut(6) xnor '0') and (muxOut(7) xnor '0');

Comparator8bit : entity work.comparator8Bit(structural)
	port map(
		A => A,
		B => B,
		AlessB => ALessThanB
	);

AdderSubtractor8Bit : entity work.adderSubtractor8Bit(structural)
	port map(
		x => A,
		y => B,
		mode => OPCODE(2),
		s => adderSubOut,
		c_out => adderSubCout
	);

ALessThanB7(7 downto 1) <= (others => '0');
ALessThanB7(0) <= ALessThanB;

ALUMUX : entity work.mux8to1_8Bit(structural)
	port map(
		sel => OPCODE,
		input0 => AandB7, --000 A and B
		input1 => AorB7, --001 A or B
		input2 => adderSubOut, --010 Add
		input3 => (others => '0'), --011
		input4 => (others => '0'), --100
		input5 => (others => '0'), --101
		input6 => adderSubOut, --110 Subtract
		input7 => ALessThanB7, --111 A less than B
		output => muxOut
	);


ALUResult <= muxOut;
end architecture;