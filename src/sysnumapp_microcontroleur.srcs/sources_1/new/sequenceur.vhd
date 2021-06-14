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
end sequenceur;

architecture Behavioral of sequenceur is
    type ETAT_TYPE is (eREPOS,eCHARGEIR,eSELECTIONOP, eSAUVER);
    signal etat : ETAT_TYPE;
begin
process(Clk_i,Reset_i)
begin
    if reset_i='1' then
        etat <= eREPOS;
        Ccr_load_o <= '0';
        Acc_load_o <= '0';
        Oper_sel_o <= (others => '0');
        Pc_inc_o <= '1';
        Pc_load_o <= '0';
        Ir_load_o <= '0';
        Data_wr_o <= '0';
        Opper_load_o <= '0';
    elsif rising_edge(clk_i) then
        case etat is 
            when eREPOS =>
                if Opcode_ir_i = STOREaddr then
                    etat <= eCHARGEIR;
                    Ccr_load_o <= '0';
                    Acc_load_o <= '0';
                    Oper_sel_o <= (others => '0');
                    Pc_inc_o <= '1';
                    Pc_load_o <= '0';
                    Ir_load_o <= '1';
                    Data_wr_o <= '1';
                    Opper_load_o <= '0';
                end if;
            when eCHARGEIR =>
                if Opcode_ir_i = LOADconst or Opcode_ir_i = NEGconst or Opcode_ir_i = LOADaddr or Opcode_ir_i = NEGaddr or Opcode_ir_i = INCaddr or Opcode_ir_i = DECaddr or Opcode_ir_i = andconst or Opcode_ir_i = orconst or Opcode_ir_i = xorconst or Opcode_ir_i = addconst or Opcode_ir_i = ADCconst or Opcode_ir_i = andaddr or Opcode_ir_i = oraddr or Opcode_ir_i = xoraddr or Opcode_ir_i = addaddr or Opcode_ir_i = adcaddr or Opcode_ir_i = rolaccu or Opcode_ir_i = roraccu or Opcode_ir_i = DECaccu or Opcode_ir_i = INCaccu or Opcode_ir_i = NEGaccu then
                     case Opcode_ir_i is
                        when LOADconst | NEGconst =>
                           Oper_sel_o <= "001";
                        when LOADaddr | NEGaddr | INCaddr | DECaddr  =>
                           Oper_sel_o <= "010";   
                        when andconst | orconst | xorconst | addconst | ADCconst =>
                           Oper_sel_o <= "011";   
                        when andaddr | oraddr | xoraddr | addaddr | adcaddr =>
                           Oper_sel_o <= "100";   
                        when rolaccu | roraccu | DECaccu | INCaccu | NEGaccu =>
                           Oper_sel_o <= "101";   
                        when others =>
                           Oper_sel_o <= (others => '0');
                        Ccr_load_o <= '0';
                        Acc_load_o <= '0';
                        Pc_inc_o <= '1';
                        Pc_load_o <= '0';
                        Ir_load_o <= '0';
                        Data_wr_o <= '0';
                        Opper_load_o <= '0';
                     end case;
                end if; 
            when eSELECTIONOP =>
                if Opcode_ir_i /= NOP or Opcode_ir_i /= STOREaddr then
                    etat <= ESAUVER;
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
                    Oper_sel_o <= (others => '0');
                    Ir_load_o <= '0';
                    Data_wr_o <= '0';
                    Opper_load_o <= '0';
                end if;  
            when others =>
                etat <= eREPOS;
                Ccr_load_o <= '0';
                Acc_load_o <= '0';
                Oper_sel_o <= (others => '0');
                Pc_inc_o <= '1';
                Pc_load_o <= '0';
                Ir_load_o <= '0';
                Data_wr_o <= '0';
                Opper_load_o <= '0';
        end case;
    end if;
end process;
end Behavioral;
