----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.11.2011 15:41:35
-- Design Name: 
-- Module Name: i2c_serializer_tw - Behavioral
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

entity i2c_serializer_tw is
  generic (
      n : integer := 8
    );
end i2c_serializer_tw;

architecture behavioral of i2c_serializer_tw is
  signal WE    : std_logic;
  signal WR    : std_logic;
  signal PDATA : std_logic_vector(0 to n-1);
  signal SDATA : std_logic;
  signal CLK   : std_logic;
  signal RESET : std_logic;
  
  component i2c_serializer
    generic (
        m : integer := n
      );
    port (
        WE     : in    std_logic;
        WR     : in    std_logic;
        PDATA  : inout std_logic_vector(0 to m-1);
        SDATA  : inout std_logic;
        CLK    : in    std_logic;
        RESET  : in    std_logic
      );
  end component;
  
begin
  uut : i2c_serializer
    port map (
        WE, WR, PDATA, SDATA, CLK, RESET
      );
  
end behavioral;
