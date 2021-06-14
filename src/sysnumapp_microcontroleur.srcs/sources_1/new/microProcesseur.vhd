----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.05.2021 08:36:47
-- Design Name: 
-- Module Name: microProcesseur - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity microProcesseur is
  Port (
    clk_i: in std_logic;
    Reset_i: in std_logic;
    ac_mux_data_i: in STD_LOGIC_VECTOR (7 downto 0);
    ac_ir_instr_i: in STD_LOGIC_VECTOR (13 downto 0);
    ap_mux_data_o: out STD_LOGIC_VECTOR (7 downto 0);
    ap_ir_opcode_o: out STD_LOGIC_VECTOR (5 downto 0);
    ap_seq_data_wr_o: out STD_LOGIC;
    ap_pc_o: out STD_LOGIC_VECTOR (7 downto 0)
  );
end microProcesseur;

architecture Behavioral of microProcesseur is
    component mux_up is
        Port (  
            operande_i : in STD_LOGIC_VECTOR (7 downto 0);
            data_i : in STD_LOGIC_VECTOR (7 downto 0);
            data_out_i : in STD_LOGIC_VECTOR (7 downto 0);
            oper_load_i : in STD_LOGIC;
            oper_sel_i : in STD_LOGIC_VECTOR (2 downto 0);
            --clk_i : in STD_LOGIC;
            --reset_i : in STD_LOGIC;
            oper1_o : out STD_LOGIC_VECTOR (7 downto 0);
            oper2_o : out STD_LOGIC_VECTOR (7 downto 0)
        );
    end component mux_up;
    
    component programCounter is
        Port(
            Clk_i           : in  std_logic;
            Reset_i         : in  std_logic;
            Pc_inc_i        : in  std_logic;
            Pc_load_i       : in  std_logic;
            Operande_i      : in  std_logic_vector(7 downto 0);
            Pc_o            : out std_logic_vector(7 downto 0)
        );
    end component programCounter;
    
    component registre_IR is
        Port (
            Clk_i       : in  std_logic;
            Reset_i     : in  std_logic;
            Instr_i   : in  std_logic_vector(13 downto 0);
            Ir_load_i        : std_logic;
            Opcode_o    : out std_logic_vector( 5 downto 0);
            Operande_o  : out std_logic_vector( 7 downto 0)
        );
    end component registre_IR;
    
    component sequenceur is
        Port(
             Clk_i       : in  std_logic;
             Reset_i     : in  std_logic;
             Pc_inc_o  : out std_logic;
             Pc_load_o: out std_logic;
             Opcode_ir_i   : in  std_logic_vector(5 downto 0);
             Znvc_ccr_i        : in  std_logic_vector(3 downto 0);
             Oper_sel_o    : out std_logic_vector(2 downto 0);
             Opper_load_o  : out std_logic;
             Ir_load_o  : out std_logic;
             Data_wr_o  : out std_logic;
             Ccr_load_o  : out std_logic;
             Acc_load_o  : out std_logic  
        );
    end component sequenceur;
    
    component registre_Accu is
        Port (
            Clk_i       : in  std_logic;
            Reset_i     : in  std_logic;
            Accu_load_i       : in  std_logic;
            Accu_i   : in  std_logic_vector(7 downto 0);
            Data_out_o   : out  std_logic_vector(7 downto 0)
        );
    end component registre_Accu;
    
    
    component registre_CCR is
        Port (
            ccr_load_i: in STD_LOGIC;
            ccr_alu_i: in STD_LOGIC_VECTOR(3 downto 0);
            ccr_o: out STD_LOGIC_VECTOR(3 downto 0);
            clk_i : in STD_LOGIC;
            reset_i : in STD_LOGIC
        );
    end component registre_CCR;
    
    component ALU is
        Port(
            Oper1_i : in  std_logic_vector(7 downto 0);
            Oper2_i : in  std_logic_vector(7 downto 0);
            Opcode_i    : in  std_logic_vector(5 downto 0);
            CCR_i       : in  std_logic_vector(3 downto 0);
            CCR_alu_o   : out std_logic_vector(3 downto 0);
            Accu_o   : out std_logic_vector(7 downto 0)
        );
    end component ALU;

    -- component ALU2 is
    --     Port (
    --         ALU_result_i : in STD_LOGIC_VECTOR (8 downto 0);
    --         Accu_o : out STD_LOGIC_VECTOR (7 downto 0);
    --         CCR_alu_o : out STD_LOGIC_VECTOR (3 downto 0)
    --     );
    -- end component ALU2;
        
    signal ir_pc_operand: std_logic_vector(7 downto 0);
    signal ir_mux_operand: std_logic_vector(7 downto 0);
    signal ir_ac_operand: std_logic_vector(7 downto 0); -- OUT
    signal ir_operand: std_logic_vector(7 downto 0); -- OUT
    signal ir_alu1_opcode: std_logic_vector(5 downto 0);
    signal ir_seq_opcode: std_logic_vector(5 downto 0);
    signal ir_opcode: std_logic_vector(5 downto 0);
    
    signal accu_data_out: std_logic_vector(7 downto 0); -- OUT
    
    signal seq_mux_oper_load: std_logic;
    signal seq_mux_oper_sel: std_logic_vector(2 downto 0);
    signal seq_pc_pc_inc: std_logic;
    signal seq_pc_pc_load: std_logic;
    signal seq_ir_ir_load: std_logic;
    signal seq_ac_data_wr: std_logic; -- OUT
    signal seq_ccr_ccr_load: std_logic;
    signal seq_accu_acc_load: std_logic;

    signal ccr_alu1_ccr: std_logic_vector(3 downto 0);
    signal ccr_seq_crr: std_logic_vector(3 downto 0);
    signal ccr_ccr: std_logic_vector(3 downto 0);
    
    signal pc_ac_pc: std_logic_vector(7 downto 0);
    
    signal mux_alu1_oper1: std_logic_vector(7 downto 0);
    signal mux_alu1_oper2: std_logic_vector(7 downto 0);
    
    signal alu1_accu_accu: std_logic_vector(7 downto 0);
    signal alu1_ccr_ccr_alu: std_logic_vector(7 downto 0);
begin

sequenceur_inst: sequenceur
    port map(
        clk_i       => clk_i,
        reset_i     => reset_i,
        oper_sel_o => seq_mux_oper_sel,
        opper_load_o => seq_mux_oper_load,
        pc_inc_o => seq_pc_pc_inc,
        ir_load_o => seq_ir_ir_load,
        data_wr_o => seq_ac_data_wr,
        ccr_load_o => seq_ccr_ccr_load,
        acc_load_o => seq_accu_acc_load,
        pc_load_o => seq_pc_pc_load,
        opcode_ir_i => ir_seq_opcode,
        znvc_ccr_i => ccr_seq_crr
    );


registre_IR_inst : registre_IR
    port map(
        Clk_i       => clk_i,
        reset_i     => reset_i,
        operande_o => ir_operand,
        opcode_o => ir_opcode,
        ir_load_i => seq_ir_ir_load,
        instr_i => ac_ir_instr_i
    );

registre_CCR_inst : registre_CCR
    port map(
        Clk_i       => clk_i,
        reset_i     => reset_i,
        ccr_o => ccr_ccr,
        ccr_alu_i => alu1_ccr_ccr_alu,
        ccr_load_i => seq_ccr_ccr_load
    );
 
registre_Accu_inst : registre_Accu
    port map(
        Clk_i       => clk_i,
        reset_i     => reset_i,
        accu_load_i => seq_accu_acc_load,
        accu_i => alu1_ccr_ccr_alu,
        data_out_o => accu_data_out
    );

programCounter_inst : programCounter
    port map(
        Clk_i       => clk_i,
        reset_i     => reset_i,
        pc_o => pc_ac_pc,
        operande_i => ir_operand,
        pc_load_i => seq_pc_pc_load,
        pc_inc_i => seq_pc_pc_inc
    );
    

mux_up_inst : mux_up
    port map(
        oper1_o => mux_alu1_oper1,
        oper2_o => mux_alu1_oper2,
        oper_load_i => seq_mux_oper_load,
        oper_sel_i => seq_mux_oper_sel,
        operande_i => ir_operand,
        data_i => ac_mux_data_i,
        data_out_i => accu_data_out
    );

ALU1_inst : ALU
    port map(
        oper1_i => mux_alu1_oper1,
        oper2_i => mux_alu1_oper2,
        ccr_i => ccr_alu1_ccr,
        opcode_i => ir_opcode,
        ccr_alu_o => alu1_ccr_ccr_alu,
        Accu_o => alu1_accu_accu
    );
         

-- ALU2_inst : ALU2
--     port map(
--         alu_result_i => alu1_alu2_alu_result,
--         accu_o => alu2_accu_accu,
--         ccr_alu_o => alu2_accu_accu
--     );

ap_mux_data_o <= accu_data_out;
ap_ir_opcode_o <= ir_opcode;
ap_seq_data_wr_o <= seq_ac_data_wr;
ap_pc_o <= pc_ac_pc;

end Behavioral;
