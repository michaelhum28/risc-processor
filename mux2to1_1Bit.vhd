library ieee;
use ieee.std_logic_1164.all;

entity mux2to1_1Bit is

	port (
		input0: in std_logic;
		input1 : in std_logic;
		sel: in std_logic;
		output: out std_logic
	);

end entity;

architecture structural of mux2to1_1Bit is

	signal internal1, internal2 : std_logic;

begin

	internal1 <= input0 and not sel;
	internal2 <= input1 and sel;
	output <= internal1 or internal2;

end architecture;