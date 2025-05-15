library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use STD.TEXTIO.ALL;            -- For 'readline'
use IEEE.STD_LOGIC_TEXTIO.ALL; -- For 'hread'

entity IMEM_2 is
    Port (
        address : in  STD_LOGIC_VECTOR (7 downto 0);  -- 8-bit => depth 256
        data    : out STD_LOGIC_VECTOR (31 downto 0)  -- 32-bit data
    );
end IMEM_2;

architecture Behavioral of IMEM_2 is

    --------------------------------------------------------------------
    -- 256 x 32-bit memory array
    --------------------------------------------------------------------
    type ROM_Array is array (0 to 255) of STD_LOGIC_VECTOR(31 downto 0);

    --------------------------------------------------------------------
    -- PROCEDURE parse_line:
    -- Tries to parse a single line in the format: "Addr : 1234ABCD"
    -- If it fails (e.g., line is malformed), 'success' remains FALSE.
    --------------------------------------------------------------------
    procedure parse_line(
        L         : inout line;
        success   : out boolean;
        out_addr  : out integer;
        out_data  : out STD_LOGIC_VECTOR(31 downto 0)
    ) is
        variable c : character;
    begin
        success := false;

        -- 1) Try reading integer address
        read(L, out_addr);

        -- 2) Read one char, expect ':'
        read(L, c);
        if c /= ':' then
            return;  -- Not valid format
        end if;

        -- 3) Optional space after ':'
        if L'length > 0 then
            read(L, c);
            -- (Ignoring this character)
        end if;

        -- 4) Read 32-bit hex data
        hread(L, out_data);

        -- If we get here, parsing succeeded
        success := true;
    end procedure;

    --------------------------------------------------------------------
    -- FUNCTION Init_ROM_From_MIF:
    -- Reads up to 10,000 lines from FileName, uses parse_line() for lines
    -- that might be "Addr : HexValue", and if in [0..255], stores it.
    --
    -- This avoids Quartus's 10,000 iteration limit error.
    -- Still, typical FPGA synthesis won't actually embed this data.
    --------------------------------------------------------------------
    impure function Init_ROM_From_MIF(FileName : in string) return ROM_Array is
        file MIF_File      : text open read_mode is FileName;
        variable MIF_Line  : line;
        variable ROM_Data  : ROM_Array := (others => (others => '0'));
        variable Temp_Word : STD_LOGIC_VECTOR(31 downto 0);
        variable Addr      : integer;
        variable success   : boolean;
    begin
        -- Use a bounded FOR loop so the tool sees it can't exceed 10,000
        for i in 0 to 9999 loop
            if endfile(MIF_File) then
                exit;  -- we've reached the end of the file
            end if;

            -- Read one line
            readline(MIF_File, MIF_Line);

            if MIF_Line'length > 0 then
                parse_line(MIF_Line, success, Addr, Temp_Word);

                if success then
                    if (Addr >= 0) and (Addr <= 255) then
                        ROM_Data(Addr) := Temp_Word;
                    end if;
                end if;
            end if;
        end loop;

        file_close(MIF_File);
        return ROM_Data;
    end function;

    --------------------------------------------------------------------
    -- Constant ROM_Content
    -- In simulation: tries to read "Instructions.mif" at elaboration time.
    -- In synthesis : typically ignored => zero-initialized memory in FPGA.
    --------------------------------------------------------------------
    constant ROM_Content : ROM_Array := Init_ROM_From_MIF("Instructions2.mif");

begin

    -- Asynchronous read from the ROM array
    data <= ROM_Content(to_integer(unsigned(address)));

end Behavioral;
