----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/14/2021 12:09:12 AM
-- Design Name: 
-- Module Name: microControleur - Behavioral
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

entity microControleur is
  Port (
    clk_i: in std_logic;
    Reset_i: in std_logic;
    a_i: in STD_LOGIC_VECTOR (7 downto 0);
    b_i: in STD_LOGIC_VECTOR (7 downto 0);
    a_o: out STD_LOGIC_VECTOR (7 downto 0);
    b_o: out STD_LOGIC_VECTOR (7 downto 0)
  );
end microControleur;

architecture Behavioral of microControleur is
    component microProcesseur is
        Port (
            clk_i: in std_logic;
            Reset_i: in std_logic;
            ac_mux_data_i: in STD_LOGIC_VECTOR (7 downto 0);
            ac_ir_instr_i: in STD_LOGIC_VECTOR (13 downto 0);
            ap_mux_data_o: out STD_LOGIC_VECTOR (7 downto 0);
            ap_ir_operande_o: out STD_LOGIC_VECTOR (7 downto 0);
            ap_seq_data_wr_o: out STD_LOGIC;
            ap_pc_o: out STD_LOGIC_VECTOR (7 downto 0)
        );
    end component microProcesseur;

    component RAM is
        Port (
            clk_i : in STD_LOGIC;
            reset_i : in STD_LOGIC;
            operande_i : in STD_LOGIC_VECTOR (7 downto 0);
            enable_r_i : in STD_LOGIC;
            data_wr_i : in STD_LOGIC_VECTOR (7 downto 0);
            ram_o : out STD_LOGIC_VECTOR (7 downto 0)
        );
    end component RAM;
    
    component ROM is
        Port (
            pc_i : in STD_LOGIC_VECTOR (7 downto 0);
            instruct_o : out STD_LOGIC_VECTOR (11 downto 0)
        );
    end component ROM; 
    
    component multiplexeur is
        Port (
            ram_i       : in  std_logic_vector(7 downto 0);
            a_i         : in  std_logic_vector(7 downto 0);
            b_i         : in  std_logic_vector(7 downto 0);
            operande_i  : in  std_logic_vector(7 downto 0);
            data_o      : out std_logic_vector(7 downto 0)
        );
    end component multiplexeur;
    
    component decodeur_DAdresses is
        Port ( 
            a_i          : in STD_LOGIC_VECTOR (7 downto 0);
            b_i          : in STD_LOGIC_VECTOR (7 downto 0);
            pc_i         : in STD_LOGIC_VECTOR (7 downto 0);
            enable_p_o   : out STD_LOGIC;
            enable_s_o   : out STD_LOGIC;
            enable_r_o   : out STD_LOGIC;
            a_o          : out STD_LOGIC_VECTOR (7 downto 0);
            b_o          : out STD_LOGIC_VECTOR (7 downto 0)
        );
    end component decodeur_DAdresses;
    
    component registre is
        Port(
             input_value    : in STD_LOGIC_VECTOR (7 downto 0);
             enable_p_i     : in  std_logic;
             clk_i          : in  std_logic;
             reset_i        : in  std_logic;
             output_value   : out STD_LOGIC_VECTOR (7 downto 0)
         );
    end component registre;

    signal mux_ap_data: std_logic_vector(7 downto 0);
    
    signal ram_mux_ram: std_logic_vector(7 downto 0);

    signal dec_ram_enable_r: std_logic;
    signal dec_enable_s: std_logic;
    signal dec_enable_p: std_logic;
    signal dec_mux_a: std_logic_vector(7 downto 0);
    signal dec_mux_b: std_logic_vector(7 downto 0);
    
    signal pai_dec_out: std_logic_vector(7 downto 0);
    
    signal pbi_dec_out: std_logic_vector(7 downto 0);

    signal pas_ac_out: std_logic_vector(7 downto 0);
    
    signal pbs_ac_out: std_logic_vector(7 downto 0);

    signal rom_ap_instruct: std_logic_vector(13 downto 0);
   
    signal ap_operande: std_logic_vector(7 downto 0);
    signal ap_pc: std_logic_vector(7 downto 0);
    signal ap_data_out: std_logic_vector(7 downto 0);
    signal ap_ram_data_wr: std_logic;
begin

ap_inst: microProcesseur
    port map(
        clk_i => clk_i,
        reset_i => reset_i,
        ac_mux_data_i => mux_ap_data,
        ac_ir_instr_i => rom_ap_instruct,
        ap_mux_data_o => ap_data_out,
        ap_ir_operande_o => ap_operande,
        ap_seq_data_wr_o => ap_ram_data_wr,
        ap_pc_o => ap_pc
    );

RAM_inst: RAM
    port map(
        clk_i       => clk_i,
        reset_i     => reset_i,
        ram_o => ram_mux_ram,
        enable_r_i => dec_ram_enable_r,
        data_wr_i => ap_pc,
        operande_i => ap_operande
    );

ROM_inst: ROM
    port map(
        pc_i => ap_pc,
        instruct_o => rom_ap_instruct
    );

MUX_inst: multiplexeur
    port map(
        operande_i => ap_operande,
        ram_i => ram_mux_ram,
        data_o => mux_ap_data,
        a_i => dec_mux_a,
        b_i => dec_mux_b
    );
 
decodeur_DAdresses_inst: decodeur_DAdresses
    port map(
        a_o => dec_mux_a,
        b_o => dec_mux_b,
        enable_r_o => dec_ram_enable_r,
        enable_s_o => dec_enable_s,
        enable_p_o => dec_enable_p,
        a_i => pai_dec_out,
        b_i => pbi_dec_out,
        pc_i => ap_pc
    );
    
 
port_a_in_inst: registre
    port map(
        enable_p_i => dec_enable_p,
        output_value => pai_dec_out,
        clk_i => clk_i,
        reset_i => reset_i,
        input_value => a_i
    );
    
    
port_b_in_inst: registre
    port map(
        enable_p_i => dec_enable_p,
        output_value => pbi_dec_out,
        clk_i => clk_i,
        reset_i => reset_i,
        input_value => b_i
    );
    
port_a_out_inst: registre
    port map(
        enable_p_i => dec_enable_s,
        output_value => a_o,
        clk_i => clk_i,
        reset_i => reset_i,
        input_value => ap_data_out
    );
    
port_b_out_inst: registre
    port map(
        enable_p_i => dec_enable_s,
        output_value => b_o,
        clk_i => clk_i,
        reset_i => reset_i,
        input_value => ap_data_out
    );


end Behavioral;
