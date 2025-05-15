LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY bcd_7seg_G1 IS
    PORT (
        BCDin : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
        Seven_Seg : OUT STD_LOGIC_VECTOR (6 DOWNTO 0));
END bcd_7seg_G1;

ARCHITECTURE behav OF bcd_7seg_G1 IS

BEGIN

    PROCESS (BCDin)
    BEGIN

        CASE BCDin IS
            WHEN "0000" =>
                Seven_Seg <= "0000001"; ---0
            WHEN "0001" =>
                Seven_Seg <= "1001111"; ---1
            WHEN "0010" =>
                Seven_Seg <= "0010010"; ---2
            WHEN "0011" =>
                Seven_Seg <= "0000110"; ---3
            WHEN "0100" =>
                Seven_Seg <= "1001100"; ---4
            WHEN "0101" =>
                Seven_Seg <= "0100100"; ---5
            WHEN "0110" =>
                Seven_Seg <= "0100000"; ---6
            WHEN "0111" =>
                Seven_Seg <= "0001111"; ---7
            WHEN "1000" =>
                Seven_Seg <= "0000000"; ---8
            WHEN "1001" =>
                Seven_Seg <= "0000100"; ---9
				WHEN "1010" =>
                Seven_Seg <= "0001000"; ---A
				WHEN "1011" =>
                Seven_Seg <= "1100000"; ---B
				WHEN "1100" =>
                Seven_Seg <= "0110001"; ---C
				WHEN "1101" =>
                Seven_Seg <= "1000010"; ---D
				WHEN "1110" =>
                Seven_Seg <= "0110000"; ---E
            WHEN "1111" =>
                Seven_Seg <= "0111000"; ---F

            WHEN OTHERS =>
                Seven_Seg <= "1111111"; ---null
        END CASE;

    END PROCESS;

END behav;