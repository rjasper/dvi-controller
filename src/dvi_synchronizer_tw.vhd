----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Rico Jasper
-- 
-- Create Date: 10.11.2011 14:23:06
-- Design Name: 
-- Module Name: dvi_synchronizer_tw - Behavioral
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

entity dvi_synchronizer_tw is
end dvi_synchronizer_tw;

architecture behavioral of dvi_synchronizer_tw is
  signal CLK_X1    : STD_LOGIC;
  signal CLK_X2    : STD_LOGIC;
  signal RESET     : STD_LOGIC;
  signal H         : STD_LOGIC;
  signal V         : STD_LOGIC;
  signal DE        : STD_LOGIC;
  signal SEND_DATA : STD_LOGIC;
  
  constant NUMCYCLES : integer := 1000;
  
  component dvi_synchronizer
    port (
        CLK_X1    : in  STD_LOGIC;
        CLK_X2    : in  STD_LOGIC;
        RESET     : in  STD_LOGIC;
        H         : out STD_LOGIC;
        V         : out STD_LOGIC;
        DE        : out STD_LOGIC;
        SEND_DATA : out STD_LOGIC
      );
  end component;

begin
  
  process
  begin
    for i in 1 to 2*NUMCYCLES loop
      CLK_X2 <= '1';
      wait for 30 ns;
      CLK_X2 <= '0';
      wait for 30 ns;
    end loop;
    
    wait;
  end process;
    
  process
  begin
    for i in 1 to NUMCYCLES loop
      CLK_X1 <= '1';
      wait for 60 ns;
      CLK_X1 <= '0';
      wait for 60 ns;
    end loop;
    
    wait;
  end process;
  
  process
  begin
    RESET <= '1';
    wait for 45 ns;
    RESET <= '0';
    wait;
  end process;

  uut : dvi_synchronizer
    port map (
        CLK_X1, CLK_X2, RESET, H, V, DE, SEND_DATA
      );

end behavioral;
