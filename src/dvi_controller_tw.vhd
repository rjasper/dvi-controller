----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Rico Jasper
-- 
-- Create Date: 11/21/2011 03:14:01 PM
-- Design Name: 
-- Module Name: dvi_controller_tw - behavioral
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

entity dvi_controller_tw is
end dvi_controller_tw;

architecture behavioral of dvi_controller_tw is
  signal CLK       : STD_LOGIC;
  signal RESET     : STD_LOGIC;
  signal RAW       : STD_LOGIC_VECTOR(23 downto 0);
  signal SEND_DATA : STD_LOGIC;
  signal XCLK      : STD_LOGIC;
  signal XCLK_INV  : STD_LOGIC;
  signal RESET_B   : STD_LOGIC;
  signal H         : STD_LOGIC;
  signal V         : STD_LOGIC;
  signal DE        : STD_LOGIC;
  signal D         : STD_LOGIC_VECTOR(11 downto 0);
  
  component dvi_controller
    port (
        CLK       : in  STD_LOGIC;
        RESET     : in  STD_LOGIC;
        RAW       : in  STD_LOGIC_VECTOR(23 downto 0);
        SEND_DATA : out STD_LOGIC;
        XCLK      : out STD_LOGIC;
        XCLK_INV  : out STD_LOGIC;
        RESET_B   : out STD_LOGIC;
        H         : out STD_LOGIC;
        V         : out STD_LOGIC;
        DE        : out STD_LOGIC;
        D         : out STD_LOGIC_VECTOR(11 downto 0)
      );
  end component;

begin
  RAW <= "111111111111000000000000";
  
  process
  begin
    loop
      CLK <= '1';
      wait for 15 ns;
      CLK <= '0';
      wait for 15 ns;
    end loop;
  end process;
      
  process
  begin
    RESET <= '1';
    wait for 10 ns;
    RESET <= '0';
    wait;
  end process;

  uut : dvi_controller
    port map (
        CLK, RESET, RAW, SEND_DATA, XCLK, XCLK_INV, RESET_B, H, V, DE, D
      );
end behavioral;
