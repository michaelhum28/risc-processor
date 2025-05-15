library ieee;
use ieee.std_logic_1164.all;

entity mux4to1_8Bit is
    port (
        sel: in std_logic_vector(1 downto 0);
        input0, input1, input2, input3 : in std_logic_vector(7 downto 0);
        output: out std_logic_vector(7 downto 0)
    );
end entity;

architecture structural of mux4to1_8Bit is

    signal mux0, mux1, mux2, mux3, mux4, mux5, mux6, mux7 : std_logic_vector(3 downto 0);

begin

mux0 <= input3(0) & input2(0) & input1(0) & input0(0);
mux1 <= input3(1) & input2(1) & input1(1) & input0(1);
mux2 <= input3(2) & input2(2) & input1(2) & input0(2);
mux3 <= input3(3) & input2(3) & input1(3) & input0(3);
mux4 <= input3(4) & input2(4) & input1(4) & input0(4);
mux5 <= input3(5) & input2(5) & input1(5) & input0(5);
mux6 <= input3(6) & input2(6) & input1(6) & input0(6);
mux7 <= input3(7) & input2(7) & input1(7) & input0(7);

MUX0_4to1_8bit : entity work.mux4to1_1Bit(structural)
    port map(
        sel => sel,
        input => mux0,
        output => output(0)
    );

MUX1_4to1_8bit : entity work.mux4to1_1Bit(structural)
    port map(
        sel => sel,
        input => mux1,
        output => output(1)
    );

MUX2_4to1_8bit : entity work.mux4to1_1Bit(structural)
    port map(
        sel => sel,
        input => mux2,
        output => output(2)
    );

MUX3_4to1_8bit : entity work.mux4to1_1Bit(structural)
    port map(
        sel => sel,
        input => mux3,
        output => output(3)
    );

MUX4_4to1_8bit : entity work.mux4to1_1Bit(structural)
    port map(
        sel => sel,
        input => mux4,
        output => output(4)
    );

MUX5_4to1_8bit : entity work.mux4to1_1Bit(structural)
    port map(
        sel => sel,
        input => mux5,
        output => output(5)
    );

MUX6_4to1_8bit : entity work.mux4to1_1Bit(structural)
    port map(
        sel => sel,
        input => mux6,
        output => output(6)
    );

MUX7_4to1_8bit : entity work.mux4to1_1Bit(structural)
    port map(
        sel => sel,
        input => mux7,
        output => output(7)
    );

end architecture;
