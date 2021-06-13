----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/12/2021 02:38:36 PM
-- Design Name: 
-- Module Name: ALU2 - Behavioral
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

entity ALU2 is
    Port ( ALU_result_i : in STD_LOGIC_VECTOR (8 downto 0);
           Accu_o : out STD_LOGIC_VECTOR (7 downto 0);
           CCR_alu_o : out STD_LOGIC_VECTOR (3 downto 0));
end ALU2;

architecture Behavioral of ALU2 is

begin


end Behavioral;
