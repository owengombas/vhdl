----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/04/2021 05:44:32 PM
-- Design Name: 
-- Module Name: decodeur_DAdresses - Behavioral
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

entity decodeur_DAdresses is
    Port ( a_i          : in STD_LOGIC_VECTOR (7 downto 0);
           b_i          : in STD_LOGIC_VECTOR (7 downto 0);
           pc_i         : in STD_LOGIC_VECTOR (7 downto 0);
           enable_p_o   : out STD_LOGIC;
           enable_s_o   : out STD_LOGIC;
           enable_r_o   : out STD_LOGIC;
           a_o          : out STD_LOGIC_VECTOR (7 downto 0);
           b_o          : out STD_LOGIC_VECTOR (7 downto 0));
end decodeur_DAdresses;

architecture Behavioral of decodeur_DAdresses is

begin
    -- Tout les registre (entrées et sorties)
    -- enable_p_o <= '1' when pc_i(7 downto 4) = X"F" else '0';
    
    -- Entrees
    enable_p_o <= '1' when pc_i(7 downto 2) = "111100" else '0';
    
    -- Sorties
    enable_s_o <= '1' when pc_i(7 downto 2) = "111101" else '0';
    
    -- RAM
    enable_r_o <= '1' when pc_i(7 downto 5) = "000" else '0';
end Behavioral;
