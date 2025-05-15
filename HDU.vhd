-- filepath: vsls:/HDU.vhd
library IEEE;
use IEEE.std_logic_1164.all;

entity HazardDetectionUnit is
    port (
        GClock : in std_logic; -- Global clock signal
        -- Control signals
        ID_EX_MemRead : in std_logic;

        -- Register addresses
        ID_EX_RegisterRt : in std_logic_vector(4 downto 0);
        IF_ID_RegisterRs : in std_logic_vector(4 downto 0);
        IF_ID_RegisterRt : in std_logic_vector(4 downto 0);

        -- Hazard control outputs
        PCWrite : out std_logic;        -- 1 = normal operation, 0 = stall
        IF_ID_Write : out std_logic;    -- 1 = normal operation, 0 = stall
        ControlMux : out std_logic      -- 1 = insert bubble/NOP, 0 = normal
    );
end HazardDetectionUnit;

architecture structural of HazardDetectionUnit is
    -- Signals for register equality comparisons
    signal ID_EX_Rt_EQ_IF_ID_Rs : std_logic;
    signal ID_EX_Rt_EQ_IF_ID_Rt : std_logic;

    -- Signal for hazard detection
    signal Hazard_Detected : std_logic;

    -- Signal for delayed stall
    signal Stall_DFF : std_logic;

begin
    -- Compare ID_EX.RegisterRt with IF_ID.RegisterRs
    EQ1 : entity work.comparator5Bit(structural)
        port map (
            A => ID_EX_RegisterRt,
            B => IF_ID_RegisterRs,
            AequalB => ID_EX_Rt_EQ_IF_ID_Rs
        );

    -- Compare ID_EX.RegisterRt with IF_ID.RegisterRt
    EQ2 : entity work.comparator5Bit(structural)
        port map (
            A => ID_EX_RegisterRt,
            B => IF_ID_RegisterRt,
            AequalB => ID_EX_Rt_EQ_IF_ID_Rt
        );

    -- OR result of the two comparisons
    Hazard_Detected <= ID_EX_MemRead and (ID_EX_Rt_EQ_IF_ID_Rs or ID_EX_Rt_EQ_IF_ID_Rt);

    -- Extend stall signal using a single enARdFF_2
    Stall_DFF_DFF : entity work.enARdFF_2(rtl)
        port map (
            i_reset => '1',
            i_D => Hazard_Detected,
            i_EN => '1',
            i_clock => GClock,
            o_Q => Stall_DFF,
            o_Qn => open
        );

    -- Combine current hazard detection with delayed signal
    PCWrite <= not (Hazard_Detected or Stall_DFF); -- 0 during stall
    IF_ID_Write <= not (Hazard_Detected or Stall_DFF); -- 0 during stall
    ControlMux <= Hazard_Detected or Stall_DFF; -- 1 to insert bubble

end structural;