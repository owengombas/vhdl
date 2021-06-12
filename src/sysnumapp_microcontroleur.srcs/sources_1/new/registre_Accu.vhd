----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.05.2021 08:43:04
-- Design Name: 
-- Module Name: registre_Accu - Behavioral
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

entity registre_Accu is
  Port (
    Clk_i       : in  std_logic;
    Reset_i     : in  std_logic;
    Accu_load_i       : in  std_logic;
    Accu_i   : in  std_logic_vector(7 downto 0);
    Data_out_o   : out  std_logic_vector(7 downto 0)
  );
end registre_Accu;

architecture Behavioral of registre_Accu is

begin


end Behavioral;
