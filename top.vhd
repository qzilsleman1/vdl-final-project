library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity top is 
    port (
        --inputs
        clock: in std_logic;
        start: in std_logic;
        w: in std_logic_vector(15 downto 0);
        x: in std_logic_vector(15 downto 0);
        --outputs
        ready: out std_logic;
        result_out: out std_logic_vector(15 downto 0);
        done: out std_logic
    );
end top;

architecture arch_top of top is 
    -- Intermediate Signals
    signal eq_mins1: std_logic;
    signal en_regw: std_logic;
    signal en_regx: std_logic;
    signal en_reg_temp: std_logic;
    signal en_reg_sumwx: std_logic;
    signal en_reg_sumw: std_logic;
    signal en_result: std_logic;
    signal sel_mux1: std_logic_vector(1 downto 0);
    signal sel_mux2: std_logic_vector(1 downto 0);
    signal sel_alu: std_logic_vector(1 downto 0);
    signal reg_reset: std_logic;
begin

    -- DataPath
    inst_dp: entity work.datapath 
        port map(
            clock => clock,
            start => start,
            w => w,
            x => x,
            eq_mins1 => eq_mins1,
            en_reg_temp => en_reg_temp,
            en_reg_sumwx => en_reg_sumwx,
            en_reg_sumw => en_reg_sumw,
            en_result => en_result,
            sel_mux1 => sel_mux1,
            sel_mux2 => sel_mux2,
            sel_alu => sel_alu,
            reg_reset => reg_reset,
            result_out => result_out
        );

    -- Control Unit
    inst_cu: entity work.cu 
        port map(
            clock => clock,
            start => start,
            eq_mins1 => eq_mins1,
            en_reg_temp => en_reg_temp,
            en_reg_sumwx => en_reg_sumwx,
            en_reg_sumw => en_reg_sumw,
            en_result => en_result,
            sel_mux1 => sel_mux1,
            sel_mux2 => sel_mux2,
            sel_alu => sel_alu,
            reg_reset => reg_reset,
            ready => ready,
            done => done
        );
        
end arch_top;