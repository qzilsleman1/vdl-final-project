library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity comparator is
    port(
        w: in std_logic_vector(15 downto 0);
        x: in std_logic_vector(15 downto 0);
        eq_mins1: out std_logic
    );
end comparator;

architecture arch_comparator of comparator is 
begin
    eq_mins1 <= '1' when ((signed(x) = to_signed(-1,x'length)) OR (signed(w) = to_signed(-1,w'length))) else '0';
end  arch_comparator;