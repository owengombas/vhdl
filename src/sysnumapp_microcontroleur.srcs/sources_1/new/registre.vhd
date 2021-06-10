----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/04/2021 02:59:28 PM
-- Design Name: 
-- Module Name: registre - Behavioral
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

entity registre is
    Port(
         input_value    : in STD_LOGIC_VECTOR (7 downto 0);
         enable_p_i     : in  std_logic;
         clk_i          : in  std_logic;
         reset_i        : in  std_logic;
         output_value   : out STD_LOGIC_VECTOR (7 downto 0)
     );
end registre;

architecture Behavioral of registre is
    signal reg: STD_LOGIC_VECTOR (7 downto 0);
begin

process(clk_i,reset_i)
begin
    if reset_i = '1' then
        reg    <= (others=>'0');
    elsif rising_edge(clk_i) then
        if enable_p_i = '1' then
            reg <= input_value;
        end if;
    end if;
end process;

output_value <= reg;
 
end Behavioral;
