----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.05.2021 15:44:08
-- Design Name: 
-- Module Name: ROM - Behavioral
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
use IEEE.std_logic_arith.ALL;
use work.nanoProcesseur_package.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ROM is
    Port ( pc_i : in STD_LOGIC_VECTOR (7 downto 0);
           ir_o : out STD_LOGIC_VECTOR (11 downto 0));
end ROM; 
 
architecture Behavioral of ROM is

begin

    with pc_i select
      ir_o <= -- Création d'un petit programme en Assembleur-like 
             LOADaddr 	& X"100" when	X"00",
             STOREaddr 	& X"101" when	X"01",
             BRA 	    & X"000" when	X"02",
             BRA 	    & X"1FF" when	others;
    
end Behavioral;
