library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;  -- Add this line to include the numeric_std package

entity IMEM_2_tb is
end IMEM_2_tb;

architecture behavior of IMEM_2_tb is
    -- Component declaration for the ROM
    component IMEM_2 is
        Port (
            address  : in  STD_LOGIC_VECTOR(7 downto 0);
            data : out STD_LOGIC_VECTOR(31 downto 0)
        );
    end component;

    -- Signals for the testbench
    signal address  : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    signal data : STD_LOGIC_VECTOR(31 downto 0);
    
begin
    -- Instantiate the ROM
    uut: IMEM_2
        Port map (
            address  => address,
            data => data
        );

    -- Stimulus process
    stim_proc: process
    begin
        -- Test addresses from 0 to 15
        for addr in 0 to 15 loop
            address <= std_logic_vector(to_unsigned(addr, 8)); -- Set address
            wait for 10 ns; -- Wait for 10ns to observe the output
        end loop;
        
        -- End simulation
        wait;
    end process stim_proc;

end behavior;
