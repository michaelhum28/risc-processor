library ieee;
use ieee.std_logic_1164.all;

entity mux32to1_8Bit is
    port (
        sel : in std_logic_vector(4 downto 0); -- 5-bit select signal for 32 inputs
        input0, input1, input2, input3, input4, input5, input6, input7, input8, input9, input10, input11, input12, input13, input14, input15, input16, input17, input18, input19, input20, input21, input22, input23, input24, input25, input26, input27, input28, input29, input30, input31 : in std_logic_vector(7 downto 0);
        output : out std_logic_vector(7 downto 0)
    );
end entity;

architecture structural of mux32to1_8Bit is

signal mux0, mux1, mux2, mux3 : std_logic_vector(7 downto 0);

begin

MUX4to1_8bit : entity work.mux4to1_8Bit(structural)
    port map (
        sel => sel(4 downto 3),
        input0 => mux0,
        input1 => mux1,
        input2 => mux2,
        input3 => mux3,
        output => output
    );


MUX0_8to1_8Bit: entity work.mux8to1_8Bit(structural)
	port map (
        sel => sel(2 downto 0),
        input0 => input0,
        input1 => input1,
        input2 => input2,
        input3 => input3,
        input4 => input4,
        input5 => input5,
        input6 => input6,
        input7 => input7,
        output => mux0
	);

MUX1_8to1_8Bit: entity work.mux8to1_8Bit(structural)
    port map (
        sel => sel(2 downto 0),
        input0 => input8,
        input1 => input9,
        input2 => input10,
        input3 => input11,
        input4 => input12,
        input5 => input13,
        input6 => input14,
        input7 => input15,
        output => mux1
    );

MUX2_8to1_8Bit: entity work.mux8to1_8Bit(structural)
    port map (
        sel => sel(2 downto 0),
        input0 => input16,
        input1 => input17,
        input2 => input18,
        input3 => input19,
        input4 => input20,
        input5 => input21,
        input6 => input22,
        input7 => input23,
        output => mux2
    );

MUX3_8to1_8Bit: entity work.mux8to1_8Bit(structural)
    port map (
        sel => sel(2 downto 0),
        input0 => input24,
        input1 => input25,
        input2 => input26,
        input3 => input27,
        input4 => input28,
        input5 => input29,
        input6 => input30,
        input7 => input31,
        output => mux3
    );


end architecture;
