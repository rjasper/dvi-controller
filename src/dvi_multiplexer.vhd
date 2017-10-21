----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Rico Jasper
-- 
-- Create Date: 11/25/2011 10:45:59 AM
-- Design Name: 
-- Module Name: dvi_multiplexer - structure
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
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity dvi_multiplexer is
  port (
      SEL : in  STD_LOGIC;
      RAW : in  STD_LOGIC_VECTOR(23 downto 0);
      D   : out STD_LOGIC_VECTOR(11 downto 0)
    );
end dvi_multiplexer;

architecture structure of dvi_multiplexer is
  signal RED, GREEN, BLUE : STD_LOGIC_VECTOR(7 downto 0);
  signal SEG_0, SEG_1 : STD_LOGIC_VECTOR(11 downto 0);
  
begin
  RED   <= RAW(23 downto 16);
  GREEN <= RAW(15 downto  8);
  BLUE  <= RAW( 7 downto  0);
  
  SEG_0 <= GREEN(3 downto 0) & BLUE;
  SEG_1 <= RED & GREEN(7 downto 4);
  
  D <= SEG_0 when SEL = '1' else SEG_1;
end structure;
