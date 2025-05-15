library IEEE;
use IEEE.std_logic_1164.all;

entity FA_G1 is
    port (
        x    : in  std_logic;
        y    : in  std_logic;
        cin  : in  std_logic;
        s    : out std_logic;
        cout : out std_logic
    );
end entity FA_G1;

architecture structural of FA_G1 is
    signal s_xor : std_logic;
begin


    s_xor <= x xor y;
    s     <= s_xor xor cin;
    

    cout <= (x and y) or
            (x and cin) or
            (y and cin);

end architecture structural;