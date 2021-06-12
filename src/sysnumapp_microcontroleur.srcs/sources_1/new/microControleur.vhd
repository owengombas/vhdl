----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/12/2021 02:39:43 PM
-- Design Name: 
-- Module Name: microControleur - Behavioral
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

entity microControleur is
--  Port ( );
end microControleur;

architecture Behavioral of microControleur is
    component RAM is
        Port ( clk_i : in STD_LOGIC;
               cs_i : in STD_LOGIC;
               wr_i : in STD_LOGIC;
               operande_i : in STD_LOGIC_VECTOR (7 downto 0);
               data_wr_i : in STD_LOGIC_VECTOR (7 downto 0);
               ram_o : out STD_LOGIC_VECTOR (7 downto 0));
    end component RAM;
    
    component decodeur_DAdresses is
        Port ( a_i          : in STD_LOGIC_VECTOR (7 downto 0);
               b_i          : in STD_LOGIC_VECTOR (7 downto 0);
               pc_i         : in STD_LOGIC_VECTOR (7 downto 0);
               enable_p_o   : out STD_LOGIC;
               enable_s_o   : out STD_LOGIC;
               enable_r_o   : out STD_LOGIC;
               a_o          : out STD_LOGIC_VECTOR (7 downto 0);
               b_o          : out STD_LOGIC_VECTOR (7 downto 0));
    end component decodeur_DAdresses;
    
    component ROM is
        Port ( pc_i : in STD_LOGIC_VECTOR (7 downto 0);
               ir_o : out STD_LOGIC_VECTOR (11 downto 0));
    end component ROM;
    
    component registre is
        Port(
             input_value    : in STD_LOGIC_VECTOR (7 downto 0);
             enable_p_i     : in  std_logic;
             clk_i          : in  std_logic;
             reset_i        : in  std_logic;
             output_value   : out STD_LOGIC_VECTOR (7 downto 0)
         );
    end component registre;
    
    component multiplexeur is
        Port (
            ram_i       : in  std_logic_vector(7 downto 0);
            a_i         : in  std_logic_vector(7 downto 0);
            b_i         : in  std_logic_vector(7 downto 0);
            operande_i  : in  std_logic_vector(7 downto 0);
            data_o      : out std_logic_vector(7 downto 0)
        );
    end component multiplexeur;
begin


end Behavioral;
