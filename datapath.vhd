library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity datapath is
    port(
        -- inputs
        clock: in std_logic;
        start: in std_logic;
        w: in std_logic_vector(15 downto 0);
        x: in std_logic_vector(15 downto 0);
        en_reg_temp: in std_logic;
        en_reg_sumwx: in std_logic;
        en_reg_sumw: in std_logic;
        en_result: in std_logic;
        sel_mux1: in std_logic_vector(1 downto 0);
        sel_mux2: in std_logic_vector(1 downto 0);
        sel_alu: in std_logic_vector(1 downto 0);
        reg_reset: in std_logic;
        -- outputs
        eq_mins1: out std_logic; -- stop condition
        result_out: out std_logic_vector(15 downto 0)
    );
end datapath;

architecture arch_datapath of datapath is 
    -- Signals
    signal mux_out1: std_logic_vector(15  downto 0);
    signal mux_out2: std_logic_vector(15  downto 0);
    signal alu_res: std_logic_vector(15 downto 0);
    signal temp: std_logic_vector(15 downto 0);
    signal sumwx: std_logic_vector(15 downto 0);
    signal sumw: std_logic_vector(15 downto 0);
begin

    -- First mux
    inst_mux1: entity work.mux
        port map(
            mux_in0 => w,
            mux_in1 => temp,
            mux_in2 => sumwx,
            mux_in3 => sumw,
            mux_sel => sel_mux1,
            mux_out => mux_out1 
        );

    --second mux
    inst_mux2: entity work.mux
        port map(
            mux_in0 => x,
            mux_in1 => temp,
            mux_in2 => sumwx,
            mux_in3 => sumw,
            mux_sel => sel_mux2,
            mux_out => mux_out2 
        );

    -- ALU 
    inst_alu: entity work.alu 
        port map(
            a => mux_out1,
            b => mux_out2,
            opcode => sel_alu,
            res => alu_res
        );

    -- Registers

    inst_reg_temp: entity work.df_f
        port map(
            clock => clock,
            reset => reg_reset,
            enable => en_reg_temp,
            d => alu_res,
            q => temp
        );

    inst_reg_sumwx: entity work.df_f
        port map(
            clock => clock,
            reset => reg_reset,
            enable => en_reg_sumwx,
            d => alu_res,
            q => sumwx
        );

    inst_reg_sumw: entity work.df_f
        port map(
            clock => clock,
            reset => reg_reset,
            enable => en_reg_sumw,
            d => alu_res,
            q => sumw 
        );

    inst_reg_output: entity work.df_f
        port map(
            clock => clock,
            reset => reg_reset,
            enable => en_result,
            d => alu_res,
            q => result_out
        );

    -- comparator
    inst_comp: entity work.comparator
        port map(
            w => w,
            x => x,
            eq_mins1 => eq_mins1
        );
end arch_datapath;