library ieee;
use ieee.std_logic_1164.all;

entity clockDivider is
    port(
        i_resetbar, i_enable : in  std_logic;
        i_clock           : in  std_logic;
        o_clock2         : out std_logic;
        o_clock4          : out std_logic;
        o_clock8          : out std_logic;
        o_clock16        : out std_logic;
        o_clock32        : out std_logic;
        o_clock64         : out std_logic;
        o_clock128        : out std_logic;
        o_clock256        : out std_logic
    );
end;

architecture structural of clockDivider is
    signal int_clock2, int_clock4, int_clock8, int_clock16, int_clock32, int_clock64, int_clock128, int_clock256 : std_logic;
    signal o_fb2, o_fb4, o_fb8, o_fb16, o_fb32, o_fb64, o_fb128, o_fb256: std_logic;   


begin
   
    Clock2: entity work.enARdFF_2(rtl)
        port map (
            i_reset    => i_resetbar,
            i_D        => o_fb2,
            i_EN       => i_enable, 
            i_clock	   => i_clock,
            o_Q        => o_clock2,
            o_Qn       => o_fb2
        );
        
    Clock4: entity work.enARdFF_2(rtl)
        port map (
            i_reset    => i_resetbar,
            i_D        => o_fb4,
            i_EN       => i_enable, 
            i_clock	   => o_fb2,
            o_Q        => o_clock4,
            o_Qn       => o_fb4
        );
        
    Clock8: entity work.enARdFF_2(rtl)
        port map (
            i_reset    => i_resetbar,
            i_D        => o_fb8,
            i_EN       => i_enable, 
            i_clock	   => o_fb4,
            o_Q        => o_clock8,
            o_Qn       => o_fb8
        );
    Clock16: entity work.enARdFF_2(rtl)
        port map (
            i_reset    => i_resetbar,
            i_D        => o_fb16,
            i_EN       => i_enable, 
            i_clock	   => o_fb8,
            o_Q        => o_clock16,
            o_Qn       => o_fb16
        );
    Clock32: entity work.enARdFF_2(rtl)
        port map (
            i_reset    => i_resetbar,
            i_D        => o_fb32,
            i_EN       => i_enable, 
            i_clock	   => o_fb16,
            o_Q        => o_clock32,
            o_Qn       => o_fb32
        );
    Clock64: entity work.enARdFF_2(rtl)
        port map (
            i_reset    => i_resetbar,
            i_D        => o_fb64,
            i_EN       => i_enable, 
            i_clock	   => o_fb32,
            o_Q        => o_clock64,
            o_Qn       => o_fb64
        );
    Clock128: entity work.enARdFF_2(rtl)
        port map (
            i_reset    => i_resetbar,
            i_D        => o_fb128,
            i_EN       => i_enable, 
            i_clock	   => o_fb64,
            o_Q        => o_clock128,
            o_Qn       => o_fb128
        );
        
    Clock256: entity work.enARdFF_2(rtl)
        port map (
            i_reset    => i_resetbar,
            i_D        => o_fb256,
            i_EN       => i_enable, 
            i_clock	   => o_fb128,
            o_Q        => o_clock256,
            o_Qn       => o_fb256
        );         
end;