----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/03/2021 10:35:10 AM
-- Design Name: 
-- Module Name: nanoProcesseur_package - Behavioral
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

package nanoProcesseur_package is

constant STOREaddr: STD_LOGIC_VECTOR(5 downto 0) := "000000";
constant LOADconst: STD_LOGIC_VECTOR(5 downto 0) := "000001";
constant LOADaddr: STD_LOGIC_VECTOR(5 downto 0) := "000010";
constant ANDconst: STD_LOGIC_VECTOR(5 downto 0) := "000011";
constant ANDaddr: STD_LOGIC_VECTOR(5 downto 0) := "000100";
constant ORconst: STD_LOGIC_VECTOR(5 downto 0) := "000101";
constant ORaddr: STD_LOGIC_VECTOR(5 downto 0) := "000110";
constant XORconst: STD_LOGIC_VECTOR(5 downto 0) := "000111";
constant XORaddr: STD_LOGIC_VECTOR(5 downto 0) := "001000";
constant ROLaccu: STD_LOGIC_VECTOR(5 downto 0) := "001001";
constant RORaccu: STD_LOGIC_VECTOR(5 downto 0) := "001001";
constant ADDconst: STD_LOGIC_VECTOR(5 downto 0) := "001010";
constant ADDaddr: STD_LOGIC_VECTOR(5 downto 0) := "001011";
constant ADCconst: STD_LOGIC_VECTOR(5 downto 0) := "001101";
constant ADCaddr: STD_LOGIC_VECTOR(5 downto 0) := "001110";
constant NEGaccu: STD_LOGIC_VECTOR(5 downto 0) := "001111";
constant NEGconst: STD_LOGIC_VECTOR(5 downto 0) := "010000";
constant NEGaddr: STD_LOGIC_VECTOR(5 downto 0) := "010001";
constant INCaccu: STD_LOGIC_VECTOR(5 downto 0) := "010010";
constant INCaddr: STD_LOGIC_VECTOR(5 downto 0) := "010011";
constant DECaccu: STD_LOGIC_VECTOR(5 downto 0) := "010100";
constant DECaddr: STD_LOGIC_VECTOR(5 downto 0) := "010101";
constant SETC: STD_LOGIC_VECTOR(5 downto 0) := "010110";
constant CLRC: STD_LOGIC_VECTOR(5 downto 0) := "010111";
constant TRFNC: STD_LOGIC_VECTOR(5 downto 0) := "011000";
constant BZ0: STD_LOGIC_VECTOR(5 downto 0) := "011001";
constant BZ1: STD_LOGIC_VECTOR(5 downto 0) := "011010";
constant BC0: STD_LOGIC_VECTOR(5 downto 0) := "011011";
constant BC1: STD_LOGIC_VECTOR(5 downto 0) := "011100";
constant BV0: STD_LOGIC_VECTOR(5 downto 0) := "011101";
constant BV1: STD_LOGIC_VECTOR(5 downto 0) := "011110";
constant NB0: STD_LOGIC_VECTOR(5 downto 0) := "011111";
constant BN1: STD_LOGIC_VECTOR(5 downto 0) := "100000";
constant BRA: STD_LOGIC_VECTOR(5 downto 0) := "100001";
constant NOP: STD_LOGIC_VECTOR(5 downto 0) := "100010";

end package nanoProcesseur_package;

package body nanoProcesseur_package is
end package body nanoProcesseur_package;
