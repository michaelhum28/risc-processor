LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY register32Bit IS
    PORT(
        i_reset, i_load, i_clock: IN STD_LOGIC;
        i_Value     : IN  STD_LOGIC_VECTOR(31 downto 0);
        o_Value     : OUT STD_LOGIC_VECTOR(31 downto 0);
        o_ValueBar  : OUT STD_LOGIC_VECTOR(31 downto 0)
    );
END ENTITY;

ARCHITECTURE structural OF register32Bit IS
    SIGNAL int_Value, int_notValue : STD_LOGIC_VECTOR(31 downto 0);
    SIGNAL int_notreset : STD_LOGIC;
    COMPONENT enARdFF_2 --declare DFF component inputs and outputs
        PORT(
            i_reset : IN  STD_LOGIC;
            i_D     : IN  STD_LOGIC;
            i_EN    : IN  STD_LOGIC;
            i_clock : IN  STD_LOGIC;
            o_Q, o_Qn : OUT STD_LOGIC
        );
    END COMPONENT;

BEGIN
    int_notreset <= NOT i_reset;

    -- Each component is 1-bit, adding up to 8-bits, from MSB to LSB, assigning each bit to a position in the input and output vectors
    MSB: enARdFF_2
    PORT MAP (i_reset => int_notreset,
              i_EN  => i_load,
              i_clock  => i_clock,
              i_D      => i_Value(31), 
              o_Q      => int_Value(31),
              o_Qn     => int_notValue(31));

    Bit30: enARdFF_2
    PORT MAP (i_reset => int_notreset,
              i_EN  => i_load,
              i_clock  => i_clock,
              i_D      => i_Value(30), 
              o_Q      => int_Value(30),
              o_Qn     => int_notValue(30));

    Bit29: enARdFF_2
    PORT MAP (i_reset => int_notreset,
              i_EN  => i_load,
              i_clock  => i_clock,
              i_D      => i_Value(29), 
              o_Q      => int_Value(29),
              o_Qn     => int_notValue(29));

    Bit28: enARdFF_2
    PORT MAP (i_reset => int_notreset,
              i_EN  => i_load,
              i_clock  => i_clock,
              i_D      => i_Value(28), 
              o_Q      => int_Value(28),
              o_Qn     => int_notValue(28));

    Bit27: enARdFF_2
    PORT MAP (i_reset => int_notreset,
              i_EN  => i_load,
              i_clock  => i_clock,
              i_D      => i_Value(27), 
              o_Q      => int_Value(27),
              o_Qn     => int_notValue(27));

    Bit26: enARdFF_2
    PORT MAP (i_reset => int_notreset,
              i_EN  => i_load,
              i_clock  => i_clock,
              i_D      => i_Value(26), 
              o_Q      => int_Value(26),
              o_Qn     => int_notValue(26));

    Bit25: enARdFF_2
    PORT MAP (i_reset => int_notreset,
              i_EN  => i_load,
              i_clock  => i_clock,
              i_D      => i_Value(25), 
              o_Q      => int_Value(25),
              o_Qn     => int_notValue(25));

    Bit24: enARdFF_2
    PORT MAP (i_reset => int_notreset,
              i_EN  => i_load,
              i_clock  => i_clock,
              i_D      => i_Value(24), 
              o_Q      => int_Value(24),
              o_Qn     => int_notValue(24));

    Bit23: enARdFF_2
    PORT MAP (i_reset => int_notreset,
              i_EN  => i_load,
              i_clock  => i_clock,
              i_D      => i_Value(23), 
              o_Q      => int_Value(23),
              o_Qn     => int_notValue(23));

    Bit22: enARdFF_2
    PORT MAP (i_reset => int_notreset,
              i_EN  => i_load,
              i_clock  => i_clock,
              i_D      => i_Value(22), 
              o_Q      => int_Value(22),
              o_Qn     => int_notValue(22));

    Bit21: enARdFF_2
    PORT MAP (i_reset => int_notreset,
              i_EN  => i_load,
              i_clock  => i_clock,
              i_D      => i_Value(21), 
              o_Q      => int_Value(21),
              o_Qn     => int_notValue(21));

    Bit20: enARdFF_2
    PORT MAP (i_reset => int_notreset,
              i_EN  => i_load,
              i_clock  => i_clock,
              i_D      => i_Value(20), 
              o_Q      => int_Value(20),
              o_Qn     => int_notValue(20));

    Bit19: enARdFF_2
    PORT MAP (i_reset => int_notreset,
              i_EN  => i_load,
              i_clock  => i_clock,
              i_D      => i_Value(19), 
              o_Q      => int_Value(19),
              o_Qn     => int_notValue(19));

    Bit18: enARdFF_2
    PORT MAP (i_reset => int_notreset,
              i_EN  => i_load,
              i_clock  => i_clock,
              i_D      => i_Value(18), 
              o_Q      => int_Value(18),
              o_Qn     => int_notValue(18));

    Bit17: enARdFF_2
    PORT MAP (i_reset => int_notreset,
              i_EN  => i_load,
              i_clock  => i_clock,
              i_D      => i_Value(17), 
              o_Q      => int_Value(17),
              o_Qn     => int_notValue(17));

    Bit16: enARdFF_2
    PORT MAP (i_reset => int_notreset,
              i_EN  => i_load,
              i_clock  => i_clock,
              i_D      => i_Value(16), 
              o_Q      => int_Value(16),
              o_Qn     => int_notValue(16));

    Bit15: enARdFF_2
    PORT MAP (i_reset => int_notreset,
              i_EN  => i_load,
              i_clock  => i_clock,
              i_D      => i_Value(15), 
              o_Q      => int_Value(15),
              o_Qn     => int_notValue(15));

    Bit14: enARdFF_2
    PORT MAP (i_reset => int_notreset,
              i_EN  => i_load,
              i_clock  => i_clock,
              i_D      => i_Value(14), 
              o_Q      => int_Value(14),
              o_Qn     => int_notValue(14));

    Bit13: enARdFF_2
    PORT MAP (i_reset => int_notreset,
              i_EN  => i_load,
              i_clock  => i_clock,
              i_D      => i_Value(13), 
              o_Q      => int_Value(13),
              o_Qn     => int_notValue(13));

    Bit12: enARdFF_2
    PORT MAP (i_reset => int_notreset,
              i_EN  => i_load,
              i_clock  => i_clock,
              i_D      => i_Value(12), 
              o_Q      => int_Value(12),
              o_Qn     => int_notValue(12));

    Bit11: enARdFF_2
    PORT MAP (i_reset => int_notreset,
              i_EN  => i_load,
              i_clock  => i_clock,
              i_D      => i_Value(11), 
              o_Q      => int_Value(11),
              o_Qn     => int_notValue(11));

    Bit10: enARdFF_2
    PORT MAP (i_reset => int_notreset,
              i_EN  => i_load,
              i_clock  => i_clock,
              i_D      => i_Value(10), 
              o_Q      => int_Value(10),
              o_Qn     => int_notValue(10));

    Bit9: enARdFF_2
    PORT MAP (i_reset => int_notreset,
              i_EN  => i_load,
              i_clock  => i_clock,
              i_D      => i_Value(9), 
              o_Q      => int_Value(9),
              o_Qn     => int_notValue(9));

    Bit8: enARdFF_2
    PORT MAP (i_reset => int_notreset,
              i_EN  => i_load,
              i_clock  => i_clock,
              i_D      => i_Value(8), 
              o_Q      => int_Value(8),
              o_Qn     => int_notValue(8));

    Bit7: enARdFF_2
    PORT MAP (i_reset => int_notreset,
              i_EN  => i_load,
              i_clock  => i_clock,
              i_D      => i_Value(7), 
              o_Q      => int_Value(7),
              o_Qn     => int_notValue(7));

    Bit6: enARdFF_2
    PORT MAP (i_reset => int_notreset,
              i_EN  => i_load,
              i_clock  => i_clock,
              i_D      => i_Value(6), 
              o_Q      => int_Value(6),
              o_Qn     => int_notValue(6));

    Bit5: enARdFF_2
    PORT MAP (i_reset => int_notreset,
              i_EN  => i_load,
              i_clock  => i_clock,
              i_D      => i_Value(5), 
              o_Q      => int_Value(5),
              o_Qn     => int_notValue(5));

    Bit4: enARdFF_2
    PORT MAP (i_reset => int_notreset,
              i_EN  => i_load,
              i_clock  => i_clock,
              i_D      => i_Value(4), 
              o_Q      => int_Value(4),
              o_Qn     => int_notValue(4));

    Bit3: enARdFF_2
    PORT MAP (i_reset => int_notreset,
              i_EN  => i_load,
              i_clock  => i_clock,
              i_D      => i_Value(3), 
              o_Q      => int_Value(3),
              o_Qn     => int_notValue(3));

    Bit2: enARdFF_2
    PORT MAP (i_reset => int_notreset,
              i_EN  => i_load,
              i_clock  => i_clock,
              i_D      => i_Value(2), 
              o_Q      => int_Value(2),
              o_Qn     => int_notValue(2));

    Bit1: enARdFF_2
    PORT MAP (i_reset => int_notreset,
              i_EN  => i_load,
              i_clock  => i_clock,
              i_D      => i_Value(1), 
              o_Q      => int_Value(1),
              o_Qn     => int_notValue(1));

    LSB: enARdFF_2
    PORT MAP (i_reset => int_notreset,
              i_EN  => i_load,
              i_clock  => i_clock,
              i_D      => i_Value(0), 
              o_Q      => int_Value(0),
              o_Qn     => int_notValue(0));

    o_Value    <= int_Value;
    o_ValueBar <= int_notValue;

END ARCHITECTURE structural;
