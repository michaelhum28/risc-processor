library IEEE;
use IEEE.std_logic_1164.all;

entity comparator8Bit is
port (
  A, B: in std_logic_vector(7 downto 0);
  AgreaterB: out std_logic;
  AequalB: out std_logic;
  AlessB: out std_logic
);
end;

architecture structural of comparator8Bit is
  signal int_S : std_logic_vector(7 downto 0);

begin

  int_S(0) <= A(0) xnor B(0);
  int_S(1) <= A(1) xnor B(1);
  int_S(2) <= A(2) xnor B(2);
  int_S(3) <= A(3) xnor B(3);
  int_S(4) <= A(4) xnor B(4);
  int_S(5) <= A(5) xnor B(5);
  int_S(6) <= A(6) xnor B(6);
  int_S(7) <= A(7) xnor B(7);

  
  -- A > B
  AgreaterB <= (A(7) and not B(7)) or
               (int_S(7) and A(6) and not B(6)) or
               (int_S(7) and int_S(6) and A(5) and not B(5)) or
               (int_S(7) and int_S(6) and int_S(5) and A(4) and not B(4)) or
               (int_S(7) and int_S(6) and int_S(5) and int_S(4) and A(3) and not B(3)) or
               (int_S(7) and int_S(6) and int_S(5) and int_S(4) and int_S(3) and A(2) and not B(2)) or
               (int_S(7) and int_S(6) and int_S(5) and int_S(4) and int_S(3) and int_S(2) and A(1) and not B(1)) or
               (int_S(7) and int_S(6) and int_S(5) and int_S(4) and int_S(3) and int_S(2) and int_S(1) and A(0) and not B(0));

  -- A = B
  AequalB <= int_S(7) and int_S(6) and int_S(5) and int_S(4) and int_S(3) and int_S(2) and int_S(1) and int_S(0);
    
  -- A < B           
  AlessB <= (B(7) and not A(7)) or
            (int_S(7) and B(6) and not A(6)) or
            (int_S(7) and int_S(6) and B(5) and not A(5)) or
            (int_S(7) and int_S(6) and int_S(5) and B(4) and not A(4)) or
            (int_S(7) and int_S(6) and int_S(5) and int_S(4) and B(3) and not A(3)) or
            (int_S(7) and int_S(6) and int_S(5) and int_S(4) and int_S(3) and B(2) and not A(2)) or
            (int_S(7) and int_S(6) and int_S(5) and int_S(4) and int_S(3) and int_S(2) and B(1) and not A(1)) or
            (int_S(7) and int_S(6) and int_S(5) and int_S(4) and int_S(3) and int_S(2) and int_S(1) and B(0) and not A(0));
end structural;
