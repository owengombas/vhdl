----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.05.2021 08:40:28
-- Design Name: 
-- Module Name: programCounter - Behavioral
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
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity programCounter is
    Port(
         Clk_i           : in  std_logic;
         Reset_i         : in  std_logic;
         Pc_inc_i        : in  std_logic;
         Pc_load_i       : in  std_logic;
         Operande_i      : in  std_logic_vector(7 downto 0);
         Pc_o            : out std_logic_vector(7 downto 0)
        );
end programCounter;

architecture Behavioral of programCounter is
    signal Pc : unsigned(7 DOWNTO 0);
begin
process(Clk_i,Reset_i)
begin
  if Reset_i = '1' then
    Pc <= (others => '0');
  elsif rising_edge(Clk_i) then
    if PC_inc_i = '1' then
      Pc <= Pc + 1;
    elsif Pc_load_i = '1' then
      Pc <= unsigned(Operande_i);
    end if;
  end if;
end process;

Pc_o  <= std_logic_vector(Pc);

end Behavioral;
