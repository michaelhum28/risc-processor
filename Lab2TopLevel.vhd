library IEEE;
use IEEE.std_logic_1164.all;


entity TopLevel is
    port(
        GClock, GReset : in std_logic;
        ValueSelect : in std_logic_vector(2 downto 0);
        MuxOut : out std_logic_vector(7 downto 0); --Mux Out debug
        InstructionOut: out STD_LOGIC_VECTOR(31 downto 0); -- Instruction Out
        ALUOut_out, ReadData1_out, ReadData2_out, WriteData_out : out std_logic_vector( 7 downto 0);

        --Data Memory I/O------------------
        DataAddress : out STD_LOGIC_VECTOR(7 downto 0);
        DataMemIn : out STD_LOGIC_VECTOR(7 downto 0);
        WriteDataEnable : out STD_LOGIC;
        ReadDataMem : in STD_LOGIC_VECTOR(7 downto 0);

        --Instruction Memory I/O------------------
        InstructionAddress : out STD_LOGIC_VECTOR(7 downto 0);
        InstructionIn : in STD_LOGIC_VECTOR(31 downto 0)
    );
end entity;

architecture structural of TopLevel is
    signal notGReset: std_logic; -- Inverted Clock for the DFFs

    signal OPCODE : STD_LOGIC_VECTOR(5 downto 0); -- Instruction OPCODE (Control Unit Input)
    signal RegDst, Branch, Bne, MemRead, MemToReg, MemWrite, ALUSrc, RegWrite, Jump : STD_LOGIC; -- Control Unit Outputs
    signal ALUOp : STD_LOGIC_VECTOR(1 downto 0); -- ALU Control Unit Input

    signal B_Extend, B_Shift : STD_LOGIC_VECTOR(31 downto 0);
    signal ALUControl : STD_LOGIC_VECTOR(2 downto 0); --ALU Control Unit Output
    signal ALUOut : STD_LOGIC_VECTOR(7 downto 0); -- ALU output

    signal Instruction : STD_LOGIC_VECTOR(31 downto 0); -- Intruction Memory Output
    signal ReadReg1, ReadReg2, WriteReg : STD_LOGIC_VECTOR(4 downto 0); -- Register File inputs
    signal ReadData, ReadData1, ReadData2, WriteData, MUX1_8Out, DataMemOut : STD_LOGIC_VECTOR(7 downto 0); -- Register File outputs
    signal ZeroFlag, RR1equalRR2 : STD_LOGIC; -- ALU Zero Flag and Register File Comparator output

    signal ForwardA, ForwardB : STD_LOGIC_VECTOR(1 downto 0); -- Forwarding Unit Outputs
    signal EX_MuxOut1, EX_MuxOut2 : STD_LOGIC_VECTOR(7 downto 0); -- ID/EX Register Mux Outputs

    signal PCIncrementOut, PCOut, ALU1Out, PCMux_in, PCIn, JumpAddress: STD_LOGIC_VECTOR(31 downto 0);

    signal PCWrite, IF_Flush, IF_ID_Write, ControlMux, ID_MUX_out : STD_LOGIC; -- Hazard Detection Unit Outputs

    --Pipeline Register Signals--

    signal ID_Instruction, ID_PCIncrementOut : STD_LOGIC_VECTOR(31 downto 0); -- IF/ID Register Output


    signal EX_MemtoReg, EX_MemRead, EX_MemWrite, EX_RegWrite, EX_RegDst, EX_ALUSrc : STD_LOGIC; -- ID/EX Register Outputs
    signal EX_ALUOp : STD_LOGIC_VECTOR(1 downto 0); -- ID/EX Register ALUOp Output
    signal EX_Instruction : STD_LOGIC_VECTOR(31 downto 0); -- ID/EX Register Output
    signal EX_ReadData1, EX_ReadData2 : STD_LOGIC_VECTOR(7 downto 0); -- ID/EX Register Output
    signal EX_WriteReg : STD_LOGIC_VECTOR(4 downto 0); -- ID/EX Register Write Register Output

    signal MEM_WriteReg : STD_LOGIC_VECTOR(4 downto 0); -- EX/MEM Register Write Register Output
    signal MEM_ALUOut : STD_LOGIC_VECTOR(7 downto 0); -- EX/MEM Register ALU Output
    signal MEM_MuxOut2 : STD_LOGIC_VECTOR(7 downto 0); -- EX/MEM Register Mux Output
    signal MEM_MemtoReg, MEM_MemRead, MEM_MemWrite, MEM_RegWrite : STD_LOGIC; -- EX/MEM Register Outputs

    signal WB_ALUOut, WB_DataMemOut : STD_LOGIC_VECTOR(7 downto 0); -- MEM/WB Register ALU Output
    signal WB_WriteReg : STD_LOGIC_VECTOR(4 downto 0); -- MEM/WB Register Write Register Output
    signal WB_MemtoReg, WB_RegWrite: STD_LOGIC; -- MEM/WB Register RegWrite Output




begin
notGReset <= not GReset; -- Inverted Clock for the registers

--PC--------------------------------------------------------------------------------------------------------------------

PCMux: entity work.mux2to1_32bit(struct) --top RIGHT BLACK 10, sel, out
    port map(PCIncrementOut, PCMux_in, IF_Flush, PCin);

PC : entity work.register8Bit(structural)
    port map (
        i_clock => GClock,
        i_reset => GReset,
        i_load => PCWrite,
        i_Value => PCIn(7 downto 0),
        o_Value => PCOut(7 downto 0)
    );

PCIncrementer : entity work.ALU_32b_G1(struct) --Adder above instruction memory
    port map (PCOut, X"00000001", PCIncrementOut);

--Instruction Memory-----------------------------------------------------------------------------------------------------
--InstructionMemory : entity work.IMEM_2(Behavioral)
    --port map (
        --address => PCOut(7 downto 0),
        --data => Instruction
    --);

InstructionAddress <= PCOut(7 downto 0);
Instruction <= InstructionIn;

--=open====================IF/ID====================open=--

IF_ID_InstructionCounter : entity work.register32Bit(structural) --IF/ID Register PC
    port map (
        i_clock => GClock,
        i_reset => GReset or IF_Flush,
        i_load => IF_ID_Write,
        i_Value => PCIncrementOut,
        o_Value => ID_PCIncrementOut
    );

IF_ID_32BitRegister : entity work.register32Bit(structural) --IF/ID Register
    port map (
        i_clock => GClock,
        i_reset => GReset or IF_Flush,
        i_load => IF_ID_Write,
        i_Value => Instruction,
        o_Value => ID_Instruction
    );

--=close====================IF/ID====================close=--

JumpAddress(31 downto 26) <= ID_PCIncrementOut(31 downto 26);
JumpAddress(25 downto 0) <= ID_Instruction(25 downto 0);
-- JumpAddress(1 downto 0) <= "00";


OPCODE <= ID_Instruction(31 downto 26); -- OPCODE is the first 6 bits of the instruction
ReadReg1 <= ID_Instruction(25 downto 21); -- Read Register 1 is bits 25-21 of the instruction
ReadReg2 <= ID_Instruction(20 downto 16); -- Read Register 2 is bits 20-16 of the instruction

B_Extend(15 downto 0) <= ID_Instruction(15 downto 0); -- B_Extend is the immediate value from the instruction
B_Extend(31 downto 16) <= (others => '0');
B_Shift <= B_Extend(31 downto 0);
-- B_Shift <= B_Extend(29 downto 0) & "00";

--Control Unit------------------------------------------------------------------------------------------------------------


HazardUnit : entity work.HazardDetectionUnit(structural) -- Hazard Detection Unit
    port map (
        GClock => GClock,
        ID_EX_MemRead => EX_MemRead,
        ID_EX_RegisterRt => EX_Instruction(20 downto 16),
        IF_ID_RegisterRs => ReadReg1,
        IF_ID_RegisterRt => ReadReg2,
        PCWrite => PCWrite,
        IF_ID_Write => IF_ID_Write,
        ControlMux => ControlMux
    );


ControlUnit : entity work.CU(structural)
    port map (
        OPCODE => OPCODE,
        ALUSrc => ALUSrc,
        RegDst => RegDst,
        Branch => Branch,
        Bne => Bne,
        MemRead => MemRead,
        MemToReg => MemToReg,
        MemWrite => MemWrite,
        RegWrite => RegWrite,
        ALUOp => ALUOp,
        Jump => Jump,
        IF_Flush => IF_Flush,
        Zero => RR1equalRR2,
        Hazard => ControlMux
    );

ALUAdder : entity work.ALU_32b_G1(struct) --open right alu
port map (ID_PCIncrementOut, B_Shift, PCMux_in);

RegisterFile : entity work.registerFile(structural)
    port map (
        reset => GReset,
        clk => GClock,
        RegWrite => WB_RegWrite,
        ReadReg1 => ReadReg1,
        ReadReg2 => ReadReg2,
        WriteReg => WriteReg,
        WriteData => WriteData,
        ReadData1 => ReadData1,
        ReadData2 => ReadData2
    );

RegisterFileComp : entity work.comparator5Bit(structural) -- Register File Comparator
    port map (
        A => ReadReg1,
        B => ReadReg2,
        AequalB => RR1equalRR2
    );

--=open==================ID/EX====================open=--

--2to1 1bit mux port order : reset, D, EN, clk, Q, Qbar
--M
ID_EX_MemReadDFF : entity work.enARdFF_2(rtl) port map (notGReset,MemRead,'1',GClock,EX_MemRead,OPEN); --ID/EX Register MemRead
ID_EX_MemWriteDFF : entity work.enARdFF_2(rtl) port map (notGReset,MemWrite,'1',GClock,EX_MemWrite,OPEN); --ID/EX Register MemWrite
--WB
ID_EX_RegWriteDFF : entity work.enARdFF_2(rtl) port map (notGReset,RegWrite,'1',GClock,EX_RegWrite,OPEN); --ID/EX Register RegWrite
ID_EX_MemtoRegDFF : entity work.enARdFF_2(rtl) port map (notGReset,MemtoReg,'1',GClock,EX_MemtoReg,OPEN); --ID/EX Register MemtoReg
--EX
ID_EX_RegDstDFF : entity work.enARdFF_2(rtl) port map (notGReset,RegDst,'1',GClock,EX_RegDst,OPEN); --ID/EX Register RegDst
ID_EX_ALUSrcDFF : entity work.enARdFF_2(rtl) port map (notGReset,ALUSrc,'1',GClock,EX_ALUSrc,OPEN); --ID/EX Register ALUSrc
ID_EX_ALUOp1DFF : entity work.enARdFF_2(rtl) port map (notGReset,ALUOp(1),'1',GClock,EX_ALUOp(1),OPEN); --ID/EX Register ALUOp(1)
ID_EX_ALUOp2DFF : entity work.enARdFF_2(rtl) port map (notGReset,ALUOp(0),'1',GClock,EX_ALUOp(0),OPEN); --ID/EX Register ALUOp(0)

ID_EX_8BitRegister1 : entity work.register8Bit(structural) --ID/EX Register ReadData1
    port map (
        i_clock => GClock,
        i_reset => GReset,
        i_load => '1',
        i_Value => ReadData1,
        o_Value => EX_ReadData1
    );

ID_EX_8BitRegister2 : entity work.register8Bit(structural) --ID/EX Register ReadData2
    port map (
        i_clock => GClock,
        i_reset => GReset,
        i_load => '1',
        i_Value => ReadData2,
        o_Value => EX_ReadData2
    );

ID_EX_32BitRegister : entity work.register32Bit(structural) --ID/EX Register Instruction
    port map (
        i_clock => GClock,
        i_reset => GReset,
        i_load => '1',
        i_Value => Instruction,
        o_Value => EX_Instruction
    );

--=close====================ID/EX====================close=--

EX_Mux4to1_8Bit1 : entity work.mux4to1_8bit(structural)
    port map(ForwardA, EX_ReadData1, MEM_ALUOut , WriteData, X"00", EX_MuxOut1);

EX_Mux4to1_8Bit2 : entity work.mux4to1_8bit(structural)
    port map(ForwardB, EX_ReadData2, MEM_ALUOut, WriteData, X"00", EX_MuxOut2);


ALUControlLogic : entity work.ALU_CU_G1(struct) -- ALU Control Logic
port map (
    F => EX_Instruction(5 downto 0),
    ALUOp => EX_ALUOp,
    OPCODE => ALUControl
);

ALU: entity work.ALU(structural) -- ALU Bottom
    port map (
        A => EX_MuxOut1,
        B => EX_MuxOut2,
        OPCODE => ALUControl,
        ALUResult => ALUOut,
        Zero => OPEN
    );

MUX1_5B:entity work.mux2to1_5bit(struct) --5 bit mux on the bottom middle 01, sel, out
    port map(EX_Instruction(20 downto 16), EX_Instruction(15 downto 11), EX_RegDst, EX_WriteReg);

ForwardingUnit : entity work.ForwardingUnit(structural) -- Forwarding Unit
    port map (
        ID_EX_RegisterRs => EX_Instruction(25 downto 21),
        ID_EX_RegisterRt => EX_Instruction(20 downto 16),
        EX_MEM_RegisterRd => MEM_WriteReg,
        MEM_WB_RegisterRd => WB_WriteReg,
        EX_MEM_RegWrite => MEM_RegWrite,
        MEM_WB_RegWrite => WB_RegWrite,
        ForwardA => ForwardA,
        ForwardB => ForwardB
    );


--=open====================EX/MEM====================open=--

--M
EX_MEM_MemReadDFF : entity work.enARdFF_2(rtl) port map (notGReset,EX_MemRead,'1',GClock,MEM_MemRead,OPEN); --EX/MEM Register MemRead
EX_MEM_MemWriteDFF : entity work.enARdFF_2(rtl) port map (notGReset,EX_MemWrite,'1',GClock,MEM_MemWrite,OPEN); --ID/EX Register MemWrite
--WB
EX_MEM_MemtoRegDFF : entity work.enARdFF_2(rtl) port map (notGReset,EX_MemtoReg,'1',GClock,MEM_MemtoReg,OPEN); --EX/MEM Register MemtoReg
EX_MEM_RegWriteDFF : entity work.enARdFF_2(rtl) port map (notGReset,EX_RegWrite,'1',GClock,MEM_RegWrite,OPEN); --EX/MEM Register RegWrite

EX_MEM_WriteReg5Bit : entity work.register5Bit(Structural) --MEM/WB Register Write Register
    port map (
        i_clock => GClock,
        i_reset => GReset,
        i_load => '1',
        i_Value => EX_WriteReg,
        o_Value => MEM_WriteReg
    );

EX_MEM_ALUOut8Bit : entity work.register8Bit(structural) --EX/MEM Register ALU Output
    port map (
        i_clock => GClock,
        i_reset => GReset,
        i_load => '1',
        i_Value => ALUOut,
        o_Value => MEM_ALUOut
    );

EX_MEM_MuxOut2_8Bit : entity work.register8Bit(structural) --EX/MEM Register ALU Output
    port map (
        i_clock => GClock,
        i_reset => GReset,
        i_load => '1',
        i_Value => EX_MuxOut2,
        o_Value => MEM_MuxOut2
    );

--=close====================EX/MEM====================close=--

--Data Memory------------------------------------------------------------------------------------------------------
-- DataMemory : entity work.DMEM(SYN) -- Data Memory
--     port map (
--         address	=> ALUOut,
-- 		clock  => GClock,
-- 		data => ReadData2,
-- 		rden => MemRead,
-- 		wren => MemWrite,
-- 		q => DataMemOut
--     )


DataAddress <= MEM_ALUOut;
DataMemIn <= MEM_MuxOut2;
WriteDataEnable <= MEM_MemWrite;
DataMemOut <= ReadDataMem;

--=open====================MEM/WB====================open=--

--WB
MEM_WB_MemtoRegDFF : entity work.enARdFF_2(rtl) port map (notGReset,MEM_MemtoReg,'1',GClock,WB_MemToReg,OPEN); --MEM/WB Register MemtoReg
MEM_WB_RegWriteDFF : entity work.enARdFF_2(rtl) port map (notGReset,MEM_RegWrite,'1',GClock,WB_RegWrite,OPEN); --MEM/WB Register RegWrite

MEM_WB_WriteReg5Bit : entity work.register5Bit(Structural) --EX/MEM Register Write Register
    port map (
        i_clock => GClock,
        i_reset => GReset,
        i_load => '1',
        i_Value => MEM_WriteReg,
        o_Value => WB_WriteReg
    );

MEM_WB_ALUOut8Bit : entity work.register8Bit(structural) --MEM/WB Register ALU Output
    port map (
        i_clock => GClock,
        i_reset => GReset,
        i_load => '1',
        i_Value => MEM_ALUOut,
        o_Value => WB_ALUOut
    );

MEM_WB_DataMemOut8Bit : entity work.register8Bit(structural) --MEM/WB Register Data Memory Output
    port map (
        i_clock => GClock,
        i_reset => GReset,
        i_load => '1',
        i_Value => DataMemOut,
        o_Value => WB_DataMemOut
    );

--=close====================MEM/WB====================close=--

MUX2_8B:entity work.mux2to1_8bit(structural) --8 bit mux on the bottom middle 01, sel, out
    port map(WB_ALUOut, WB_DataMemOut, WB_MemToReg, WriteData);

WriteReg <= WB_WriteReg;

--Debuging Outputs--------------------------------------------------------------------------------------------------------------
DebugMUX : entity work.mux8to1_8bit(structural) -- Mux Out debug
    port map (
        sel => ValueSelect,
        input0 => PCOut(7 downto 0),
        input1 => ALUOut,
        input2 => ReadData1,
        input3 => ReadData2,
        input4 => WriteData,
        input5 => '0' & RegDst & Jump & MemRead & MemToReg & ALUOp & ALUSrc,
        input6 => X"FF",
        input7 => X"FF",
        output => MuxOut
    );

InstructionOut <= Instruction;
ALUOut_out <= ALUOut;
ReadData1_out <= ReadData1;
ReadData2_out <= ReadData2;
WriteData_out <= WriteData;


end architecture;
