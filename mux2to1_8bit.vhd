library ieee;
use ieee.std_logic_1164.all;

entity mux2to1_8Bit is
    port (
        input0, input1 : in std_logic_vector(7 downto 0); -- 8-bit inputs
        sel            : in std_logic;                       -- Select signal
        output         : out std_logic_vector(7 downto 0) -- 8-bit output
    );
end entity;

architecture structural of mux2to1_8Bit is

begin

    mux0 : entity work.mux2to1_1Bit
        port map(
            sel     => sel,
            output  => output(0),
            input0  => input0(0),
            input1  => input1(0)
        );
    
    mux1 : entity work.mux2to1_1Bit
        port map(
            sel     => sel,
            output  => output(1),
            input0  => input0(1),
            input1  => input1(1)
        );
    
    mux2 : entity work.mux2to1_1Bit
        port map(
            sel     => sel,
            output  => output(2),
            input0  => input0(2),
            input1  => input1(2)
        );
    
    mux3 : entity work.mux2to1_1Bit
        port map(
            sel     => sel,
            output  => output(3),
            input0  => input0(3),
            input1  => input1(3)
        );

    mux4 : entity work.mux2to1_1Bit
        port map(
            sel     => sel,
            output  => output(4),
            input0  => input0(4),
            input1  => input1(4)
        );
    
    mux5 : entity work.mux2to1_1Bit
        port map(
            sel     => sel,
            output  => output(5),
            input0  => input0(5),
            input1  => input1(5)
        );
    
    mux6 : entity work.mux2to1_1Bit
        port map(
            sel     => sel,
            output  => output(6),
            input0  => input0(6),
            input1  => input1(6)
        );

    mux7 : entity work.mux2to1_1Bit
        port map(
            sel     => sel,
            output  => output(7),
            input0  => input0(7),
            input1  => input1(7)
        );    

end architecture;
