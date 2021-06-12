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
use work.nanoProcesseur_package.all;
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
         Pc_load_o  : out std_logic;
         Ir_load_o  : out std_logic;
         Data_wr_o  : out std_logic;
         Ccr_load_o  : out std_logic;
         Acc_load_o  : out std_logic                  
        );
end sequenceur;

architecture Behavioral of sequenceur is
    type ETAT_TYPE is (eREPOS,eCHARGEIR,eSELECTIONOP,ESAUVER);
    signal etat : ETAT_TYPE;
begin
process(Clk_i,Reset_i)
begin
    if reset_i='1' then
        etat <= eREPOS;
    elsif rising_edge(clk_i) then
        Ccr_load_o <= '0';
        Acc_load_o <= '0';
        Oper_sel_o <= (others => '0');
        Pc_inc_o <= '0';
        Pc_load_o <= '0';
        Ir_load_o <= '0';
        case etat is 
            when eREPOS =>
                etat <= eCHARGEIR;
            when eCHARGEIR =>
                etat <= eSELECTIONOP;
                Ir_load_o <= '1';
                case Opcode_ir_i is
                    when BZ0 =>
                        if Znvc_ccr_i(3) = '0' then
                            Pc_inc_o <= '0';
                            Pc_load_o <= '1';
                        else
                            Pc_inc_o <= '1';
                            Pc_load_o <= '0';
                        end if;
                    when BZ1 =>
                        if Znvc_ccr_i(3) = '1' then
                            Pc_inc_o <= '0';
                            Pc_load_o <= '1';
                        else
                            Pc_inc_o <= '1';
                            Pc_load_o <= '0';
                        end if;
                    when BC0 =>
                        if Znvc_ccr_i(0) = '0' then
                            Pc_inc_o <= '0';
                            Pc_load_o <= '1';
                        else
                            Pc_inc_o <= '1';
                            Pc_load_o <= '0';
                        end if;
                    when BC1 =>
                        if Znvc_ccr_i(0) = '1' then
                            Pc_inc_o <= '0';
                            Pc_load_o <= '1';
                        else
                            Pc_inc_o <= '1';
                            Pc_load_o <= '0';
                        end if;
                    when BV0 =>
                        if Znvc_ccr_i(1) = '0' then
                            Pc_inc_o <= '0';
                            Pc_load_o <= '1';
                        else
                            Pc_inc_o <= '1';
                            Pc_load_o <= '0';
                        end if;
                    when BV1 =>
                        if Znvc_ccr_i(1) = '1' then
                            Pc_inc_o <= '0';
                            Pc_load_o <= '1';
                        else
                            Pc_inc_o <= '1';
                            Pc_load_o <= '0';
                        end if;
                    when BN0 =>
                        if Znvc_ccr_i(2) = '0' then
                            Pc_inc_o <= '0';
                            Pc_load_o <= '1';
                        else
                            Pc_inc_o <= '1';
                            Pc_load_o <= '0';
                        end if;
                    when BN1 =>
                        if Znvc_ccr_i(2) = '1' then
                            Pc_inc_o <= '0';
                            Pc_load_o <= '1';
                        else
                            Pc_inc_o <= '1';
                            Pc_load_o <= '0';
                        end if;
                     when  BRA =>
                        Pc_inc_o <= '0';
                        Pc_load_o <= '1';                
                     when others =>
                        Pc_inc_o <= '1';
                        Pc_load_o <= '0';
                end case; 
            when eSELECTIONOP =>
                etat <= ESAUVER;
                case Opcode_ir_i is
                     when LOADconst | NEGconst =>
                        Oper_sel_o <= "001";
                     when LOADaddr | NEGaddr | INCaddr | ADCconst  =>
                        Oper_sel_o <= "010";   
                     when andconst | orconst | xorconst | addconst | ADCconst =>
                        Oper_sel_o <= "011";   
                     when andaddr | oraddr | xoraddr | addaddr | adcaddr =>
                        Oper_sel_o <= "100";   
                     when rolaccu | roraccu | DECaccu | INCaccu | NEGaccu =>
                        Oper_sel_o <= "101";   
                     when others =>
                        Oper_sel_o <= (others => '0');
                end case;        
            when ESAUVER =>
                etat <= eCHARGEIR;
                case Opcode_ir_i is
                    when LOADconst | LOADaddr | ANDconst | ANDaddr | ORconst | ORaddr | XORconst | XORaddr |
                     ROLaccu | RORaccu | ADDconst | ADDaddr | ADCconst | ADCaddr | NEGaccu | NEGconst | NEGaddr | INCaccu | INCaddr | DECaccu | DECaddr =>
                        Ccr_load_o <= '1';
                        Acc_load_o <= '1';
                     when SETC | CLRC | TRFNC =>
                        Ccr_load_o <= '1';
                        Acc_load_o <= '0';
                     when others =>
                        Ccr_load_o <= '0';
                        Acc_load_o <= '0';
                end case;
            when others =>
                etat <= eREPOS;
        end case;
    end if;
end process;
end Behavioral;
