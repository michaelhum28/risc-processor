library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity registerFile is
    Port (
        reset    : in  STD_LOGIC;
        clk       : in  STD_LOGIC;
        RegWrite  : in  STD_LOGIC;
        ReadReg1  : in  STD_LOGIC_VECTOR(4 downto 0);
        ReadReg2  : in  STD_LOGIC_VECTOR(4 downto 0);
        WriteReg  : in  STD_LOGIC_VECTOR(4 downto 0);
        WriteData : in  STD_LOGIC_VECTOR(7 downto 0);
        ReadData1 : out STD_LOGIC_VECTOR(7 downto 0);
        ReadData2 : out STD_LOGIC_VECTOR(7 downto 0)
    );
end registerFile;

architecture structural of registerFile is

signal decOut : STD_LOGIC_VECTOR(31 downto 0);
signal notclk : STD_LOGIC;

-- Declare the array of signals
type R_out_array is array(0 to 31) of STD_LOGIC_VECTOR(7 downto 0);

-- Declare the array signal
signal R_out: R_out_array;

-- Intermediate signal for clock gating
signal regClock : STD_LOGIC_VECTOR(31 downto 0);

begin

notclk <= not clk;

decoder5to32 : entity work.decoder5to32(structural)
    port map(
        s => WriteReg,
        enable => '1',
        out_signal => decOut
    );

-- Generate intermediate clock signals
gen_clock_signals : for i in 0 to 31 generate
    regClock(i) <= decOut(i) and clk;
end generate gen_clock_signals;

gen_registers : for i in 0 to 31 generate
    R0 : entity work.register8Bit(structural)
        port map(
            i_reset => reset,
            i_load => RegWrite,
            i_clock => regClock(i),
            i_Value => WriteData,
            o_Value => R_out(i)
        );
end generate gen_registers;

RegisterFileMUX1 : entity work.mux32to1_8Bit(structural)
    port map(
        sel => ReadReg1,
        input0 => X"00",
        input1 => R_out(1),
        input2 => R_out(2),
        input3 => R_out(3),
        input4 => R_out(4),
        input5 => R_out(5),
        input6 => R_out(6),
        input7 => R_out(7),
        input8 => R_out(8),
        input9 => R_out(9),
        input10 => R_out(10),
        input11 => R_out(11),
        input12 => R_out(12),
        input13 => R_out(13),
        input14 => R_out(14),
        input15 => R_out(15),
        input16 => R_out(16),
        input17 => R_out(17),
        input18 => R_out(18),
        input19 => R_out(19),
        input20 => R_out(20),
        input21 => R_out(21),
        input22 => R_out(22),
        input23 => R_out(23),
        input24 => R_out(24),
        input25 => R_out(25),
        input26 => R_out(26),
        input27 => R_out(27),
        input28 => R_out(28),
        input29 => R_out(29),
        input30 => R_out(30),
        input31 => R_out(31),
        output => ReadData1
    );

RegisterFileMUX2 : entity work.mux32to1_8Bit(structural)
    port map(
        sel => ReadReg2,
        input0 => X"00",
        input1 => R_out(1),
        input2 => R_out(2),
        input3 => R_out(3),
        input4 => R_out(4),
        input5 => R_out(5),
        input6 => R_out(6),
        input7 => R_out(7),
        input8 => R_out(8),
        input9 => R_out(9),
        input10 => R_out(10),
        input11 => R_out(11),
        input12 => R_out(12),
        input13 => R_out(13),
        input14 => R_out(14),
        input15 => R_out(15),
        input16 => R_out(16),
        input17 => R_out(17),
        input18 => R_out(18),
        input19 => R_out(19),
        input20 => R_out(20),
        input21 => R_out(21),
        input22 => R_out(22),
        input23 => R_out(23),
        input24 => R_out(24),
        input25 => R_out(25),
        input26 => R_out(26),
        input27 => R_out(27),
        input28 => R_out(28),
        input29 => R_out(29),
        input30 => R_out(30),
        input31 => R_out(31),
        output => ReadData2
    );

end structural;