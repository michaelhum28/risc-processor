library ieee;
use ieee.std_logic_1164.all;

entity adderSubtractor8Bit is

	port (
		x, y : in std_logic_vector(7 downto 0); --performs x +/- y
		mode : in std_logic; -- add:0, subtract:1
		s : out std_logic_vector(7 downto 0);
		c_out : out std_logic
	);

end entity;

architecture structural of adderSubtractor8Bit is

	signal yAdded, mode8Bits : std_logic_vector(7 downto 0);

begin

	mode8Bits <= (others => mode);
	yAdded <= y xor mode8Bits;

	adder : entity work.carryLookaheadAdder8Bit(structural)
		port map(
			a => x,
			b => yAdded,
			c_0 => mode,
			s => s,
			c_8 => c_out
		);

end architecture;