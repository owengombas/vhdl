----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.05.2021 08:39:07
-- Design Name: 
-- Module Name: registre_IR - Behavioral
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

entity registre_IR is
    Port (
         Clk_i       : in  std_logic;
         Reset_i     : in  std_logic;
         Instr_i   : in  std_logic_vector(13 downto 0);
         Ir_load_i        : std_logic;
         Opcode_o    : out std_logic_vector( 5 downto 0);
         Operande_o  : out std_logic_vector( 7 downto 0)  
         );
end registre_IR;

architecture Behavioral of registre_IR is

	signal Ir_Reg : std_logic_vector(13 downto 0);
	
begin

Operande_o <= Ir_reg( 7 downto 0);
Opcode_o   <= Ir_reg(13 downto 8);

process(Clk_i,Reset_i)
begin
  if Reset_i = '1' then
    Ir_reg <= (others => '0');
  elsif rising_edge(Clk_i) then
    if Ir_load_i = '1' then    
        Ir_reg <= Instr_i;
    else
        Ir_reg <= "100011"
    end if;
  end if;
end process;

end Behavorial;

