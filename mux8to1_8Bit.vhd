library ieee;
use ieee.std_logic_1164.all;

entity mux8to1_8Bit is

	port (
		sel: in std_logic_vector(2 downto 0);
		input0, input1, input2, input3, input4, input5, input6, input7 : in std_logic_vector(7 downto 0);
		output: out std_logic_vector(7 downto 0)
	);
end entity;

architecture structural of mux8to1_8Bit is

	signal S2, S1, S0 : std_logic_vector(7 downto 0);

begin

	S2 <= (others => sel(2));
	S1 <= (others => sel(1));
	S0 <= (others => sel(0));

	output <= (input0 and not(S2) and not(S1) and not(S0)) or
			(input1 and not(S2) and not(S1) and S0) or
			(input2 and not(S2) and S1 and not(S0)) or
			(input3 and not(S2) and S1 and S0) or
			(input4 and S2 and not(S1) and not(S0)) or
			(input5 and S2 and not(S1) and S0) or
			(input6 and (S2) and S1 and not(S0)) or
			(input7 and (S2) and (S1) and S0);

end architecture;