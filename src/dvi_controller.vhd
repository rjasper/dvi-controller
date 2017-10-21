----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Rico Jasper
-- 
-- Create Date: 11/21/2011 02:48:38 PM
-- Design Name: 
-- Module Name: dvi_controller - netlist
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

entity dvi_controller is
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
end dvi_controller;

architecture netlist of dvi_controller is
  -- used for external clock (XCLK) and internal blocks
  signal CLK_X1 : STD_LOGIC;
  signal SEND_DATA_TMP : STD_LOGIC;

  component clk_devider
    port (
        CLK_X2 : in  STD_LOGIC;
        RESET  : in  STD_LOGIC;
        CLK_X1 : out STD_LOGIC
      );
  end component;
  
  component dvi_multiplexer
    port (
        SEL : in  STD_LOGIC;
        RAW : in  STD_LOGIC_VECTOR(23 downto 0);
        D   : out STD_LOGIC_VECTOR(11 downto 0)
      );
  end component;

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
  xclk_generator : clk_devider
    port map (
        CLK_X2 => CLK,
        RESET  => RESET,
        CLK_X1 => CLK_X1
      );
  
  synchronizer : dvi_synchronizer
    port map (
        CLK_X1    => CLK_X1,
        CLK_X2    => CLK,
        RESET     => RESET,
        H         => H,
        V         => V,
        DE        => DE,
        SEND_DATA => SEND_DATA_TMP
      );
  
  multiplexer : dvi_multiplexer
    port map (
        SEL => SEND_DATA_TMP,
        RAW => RAW,
        D   => D
      );
  
  SEND_DATA <= SEND_DATA_TMP;
  
  XCLK <= CLK_X1;
  XCLK_INV <= not CLK_X1;
  
  -- low active reset
  RESET_B <= not RESET;
end netlist;
