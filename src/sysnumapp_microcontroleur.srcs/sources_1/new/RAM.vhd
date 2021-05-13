----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.05.2021 15:14:33
-- Design Name: 
-- Module Name: RAM - Behavioral
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


library Work, ieee;
use Work.nanoProcesseur_package.all;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity RAM is
    Port ( clk_i : in STD_LOGIC;
           cs_i : in STD_LOGIC;
           wr_i : in STD_LOGIC;
           operande_i : in STD_LOGIC_VECTOR (7 downto 0);
           data_wr_i : in STD_LOGIC_VECTOR (7 downto 0);
           ram_o : out STD_LOGIC_VECTOR (7 downto 0));
end RAM;

architecture Behavioral of RAM is
  type     blocRAM_type is array(0 to 31) of std_logic_vector(7 DOWNTO 0); 
  signal   blocRAM : blocRAM_type;
  
  signal   addr_reg : std_logic_vector(4 DOWNTO 0);

begin

process(clk_i)
begin
  if rising_edge(clk_i) then
    if cs_i = '1' and wr_i = '1' then
      blocRAM(conv_integer(unsigned(operande_i(4 downto 0)))) <= data_wr_i;
    end if;
    
    addr_reg <= operande_i(4 downto 0);
    
  end if;
end process;

ram_o <= blocRAM(conv_integer(unsigned(operande_i(4 downto 0))));
end Behavioral;
