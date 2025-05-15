library ieee;
use ieee.std_logic_1164.all;


entity carryLookaheadAdder8Bit is

	port (
		a, b : in std_logic_vector(7 downto 0);
		c_0 : in std_logic;
		s : out std_logic_vector(7 downto 0);
		c_8 : out std_logic
	);

end entity;

architecture structural of carryLookaheadAdder8Bit is

	signal g0, g1, g2, g3, g4, g5, g6, g7,
	p0, p1, p2, p3, p4, p5, p6, p7,
	c0, c1, c2, c3, c4, c5, c6, c7, c8 : std_logic;

begin

	--generates
	g0 <= a(0) and b(0);
	g1 <= a(1) and b(1);
	g2 <= a(2) and b(2);
	g3 <= a(3) and b(3);
	g4 <= a(4) and b(4);
	g5 <= a(5) and b(5);
	g6 <= a(6) and b(6);
	g7 <= a(7) and b(7);
	
	--propagates
	p0 <= a(0) or b(0);
	p1 <= a(1) or b(1);
	p2 <= a(2) or b(2);
	p3 <= a(3) or b(3);
	p4 <= a(4) or b(4);
	p5 <= a(5) or b(5);
	p6 <= a(6) or b(6);
	p7 <= a(7) or b(7);

	--carry equations
	c0 <= c_0;
	c1 <= g0 or (p0 and c0);
	c2 <= g1 or (p1 and g0) or (p1 and p0 and c0);
	c3 <= g2 or (g1 and p2) or (g0 and p2 and p1) or (c0 and p2 and p1 and p0); 
	c4 <= g3 or (g2 and p3) or (g1 and p3 and p2) or (g0 and p3 and p2 and p1) or (p3 and p2 and p1 and p0 and c0);
	c5 <= g4 or (g3 and p4) or (g2 and p4 and p3) or (g1 and p4 and p3 and p2) or (g0 and p4 and p3 and p2 and p1) or (p4 and p3 and p2 and p1 and p0 and c0);
	c6 <= g5 or (g4 and p5) or (g3 and p5 and p4) or (g2 and p5 and p4 and p3) or (g1 and p5 and p4 and p3 and p2) or (g0 and p5 and p4 and p3 and p2 and p1) or
	(p5 and p4 and p3 and p2 and p1 and p0 and c0);
	c7 <= g6 or (g5 and p6) or (g4 and p6 and p5) or (g3 and p6 and p5 and p4) or (g2 and p6 and p5 and p4 and p3) or (g1 and p6 and p5 and p4 and p3 and p2) or
	(g0 and p6 and p5 and p4 and p3 and p2 and p1) or (c0 and p6 and p5 and p4 and p3 and p2 and p1 and p0);
	c8 <= g7 or (g6 and p7) or (g5 and p7 and p6) or (g4 and p7 and p6 and p5) or (g3 and p7 and p6 and p5 and p4) or (g2 and p7 and p6 and p5 and p4 and p3) or
	(g1 and p7 and p6 and p5 and p4 and p3 and p2) or (g0 and p7 and p6 and p5 and p4 and p3 and p2 and p1) or (c0 and p7 and p6 and p5 and p4 and p3 and p2 and p1 and p0);
	c_8 <= c8;
	
	--sum equations
	s(0) <= a(0) xor b(0) xor c0;
	s(1) <= a(1) xor b(1) xor c1;
	s(2) <= a(2) xor b(2) xor c2;
	s(3) <= a(3) xor b(3) xor c3;
	s(4) <= a(4) xor b(4) xor c4;
	s(5) <= a(5) xor b(5) xor c5;
	s(6) <= a(6) xor b(6) xor c6;
	s(7) <= a(7) xor b(7) xor c7;



end architecture;