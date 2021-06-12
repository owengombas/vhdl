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
--  Port ( );
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
          oper2_o : out STD_LOGIC_VECTOR (7 downto 0));
    end component mux_up;
    
    component programCounter is
    Port(
        Clk_i           : in  std_logic;
        Reset_i         : in  std_logic;
        Pc_inc_i        : in  std_logic;
        Pc_load_i       : in  std_logic;
        Operande_i      : in  std_logic_vector(7 downto 0);
        Pc_o            : out std_logic_vector(7 downto 0));
    end component programCounter;
    
    component registre_IR is
    Port (
        Clk_i       : in  std_logic;
        Reset_i     : in  std_logic;
        Instr_i   : in  std_logic_vector(13 downto 0);
        Ir_load_i        : std_logic;
        Opcode_o    : out std_logic_vector( 5 downto 0);
        Operande_o  : out std_logic_vector( 7 downto 0));
    end component registre_IR;
    
    component sequenceur is
    Port(
        Clk_i       : in  std_logic;
        Reset_i     : in  std_logic;
        Opcode_ir_i   : in  std_logic_vector(5 downto 0);
        Znvc_ccr_i        : in  std_logic_vector(3 downto 0);
        Oper_sel_o    : out std_logic_vector(2 downto 0);
        Opper_load_o  : out std_logic;
        Pc_inc_o  : out std_logic;
        Ir_load_o  : out std_logic;
        Data_wr_o  : out std_logic;
        Ccr_load_o  : out std_logic;
        Acc_load_o  : out std_logic);
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
        Oper1_i: in  std_logic_vector(7 downto 0);
        Oper2_i: in  std_logic_vector(7 downto 0);
        CCR_i: in  std_logic_vector(3 downto 0);
        Opcode_i: in  std_logic;
        ALU_result_o: in  std_logic_vector(8 downto 0)
    );
    end component ALU;

    component ALU2 is
        Port ( ALU_result_i : in STD_LOGIC_VECTOR (8 downto 0);
               Accu_o : out STD_LOGIC_VECTOR (7 downto 0);
               CCR_alu_o : out STD_LOGIC_VECTOR (3 downto 0));
    end component ALU2;
begin


end Behavioral;
