library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity testbench is 
end testbench;

architecture arch_testbench of testbench is 
    --intermediate signals
    --inputs
    signal clock: std_logic:= '0';
    signal start: std_logic:= '0';
    signal w: std_logic_vector(15 downto 0):= (others => '0');
    signal x: std_logic_vector(15 downto 0):= (others => '0');
    --outputs
    signal ready: std_logic;
    signal result_out: std_logic_vector(15 downto 0);
    signal done: std_logic;
begin

    --design under test
    dut: entity work.top 
        port map(     
        --inputs
        clock => clock,
        start => start,
        w => w,
        x => x,
        --outputs
        ready => ready,
        result_out => result_out,
        done => done
        );

    --100 Mhz clock generator
        clock <= NOT clock after 5 ns;

    --testing process
    process begin
        wait for 100 ns;
        start <= '1';

        wait until (ready = '1');
        start <= '0';
        -- first course 
        x <= x"0002";
        w <= x"0005";

        wait until (ready = '1');
        -- Second course 
        x <= x"0006";
        w <= x"0004";
        
        wait until (ready = '1');
        -- Third course 
        x <= x"000a";
        w <= x"0008";

        wait until (ready = '1');
        -- stop condition
        x <= std_logic_vector(to_signed(-1,x'length));
        w <= std_logic_vector(to_signed(-1,x'length));

        wait until (done = '1');
        wait for 100 ns;
        wait; 
        
    end process;

end arch_testbench;