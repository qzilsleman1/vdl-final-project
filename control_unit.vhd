library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity cu is
    port(
        clock: in std_logic;
        start: in std_logic;
        eq_mins1: in std_logic; -- stop condition
        --outputs
        en_reg_temp: out std_logic;
        en_reg_sumwx: out std_logic;
        en_reg_sumw: out std_logic;
        en_result: out std_logic;
        sel_mux1: out std_logic_vector(1 downto 0);
        sel_mux2: out std_logic_vector(1 downto 0);
        sel_alu: out std_logic_vector(1 downto 0);
        reg_reset: out std_logic;
        ready: out std_logic;
        done: out std_logic
    );
end cu;

architecture arch_cu of cu is 
    -- define FSM
    type states is(
        state_idle, -- wait for start
        state_reg_wx, -- input w and x
        state_check_wx, -- check if w or x is -1 ? 
        state_stage1, -- if not stopping condition -- then temp = w * x
        state_stage2, -- wx = wx + temp
        state_stage3, -- w = w + in_w
        state_reg_out, -- state to register output
        state_done -- output is ready
    );
    signal p_state: states:= state_idle;
begin

    process(clock,start,eq_mins1) begin
        if rising_edge(clock) then
            case(p_state) is
                when state_idle => 
                    if(start = '1') then
                        p_state <= state_reg_wx;
                    end if;
                
                when state_reg_wx => 
                    p_state <= state_check_wx;
                
                when state_check_wx => 
                    if(eq_mins1 = '1') then
                        p_state <= state_reg_out;
                    else 
                        p_state <= state_stage1;
                    end if;
                
                when state_stage1 => 
                    p_state <= state_stage2;
                
                when state_stage2 => 
                    p_state <= state_stage3;
                
                when state_stage3 => 
                    p_state <= state_reg_wx;
                
                when state_reg_out => 
                    p_state <= state_done;

                when state_done => 
                    if(start = '1') then 
                        p_state <= state_idle;
                    end if;
                when others => 
                    p_state <= state_idle;
            end case;
        end if;
    end process;

    --outputs
    process(p_state) begin
        case (p_state) is 
            when state_idle => 
                en_reg_temp <= '0';
                en_reg_sumwx <= '0';
                en_reg_sumw <= '0';
                en_result  <= '0';
                sel_mux1 <= "00";
                sel_mux2 <= "00";
                sel_alu <= "00";
                reg_reset <= '1';
                done <= '0';
                ready <= '0';
            
            when state_reg_wx =>
                en_reg_temp <= '0';
                en_reg_sumwx <= '0';
                en_reg_sumw <= '0';
                en_result  <= '0';
                sel_mux1 <= "00";
                sel_mux2 <= "00";
                sel_alu <= "00";
                reg_reset <= '0';
                done <= '0';
                ready <= '1';

            when state_check_wx => 
                en_reg_temp <= '0';
                en_reg_sumwx <= '0';
                en_reg_sumw <= '0';
                en_result  <= '0';
                sel_mux1 <= "00";
                sel_mux2 <= "00";
                sel_alu <= "00";
                reg_reset <= '0';
                done <= '0';
                ready <= '0';

            when state_stage1 => 
                en_reg_temp <= '1';
                en_reg_sumwx <= '0';
                en_reg_sumw <= '0';
                en_result  <= '0';
                sel_mux1 <= "00";
                sel_mux2 <= "00";
                sel_alu <= "01";
                reg_reset <= '0';
                done <= '0';
                ready <= '0';

            when state_stage2 => 
                en_reg_temp <= '0';
                en_reg_sumwx <= '1';
                en_reg_sumw <= '0';
                en_result  <= '0';
                sel_mux1 <= "01";
                sel_mux2 <= "10";
                sel_alu <= "00";
                reg_reset <= '0';
                done <= '0';
                ready <= '0';

            when state_stage3 => 
                en_reg_temp <= '0';
                en_reg_sumwx <= '0';
                en_reg_sumw <= '1';
                en_result  <= '0';
                sel_mux1 <= "00";
                sel_mux2 <= "11";
                sel_alu <= "00";
                reg_reset <= '0';
                done <= '0';
                ready <= '0';

            when state_reg_out =>  
                en_reg_temp <= '0';
                en_reg_sumwx <= '0';
                en_reg_sumw <= '0';
                en_result  <= '1';
                sel_mux1 <= "10";
                sel_mux2 <= "11";
                sel_alu <= "10";
                reg_reset <= '0';
                done <= '0';
                ready <= '0';
            

            when state_done => 
                en_reg_temp <= '0';
                en_reg_sumwx <= '0';
                en_reg_sumw <= '0';
                en_result  <= '0';
                sel_mux1 <= "00";
                sel_mux2 <= "00";
                sel_alu <= "00";
                reg_reset <= '0';
                done <= '1';
                ready <= '0';
            
            when others => 
                en_reg_temp <= '0';
                en_reg_sumwx <= '0';
                en_reg_sumw <= '0';
                en_result  <= '0';
                sel_mux1 <= "00";
                sel_mux2 <= "00";
                sel_alu <= "00";
                reg_reset <= '0';
                done <= '0';
                ready <= '0';

        end case;
    end process;

end arch_cu;