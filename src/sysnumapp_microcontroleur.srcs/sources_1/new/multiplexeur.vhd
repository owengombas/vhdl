----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.05.2021 08:40:50
-- Design Name: 
-- Module Name: multiplexeur - Behavioral
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

entity multiplexeur is
Port (
    ram_i       : in  std_logic_vector(7 downto 0);
    a_i         : in  std_logic_vector(7 downto 0);
    b_i         : in  std_logic_vector(7 downto 0);
    operande_i  : in  std_logic_vector(7 downto 0);
    data_o      : out std_logic_vector(7 downto 0)
);
end multiplexeur;

architecture Behavioral of multiplexeur is

begin

with operande_i select
  data_o <=
         a_i            when	X"F0",
         b_i            when	X"F1",
         ram_i          when	X"00",
         "00000000"     when	others;

end Behavioral;
