library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use STD.TEXTIO.ALL;
use IEEE.STD_LOGIC_TEXTIO.ALL;  -- Required for hread

entity DMEM_2 is
    Port (
        address  : in  STD_LOGIC_VECTOR (7 downto 0);  -- 8-bit address (256 depth)
        data_in  : in  STD_LOGIC_VECTOR (7 downto 0);  -- 8-bit data input (for write)
        data_out : out STD_LOGIC_VECTOR (7 downto 0);  -- 8-bit data output (for read)
        we       : in  STD_LOGIC  -- Write enable signal (1 = write, 0 = read)
    );
end DMEM_2;

architecture Behavioral of DMEM_2 is
    type RAM_Array is array (0 to 255) of STD_LOGIC_VECTOR(7 downto 0);  -- 256 x 8-bit RAM

    -- Function to initialize the RAM from a .mif file
    impure function Init_RAM_From_MIF(FileName : in string) return RAM_Array is
        file MIF_File      : text open read_mode is FileName;
        variable MIF_Line  : line;
        variable Temp_Byte : STD_LOGIC_VECTOR(7 downto 0);
        variable RAM_Data  : RAM_Array := (others => (others => '0'));
        variable Index     : integer;
        variable Char      : character;
        variable Found     : boolean;
    begin
        while not endfile(MIF_File) loop
            readline(MIF_File, MIF_Line);

            -- Look for the pattern "number : "
            Found := false;
            for i in 0 to 255 loop
                -- Read the index
                read(MIF_Line, Index);

                -- Check for the colon and space
                read(MIF_Line, Char);  -- Read the colon
                if Char = ':' then
                    read(MIF_Line, Char);  -- Read the space after the colon
                    if Char = ' ' then
                        Found := true;
                        exit;
                    end if;
                end if;
            end loop;

            -- If the pattern is found, read the hexadecimal value
            if Found then
                hread(MIF_Line, Temp_Byte);  -- Read the 8-bit hex value
                RAM_Data(Index) := Temp_Byte;
            end if;
        end loop;
        return RAM_Data;
    end function;

    -- Initialize the RAM using the .mif file
    signal RAM_Content : RAM_Array := Init_RAM_From_MIF("Data.mif");

begin
    -- Asynchronous read operation
    data_out <= RAM_Content(to_integer(unsigned(address)));

    -- Asynchronous write operation
    process(address, data_in, we)
    begin
        if we = '1' then  -- Write enable is active
            RAM_Content(to_integer(unsigned(address))) <= data_in;
        end if;
    end process;
end Behavioral;