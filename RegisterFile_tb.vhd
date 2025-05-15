library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity registerFile_tb is
end registerFile_tb;

architecture test of registerFile_tb is

    -- Component declaration
    component registerFile
        Port (
            reset     : in  STD_LOGIC;
            clk       : in  STD_LOGIC;
            RegWrite  : in  STD_LOGIC;
            ReadReg1  : in  STD_LOGIC_VECTOR(4 downto 0);
            ReadReg2  : in  STD_LOGIC_VECTOR(4 downto 0);
            WriteReg  : in  STD_LOGIC_VECTOR(4 downto 0);
            WriteData : in  STD_LOGIC_VECTOR(7 downto 0);
            ReadData1 : out STD_LOGIC_VECTOR(7 downto 0);
            ReadData2 : out STD_LOGIC_VECTOR(7 downto 0)
        );
    end component;

    -- Signals
    signal reset    : STD_LOGIC := '0';
    signal clk      : STD_LOGIC := '0';
    signal RegWrite : STD_LOGIC := '0';
    signal ReadReg1, ReadReg2, WriteReg : STD_LOGIC_VECTOR(4 downto 0) := (others => '0');
    signal WriteData : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    signal ReadData1, ReadData2 : STD_LOGIC_VECTOR(7 downto 0);

    -- Clock process
    constant clk_period : time := 10 ns;
begin

    -- Instantiate the register file
    uut: registerFile
        port map (
            reset     => reset,
            clk       => clk,
            RegWrite  => RegWrite,
            ReadReg1  => ReadReg1,
            ReadReg2  => ReadReg2,
            WriteReg  => WriteReg,
            WriteData => WriteData,
            ReadData1 => ReadData1,
            ReadData2 => ReadData2
        );

    -- Clock process
    clk_process : process
    begin
        while now < 500 ns loop
            clk <= '0';
            wait for clk_period / 2;
            clk <= '1';
            wait for clk_period / 2;
        end loop;
        wait;
    end process;

    -- Stimulus process
    stim_proc: process
    begin
        -- Reset the register file
        reset <= '1';
        wait for clk_period;
        reset <= '0';

        -- Write value 0xAA to register 5
        RegWrite <= '1';
        WriteReg <= "00101";  -- Register 5
        WriteData <= X"AA";   -- 0xAA
        wait for clk_period;

        -- Write value 0x55 to register 10
        WriteReg <= "01010";  -- Register 10
        WriteData <= X"55";   -- 0x55
        wait for clk_period;

        -- Disable writing
        RegWrite <= '0';

        -- Read back values
        ReadReg1 <= "00101";  -- Register 5
        ReadReg2 <= "01010";  -- Register 10
        wait for clk_period;
        ReadReg1 <= "00000";  -- Register 0
        wait for clk_period;

        -- Check ReadData1 = 0xAA, ReadData2 = 0x55

        -- End simulation
        wait;
    end process;

end test;
