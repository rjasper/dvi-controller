----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Rico Jasper
-- 
-- Create Date: 11/18/2011 01:34:35 PM
-- Design Name: 
-- Module Name: clk_devider - structure
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

entity clk_devider is
  port (
      CLK_X2 : in  STD_LOGIC;
      RESET  : in  STD_LOGIC;
      CLK_X1 : out STD_LOGIC
    );
end clk_devider;

architecture structure of clk_devider is
  signal CLK_X1_TMP : STD_LOGIC; 

begin
  process (RESET, CLK_X2)
  begin
    if RESET = '1' then
      CLK_X1_TMP <= '0';
    elsif rising_edge(CLK_X2) then
      CLK_X1_TMP <= not CLK_X1_TMP;
    end if;
  end process;
  
  CLK_X1 <= CLK_X1_TMP;
end structure;
