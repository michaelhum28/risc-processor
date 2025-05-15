library ieee;
use  ieee.std_logic_1164.all;

ENTITY dec_7seg IS
	PORT(i_decDigit	: IN STD_LOGIC_VECTOR(3 downto 0);
	     o_segment_a1, o_segment_b1, o_segment_c1, o_segment_d1, o_segment_e1, 
	     o_segment_f1, o_segment_g1: OUT STD_LOGIC;
	     o_segment_a2, o_segment_b2, o_segment_c2, o_segment_d2, o_segment_e2, 
	     o_segment_f2, o_segment_g2: OUT STD_LOGIC);
END dec_7seg;

ARCHITECTURE rtl OF dec_7seg IS
	SIGNAL int_segment_data1, int_segment_data2 : STD_LOGIC_VECTOR(6 DOWNTO 0);
BEGIN
	PROCESS  (i_decDigit)
	BEGIN
		CASE i_decDigit IS
		        WHEN "0000" =>
		        -- 00
		          		int_segment_data1 <= "1111110";
		            int_segment_data2 <= "1111110";
		        WHEN "0001" =>
		        -- 01
		            int_segment_data1 <= "1111110";
		            int_segment_data2 <= "0110000";
		        WHEN "0010" =>
		        -- 02
		            int_segment_data1 <= "1111110";
		            int_segment_data2 <= "1101101";
		        WHEN "0011" =>
		        -- 03
		            int_segment_data1 <= "1111110";
		            int_segment_data2 <= "1111001";
		        WHEN "0100" =>
		        -- 04
		            int_segment_data1 <= "1111110";
		            int_segment_data2 <= "0110011";
		        WHEN "0101" =>
		        -- 05
		            int_segment_data1 <= "1111110";
		            int_segment_data2 <= "1011011";
		        WHEN "0110" =>
		        -- 06
		            int_segment_data1 <= "1111110";
		            int_segment_data2 <= "1011111";
		        WHEN "0111" =>
		        -- 07
		            int_segment_data1 <= "1111110";
		            int_segment_data2 <= "1110000";
		        WHEN "1000" =>
		        -- 08
		            int_segment_data1 <= "1111110";
		            int_segment_data2 <= "1111111";
		        WHEN "1001" =>
		        -- 09
		            int_segment_data1 <= "1111110";
		            int_segment_data2 <= "1111011"; 
		        WHEN "1010" =>
		        -- 10
		            int_segment_data1 <= "0110000";
		            int_segment_data2 <= "1111110";
		        WHEN "1011" =>
		        -- 11
		            int_segment_data1 <= "0110000";
		            int_segment_data2 <= "0110000"; 
		        WHEN "1100" =>
		        -- 12
		            int_segment_data1 <= "0110000";
		            int_segment_data2 <= "1101101"; 
		        WHEN "1101" =>
		        -- 13
		            int_segment_data1 <= "0110000";
		            int_segment_data2 <= "1111001"; 
		        WHEN "1110" =>
		        -- 14
		            int_segment_data1 <= "0110000"; 
		            int_segment_data2 <= "0110011"; 
		        WHEN "1111" =>
		        -- 15
		            int_segment_data1 <= "0110000";
		            int_segment_data2 <= "1011011"; 
			WHEN OTHERS =>
			      -- Undefined
		            int_segment_data1 <= "0111110";
		            int_segment_data2 <= "0111110";
		END CASE;
	END PROCESS;

-- 1st LED driver is inverted
o_segment_a1 <= NOT int_segment_data1(6);
o_segment_b1 <= NOT int_segment_data1(5);
o_segment_c1 <= NOT int_segment_data1(4);
o_segment_d1 <= NOT int_segment_data1(3);
o_segment_e1 <= NOT int_segment_data1(2);
o_segment_f1 <= NOT int_segment_data1(1);
o_segment_g1 <= NOT int_segment_data1(0);

-- 2nd LED driver is inverted
o_segment_a2 <= NOT int_segment_data2(6);
o_segment_b2 <= NOT int_segment_data2(5);
o_segment_c2 <= NOT int_segment_data2(4);
o_segment_d2 <= NOT int_segment_data2(3);
o_segment_e2 <= NOT int_segment_data2(2);
o_segment_f2 <= NOT int_segment_data2(1);
o_segment_g2 <= NOT int_segment_data2(0);

END rtl;

