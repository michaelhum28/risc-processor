library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity decoder5to32 is
    Port (
        s      : in  STD_LOGIC_VECTOR(4 downto 0);  -- 5-bit input
        enable     : in  STD_LOGIC;  -- Global enable
        out_signal : out STD_LOGIC_VECTOR(31 downto 0) -- One-hot output
    );
end decoder5to32;

architecture Structural of decoder5to32 is
    signal s_not : STD_LOGIC_VECTOR(4 downto 0);  -- Complement of sel bits
begin
    -- Generate complements of sel bits
    s_not <= not s;

    -- Decode logic for each output bit
    out_signal(0)  <= enable and s_not(4) and s_not(3) and s_not(2) and s_not(1) and s_not(0);
    out_signal(1)  <= enable and s_not(4) and s_not(3) and s_not(2) and s_not(1) and s(0);
    out_signal(2)  <= enable and s_not(4) and s_not(3) and s_not(2) and s(1) and s_not(0);
    out_signal(3)  <= enable and s_not(4) and s_not(3) and s_not(2) and s(1) and s(0);
    out_signal(4)  <= enable and s_not(4) and s_not(3) and s(2) and s_not(1) and s_not(0);
    out_signal(5)  <= enable and s_not(4) and s_not(3) and s(2) and s_not(1) and s(0);
    out_signal(6)  <= enable and s_not(4) and s_not(3) and s(2) and s(1) and s_not(0);
    out_signal(7)  <= enable and s_not(4) and s_not(3) and s(2) and s(1) and s(0);
    out_signal(8)  <= enable and s_not(4) and s(3) and s_not(2) and s_not(1) and s_not(0);
    out_signal(9)  <= enable and s_not(4) and s(3) and s_not(2) and s_not(1) and s(0);
    out_signal(10) <= enable and s_not(4) and s(3) and s_not(2) and s(1) and s_not(0);
    out_signal(11) <= enable and s_not(4) and s(3) and s_not(2) and s(1) and s(0);
    out_signal(12) <= enable and s_not(4) and s(3) and s(2) and s_not(1) and s_not(0);
    out_signal(13) <= enable and s_not(4) and s(3) and s(2) and s_not(1) and s(0);
    out_signal(14) <= enable and s_not(4) and s(3) and s(2) and s(1) and s_not(0);
    out_signal(15) <= enable and s_not(4) and s(3) and s(2) and s(1) and s(0);
    out_signal(16) <= enable and s(4) and s_not(3) and s_not(2) and s_not(1) and s_not(0);
    out_signal(17) <= enable and s(4) and s_not(3) and s_not(2) and s_not(1) and s(0);
    out_signal(18) <= enable and s(4) and s_not(3) and s_not(2) and s(1) and s_not(0);
    out_signal(19) <= enable and s(4) and s_not(3) and s_not(2) and s(1) and s(0);
    out_signal(20) <= enable and s(4) and s_not(3) and s(2) and s_not(1) and s_not(0);
    out_signal(21) <= enable and s(4) and s_not(3) and s(2) and s_not(1) and s(0);
    out_signal(22) <= enable and s(4) and s_not(3) and s(2) and s(1) and s_not(0);
    out_signal(23) <= enable and s(4) and s_not(3) and s(2) and s(1) and s(0);
    out_signal(24) <= enable and s(4) and s(3) and s_not(2) and s_not(1) and s_not(0);
    out_signal(25) <= enable and s(4) and s(3) and s_not(2) and s_not(1) and s(0);
    out_signal(26) <= enable and s(4) and s(3) and s_not(2) and s(1) and s_not(0);
    out_signal(27) <= enable and s(4) and s(3) and s_not(2) and s(1) and s(0);
    out_signal(28) <= enable and s(4) and s(3) and s(2) and s_not(1) and s_not(0);
    out_signal(29) <= enable and s(4) and s(3) and s(2) and s_not(1) and s(0);
    out_signal(30) <= enable and s(4) and s(3) and s(2) and s(1) and s_not(0);
    out_signal(31) <= enable and s(4) and s(3) and s(2) and s(1) and s(0);
end Structural;