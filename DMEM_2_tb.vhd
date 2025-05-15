library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity DMEM_2_TB is
end DMEM_2_TB;

architecture Behavioral of DMEM_2_TB is
    signal address  : STD_LOGIC_VECTOR(7 downto 0);
    signal data_in  : STD_LOGIC_VECTOR(7 downto 0);
    signal data_out : STD_LOGIC_VECTOR(7 downto 0);
    signal we       : STD_LOGIC;

begin
    -- Instantiate the asynchronous RAM
    uut: entity work.DMEM_2
        port map (
            address  => address,
            data_in  => data_in,
            data_out => data_out,
            we       => we
        );

    -- Test process
    stim_proc: process
    begin
        -- Write data to address 0x01
        address <= "10000001";  -- Address 1
        data_in <= "10101010";  -- Data to write
        we <= '1';  -- Enable write
        wait for 10 ns;

        -- Read data from address 0x01
        we <= '0';  -- Disable write (enable read)
        wait for 10 ns;

        -- Write data to address 0xFF
        address <= "11111111";  -- Address 255
        data_in <= "11110000";  -- Data to write
        we <= '1';  -- Enable write
        wait for 10 ns;

        -- Read data from address 0xFF
        we <= '0';  -- Disable write (enable read)
        address <= "10000001";
        wait for 10 ns;
        address <= "11111111";
        wait for 10 ns;
        address <= "00000000";
        wait for 10 ns;
        address <= "00000001";

        wait;
    end process;
end Behavioral;