LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY register8Bit IS --declare entity
    PORT(
        i_reset, i_load, i_clock: IN STD_LOGIC; --core control signals
        i_Value     : IN  STD_LOGIC_VECTOR(7 downto 0); --8-bit input vector
        o_Value     : OUT STD_LOGIC_VECTOR(7 downto 0); --8-bit output vector
        o_ValueBar  : OUT STD_LOGIC_VECTOR(7 downto 0)  --8-bit output vector
    );
END;

ARCHITECTURE Structural OF register8Bit IS
    SIGNAL int_Value, int_notValue : STD_LOGIC_VECTOR(7 downto 0);
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
    int_notreset <= NOT i_reset; --invert reset signal

    -- Each component is 1-bit, adding up to 8-bits, from MSB to LSB, assigning each bit to a position in the input and output vectors
    MSB: enARdFF_2
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

    o_Value    <= int_Value; --assigns internal vector to output vector
    o_ValueBar <= int_notValue; --assigns internal vector to output vector
END Structural;