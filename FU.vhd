library IEEE;
use IEEE.std_logic_1164.all;

entity ForwardingUnit is
    port (
        -- Control signals
        EX_MEM_RegWrite : in std_logic;
        MEM_WB_RegWrite : in std_logic;

        -- Register addresses
        EX_MEM_RegisterRd : in std_logic_vector(4 downto 0);
        MEM_WB_RegisterRd : in std_logic_vector(4 downto 0);
        ID_EX_RegisterRs : in std_logic_vector(4 downto 0);
        ID_EX_RegisterRt : in std_logic_vector(4 downto 0);

        -- Forwarding control outputs
        ForwardA : out std_logic_vector(1 downto 0);
        ForwardB : out std_logic_vector(1 downto 0)
    );
end ForwardingUnit;

architecture structural of ForwardingUnit is
    -- Signals for register non-zero checks
    signal INEQ1_out, INEQ2_out : std_logic;
    signal EX_MEM_Rd_Not_Zero : std_logic;
    signal MEM_WB_Rd_Not_Zero : std_logic;

    -- Signals for register equality comparisons
    signal EX_MEM_Rd_EQ_ID_EX_Rs : std_logic;
    signal EX_MEM_Rd_EQ_ID_EX_Rt : std_logic;
    signal MEM_WB_Rd_EQ_ID_EX_Rs : std_logic;
    signal MEM_WB_Rd_EQ_ID_EX_Rt : std_logic;

    -- Signals for forwarding conditions
    signal Zero : std_logic_vector(4 downto 0) := (others => '0');
begin

EX_MEM_Rd_Not_Zero <= not INEQ1_out;
MEM_WB_Rd_Not_Zero <= not INEQ2_out;

EQ1 : entity work.comparator5Bit(structural)
    port map (
        A => EX_MEM_RegisterRd,
        B => ID_EX_RegisterRs,
        AequalB => EX_MEM_Rd_EQ_ID_EX_Rs
    );

EQ2 : entity work.comparator5Bit(structural)
    port map (
        A => EX_MEM_RegisterRd,
        B => ID_EX_RegisterRt,
        AequalB => EX_MEM_Rd_EQ_ID_EX_Rt
    );

EQ3 : entity work.comparator5Bit(structural)
    port map (
        A => MEM_WB_RegisterRd,
        B => ID_EX_RegisterRs,
        AequalB => MEM_WB_Rd_EQ_ID_EX_Rs
    );

EQ4 : entity work.comparator5Bit(structural)
    port map (
        A => MEM_WB_RegisterRd,
        B => ID_EX_RegisterRt,
        AequalB => MEM_WB_Rd_EQ_ID_EX_Rt
    );

INEQ1 : entity work.comparator5Bit(structural)
    port map (
        A => EX_MEM_RegisterRd,
        B => Zero,
        AequalB => INEQ1_out
    );

INEQ2 : entity work.comparator5Bit(structural)
    port map (
        A => MEM_WB_RegisterRd,
        B => Zero,
        AequalB => INEQ2_out
    );

-- Implement forwarding logic based on equations
ForwardA(1) <= EX_MEM_RegWrite and EX_MEM_Rd_Not_Zero and EX_MEM_Rd_EQ_ID_EX_Rs;
ForwardB(1) <= EX_MEM_RegWrite and EX_MEM_Rd_Not_Zero and EX_MEM_Rd_EQ_ID_EX_Rt;
ForwardA(0) <= MEM_WB_RegWrite and MEM_WB_Rd_Not_Zero and MEM_WB_Rd_EQ_ID_EX_Rs;
ForwardB(0) <= MEM_WB_RegWrite and MEM_WB_Rd_Not_Zero and MEM_WB_Rd_EQ_ID_EX_Rt;
end structural;