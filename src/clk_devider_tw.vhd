----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Rico Jasper
-- 
-- Create Date: 11/18/2011 01:44:58 PM
-- Design Name: 
-- Module Name: clk_devider_tw - behavioral
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

entity clk_devider_tw is
end clk_devider_tw;

architecture behavioral of clk_devider_tw is
  signal CLK_X1 : STD_LOGIC;
  signal CLK_X2 : STD_LOGIC;
  signal RESET  : STD_LOGIC;
  
  component clk_devider is
    port (
        CLK_X2 : in  STD_LOGIC;
        RESET  : in  STD_LOGIC;
        CLK_X1 : out STD_LOGIC
      );
  end component;
  
begin
  process
  begin
    loop
      CLK_X2 <= '1';
      wait for 30 ns;
      CLK_X2 <= '0';
      wait for 30 ns;
    end loop;
  end process;
  
  process
  begin
    RESET <= '1';
    wait for 15 ns;
    RESET <= '0';
    wait;
  end process;
  
  uut : clk_devider
    port map (
        CLK_X2, RESET, CLK_X1
      );
end behavioral;
