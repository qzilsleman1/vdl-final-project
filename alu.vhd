library ieee;
use ieee.std_logic_1164.all;
USE ieee.numeric_std.ALL;

entity alu is
port( 
    a,b : in std_logic_vector(15 downto 0);
    opcode : in std_logic_vector(1 downto 0);
    res: out std_logic_vector(15 downto 0)
);
end;

architecture behave of alu is
signal tmp : integer;
begin
P1: process(opcode, a, b)
 begin
  C1: case opcode is
      when "00" => tmp <= to_integer(signed(a))+to_integer(signed(b)) after 5 ps;
      when "01" => tmp <= to_integer(signed(a))*to_integer(signed(b)) after 7 ps;
      when "10" => tmp <= to_integer(signed(a))/to_integer(signed(b)) after 10 ps;
      when others => tmp <= 0;
  end case C1;
 end process;
res <= std_logic_vector(to_signed(tmp, res'length));
end behave;
