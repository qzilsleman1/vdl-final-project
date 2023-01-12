library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity mux is 
    port(
        mux_in0: in std_logic_vector(15 downto 0);
        mux_in1: in std_logic_vector(15 downto 0);
        mux_in2: in std_logic_vector(15 downto 0);
        mux_in3: in std_logic_vector(15 downto 0);
        mux_sel: in std_logic_vector(1 downto 0);
        mux_out: out std_logic_vector(15 downto 0)
    );
end mux;

architecture arch_mux of mux is

begin
    process (mux_sel,mux_in0,mux_in1,mux_in2,mux_in3) begin  
	    case mux_sel is 
            when "00" => mux_out <= mux_in0 after 2 ps;
            when "01" => mux_out <= mux_in1 after 2 ps ;
	    	when "10" => mux_out <= mux_in2 after 2 ps ;  
            when "11" => mux_out <= mux_in3 after 2 ps ;
            when others => mux_out <= (others=> '0'); 
	    end case; 
	end process; 
end arch_mux;