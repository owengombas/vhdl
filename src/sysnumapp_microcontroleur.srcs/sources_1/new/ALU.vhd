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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ALU is
    Port(
        Oper1_i: in  std_logic_vector(7 downto 0);
        Oper2_i: in  std_logic_vector(7 downto 0);
        CCR_i: in  std_logic_vector(3 downto 0);
        Opcode_i: in  std_logic_vector(5 downto 0);
        ALU_result_o: in  std_logic_vector(8 downto 0)
    );
end ALU;

architecture Behavioral of ALU is

begin


end Behavioral;
