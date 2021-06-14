----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.05.2021 08:58:01
-- Design Name: 
-- Module Name: ALU - Behavioral
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
use ieee.numeric_std.all;
use Work.nanoProcesseur_package.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ALU is
    Port(
         Oper1_i : in  std_logic_vector(7 downto 0);
         Oper2_i : in  std_logic_vector(7 downto 0);
         Opcode_i    : in  std_logic_vector(5 downto 0);
         CCR_i       : in  std_logic_vector(3 downto 0);
         CCR_alu_o   : out std_logic_vector(3 downto 0);
         Accu_o   : out std_logic_vector(7 downto 0)
        );
end ALU;

architecture Behavioral of ALU is
    signal CCR: std_logic_vector(3 downto 0);
    signal ALU_result: std_logic_vector(8 downto 0); -- 9 bits pour le carry
begin 
    -- Z <= 1 si tout les bits sont ? 0 (3)
    -- N si negatif (si le msb de oper ? 1) (0)
    -- V si overflow (1)
    -- C si il y a eu une carry (si le 9i?me bits est ? un (carry car en dehors de operande)) (2)
    process(Oper1_i, Oper2_i, Opcode_i, CCR_i)
    begin
        case Opcode_i is
            when LOADconst | LOADaddr =>
                ALU_result <= '0' & Oper1_i;
                if ALU_result = "000000000" then
                    CCR(3) <= '1';
                end if;
                if ALU_result(7) = '1' then
                    CCR(0) <= '1';
                end if; 
            when ANDconst | ANDaddr =>
                ALU_result <= '0' & (Oper1_i and Oper2_i);
                if ALU_result = "000000000" then
                    CCR(3) <= '1';
                end if;
                if ALU_result(7) = '1' then
                    CCR(0) <= '1';
                end if; 
            when ORconst | ORaddr =>
                ALU_result <= '0' & (Oper1_i or Oper2_i);
                if ALU_result = "000000000" then
                    CCR(3) <= '1';
                end if;
                if ALU_result(7) = '1' then
                    CCR(0) <= '1';
                end if; 
            when XORconst | XORaddr =>
                ALU_result <= '0' & (Oper1_i xor Oper2_i);
                if ALU_result = "000000000" then
                    CCR(3) <= '1';
                end if;
                if ALU_result(7) = '1' then
                    CCR(0) <= '1';
                end if; 
            when ROLaccu =>
                ALU_result <= Oper1_i & CCR_i(2);
                if ALU_result = "000000000" then
                    CCR(3) <= '1';
                end if;
                if ALU_result(7) = '1' then
                    CCR(0) <= '1';
                end if;
                if ALU_result(8) = '1' then
                    CCR(2) <= '1';
                end if; 
            when RORaccu =>
                ALU_result <= CCR_i(2) & Oper1_i;
                if ALU_result = "000000000" then
                    CCR(3) <= '1';
                end if;
                if ALU_result(7) = '1' then
                    CCR(0) <= '1';
                end if;
                if ALU_result(8) = '1' then
                    CCR(2) <= '1'; 
                end if;
            when ADDconst =>
                ALU_result <= std_logic_vector(('0' & unsigned(Oper1_i)) + ('0' & unsigned(Oper2_i)));
                if ALU_result = "000000000" then
                    CCR(3) <= '1';
                end if;
                if ALU_result(7) = '1' then
                    CCR(0) <= '1';
                end if;
                if ALU_result(8) = '1' then
                    CCR(2) <= '1';
                end if;
                if ALU_result = "111111111" then --a pas trouv?
                    CCR(1) <= '1';
                end if;
            when ADDaddr =>
                ALU_result <= std_logic_vector(('0' & unsigned(Oper1_i)) + ('0' & unsigned(Oper2_i)));
                if ALU_result = "000000000" then
                    CCR(3) <= '1';
                end if;
                if ALU_result(7) = '1' then
                    CCR(0) <= '1';
                end if;
                if ALU_result(8) = '1' then
                    CCR(2) <= '1';
                end if;
                if ALU_result = "111111111" then --a pas trouv?
                    CCR(1) <= '1';
                end if;
            when ADCconst =>
                ALU_result <= std_logic_vector(('0' & unsigned(Oper1_i)) + ('0' & unsigned(Oper2_i)) + ("" & CCR_i(2)));
                if ALU_result = "000000000" then
                    CCR(3) <= '1';
                end if;
                if ALU_result(7) = '1' then
                    CCR(0) <= '1';
                end if;
                if ALU_result(8) = '1' then
                    CCR(2) <= '1';
                end if;
                if ALU_result = "111111111" then --a pas trouv?
                    CCR(1) <= '1';
                end if;
            when ADCaddr =>
                ALU_result <= std_logic_vector(('0' & unsigned(Oper1_i)) + ('0' & unsigned(Oper2_i)) + ("" & CCR_i(2)));
                if ALU_result = "000000000" then
                    CCR(3) <= '1';
                end if;
                if ALU_result(7) = '1' then
                    CCR(0) <= '1';
                end if;
                if ALU_result(8) = '1' then
                    CCR(2) <= '1';
                end if;
                if ALU_result = "111111111" then --a pas trouv?
                    CCR(1) <= '1';
                end if;
            when NEGaccu =>
                ALU_result <= '0' & std_logic_vector(unsigned(Oper1_i xor "11111111") + 1);
                if ALU_result = "000000000" then
                    CCR(3) <= '1';
                end if;
                if ALU_result(7) = '1' then
                    CCR(0) <= '1';
                end if;
            when NEGconst =>
                ALU_result <= '0' & std_logic_vector(unsigned(Oper1_i xor "11111111") + 1);
                if ALU_result = "000000000" then
                    CCR(3) <= '1';
                end if;
                if ALU_result(7) = '1' then
                    CCR(0) <= '1';
                end if;
            when NEGaddr =>
                ALU_result <= '0' & std_logic_vector(unsigned(Oper1_i xor "11111111") + 1);
                if ALU_result = "000000000" then
                    CCR(3) <= '1';
                end if;
                if ALU_result(7) = '1' then
                    CCR(0) <= '1';
                end if;
            when INCaccu =>
                ALU_result <= std_logic_vector(unsigned('0' & Oper1_i) + 1);
                if ALU_result = "000000000" then
                    CCR(3) <= '1';
                end if;
                if ALU_result(7) = '1' then
                    CCR(0) <= '1';
                end if;
                if ALU_result(8) = '1' then
                    CCR(2) <= '1';
                end if;
            when INCaddr =>
                ALU_result <= std_logic_vector(unsigned('0' & Oper1_i) + 1);
                if ALU_result = "000000000" then
                    CCR(3) <= '1';
                end if;
                if ALU_result(7) = '1' then
                    CCR(0) <= '1';
                end if;
                if ALU_result(8) = '1' then
                    CCR(2) <= '1';
                end if;
            when DECaccu =>
                ALU_result <= std_logic_vector(unsigned('0' & Oper1_i) - 1);
                if ALU_result = "000000000" then
                    CCR(3) <= '1';
                end if;
                if ALU_result(7) = '1' then
                    CCR(0) <= '1';
                end if;
                if ALU_result(8) = '1' then
                    CCR(2) <= '1';
                end if;
            when DECaddr =>
                ALU_result <= std_logic_vector(unsigned('0' & Oper1_i) - 1);
                if ALU_result = "000000000" then
                    CCR(3) <= '1';
                end if;
                if ALU_result(7) = '1' then
                    CCR(0) <= '1';
                end if;
                if ALU_result(8) = '1' then
                    CCR(2) <= '1';
                end if;
            when SETC =>
                CCR(2) <= '1';     
            when CLRC =>
                CCR(2) <= '0';
            when TRFNC =>
                CCR(2) <= CCR_i(0);
            when others =>
                CCR <= (others => '0');
                ALU_result <= (others => '0');
        end case;
        CCR_alu_o <= CCR;
        Accu_o <= ALU_result(7 downto 0);
    end process;
end Behavioral;
