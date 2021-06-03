----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.05.2021 08:37:57
-- Design Name: 
-- Module Name: sequenceur - Behavioral
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

entity sequenceur is
    Port(
         Clk_i       : in  std_logic;
         Reset_i     : in  std_logic;
         Opcode_ir_i   : in  std_logic_vector(5 downto 0);
         Znvc_ccr_i        : in  std_logic_vector(3 downto 0);
         Oper_sel_o    : out std_logic_vector( 2 downto 0);
         Opper_load_o  : out std_logic;
         Pc_inc_o  : out std_logic;
         Ir_load_o  : out std_logic;
         Data_wr_o  : out std_logic;
         Ccr_load_o  : out std_logic;
         Acc_load_o  : out std_logic                  
        );
end sequenceur;

architecture Behavioral of sequenceur is
    type ETAT_TYPE is (eREPOS,eCHARGE,eSAUVER,eSELECTION);
    signal etat : ETAT_TYPE;
begin
Ir_load_o <= '1' when etat = eCHARGE else  '0';
process(Clk_i,Reset_i)
begin
    if reset_i='1' then
        etat <= eREPOS;
    elsif rising_edge(clk_i) then
        case etat is 
            when eREPOS =>
                etat <= eCHARGE;
            when eCHARGE =>
                etat <= eSAUVER;
            when eSAUVER =>
                etat <= eSELECTION;        
            when eSELECTION =>
                etat <= eCHARGE;
            when others =>
                etat <= eREPOS;
        end case;
    end if;
end process;
end Behavioral;
