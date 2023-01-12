library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity df_f is 
    port(
        clock: in std_logic;
        reset: in std_logic;
        enable: in std_logic;
        d: in std_logic_vector(15 downto 0);
        q: out std_logic_vector(15 downto 0):= (others=> '0')  
    );
end df_f;

architecture arch_df_f of df_f is 

begin
    process(clock,enable,d,reset) begin
        if(reset = '1') then
                q <= (others=> '0');
        elsif rising_edge(clock) then
            if(enable = '1') then
                q <= d after 2 ps;
            end if;
        end if;
    end process;

end arch_df_f;