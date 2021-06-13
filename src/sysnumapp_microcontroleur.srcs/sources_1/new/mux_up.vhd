----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/05/2021 12:57:18 PM
-- Design Name: 
-- Module Name: mux_up - Behavioral
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

entity mux_up is
    Port ( operande_i : in STD_LOGIC_VECTOR (7 downto 0);
           data_i : in STD_LOGIC_VECTOR (7 downto 0);
           data_out_i : in STD_LOGIC_VECTOR (7 downto 0);
           oper_load_i : in STD_LOGIC;
           oper_sel_i : in STD_LOGIC_VECTOR (2 downto 0);
           --clk_i : in STD_LOGIC;
           --reset_i : in STD_LOGIC;
           oper1_o : out STD_LOGIC_VECTOR (7 downto 0);
           oper2_o : out STD_LOGIC_VECTOR (7 downto 0));
end mux_up;

architecture Behavioral of mux_up is
    signal reg: STD_LOGIC_VECTOR (7 downto 0);
begin

with oper_sel_i select
  oper1_o <= data_out_i     when "010",
             operande_i     when "100",
             data_i         when others;
               
with oper_sel_i select
  oper2_o <= data_out_i     when "010",
             operande_i     when "100",
             data_i         when others;

end Behavioral;
