----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Rico Jasper
-- 
-- Create Date: 11/25/2011 11:05:21 AM
-- Design Name: 
-- Module Name: dvi_multiplexer_tw - behavioral
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

entity dvi_multiplexer_tw is
end dvi_multiplexer_tw;

architecture behavioral of dvi_multiplexer_tw is
  signal SEL : STD_LOGIC;
  signal RAW : STD_LOGIC_VECTOR(23 downto 0);
  signal D   : STD_LOGIC_VECTOR(11 downto 0);
  
  component dvi_multiplexer
    port (
        SEL : in  STD_LOGIC;
        RAW : in  STD_LOGIC_VECTOR(23 downto 0);
        D   : out STD_LOGIC_VECTOR(11 downto 0)
      );
  end component;

begin
  RAW <= "111111111111000000000000";
  
  process
  begin
    SEL <= '0';
    wait for 15 ns;
    SEL <= '1';
    wait;
  end process;

  uut : dvi_multiplexer
    port map (
        SEL, RAW, D
      );
end behavioral;
