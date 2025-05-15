library ieee;
use ieee.std_logic_1164.all;

entity mux8to1_1Bit is

	port (
		sel: in std_logic_vector(2 downto 0);
		input: in std_logic_vector(7 downto 0);
		output: out std_logic
	);
end entity;

architecture structural of mux8to1_1Bit is

	signal muxOut : STD_LOGIC_VECTOR(1 downto 0);

begin

MUX0 : entity work.mux2to1_1Bit(structural)
	port map(
		sel => sel(2),
		input1 => muxOut(0),
		input0 => muxOut(1),
		output => output
	);

MUX1 : entity work.mux4to1_1Bit(structural)
	port map(
		sel => sel(1 downto 0),
		input => input(3 downto 0),
		output => muxOut(0)
	);

MUX2 : entity work.mux4to1_1Bit(structural)
	port map(
		sel => sel(1 downto 0),
		input => input(7 downto 4),
		output => muxOut(1)
	);

end architecture;