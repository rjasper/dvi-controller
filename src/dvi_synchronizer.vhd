----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Rico Jasper
-- 
-- Create Date: 10.11.2011 13:09:03
-- Design Name: 
-- Module Name: dvi_synchronizer - structure
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
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity dvi_synchronizer is
  port (
      CLK_X1    : in  STD_LOGIC;
      CLK_X2    : in  STD_LOGIC;
      RESET     : in  STD_LOGIC;
      H         : out STD_LOGIC;
      V         : out STD_LOGIC;
      DE        : out STD_LOGIC;
      SEND_DATA : out STD_LOGIC
    );
end dvi_synchronizer;

architecture structure of dvi_synchronizer is
  signal COLUMN : STD_LOGIC_VECTOR(11 downto 0); -- MAX = 2 * 2048 - 1
  signal ROW    : STD_LOGIC_VECTOR(10 downto 0); -- MAX = 1 * 2048 - 1
  
  signal H_TMP  : STD_LOGIC;
  signal DE_TMP : STD_LOGIC;
  
  signal SEND_DATA_TMP : STD_LOGIC;
  signal SEND_DATA_FRAME : STD_LOGIC;
  
  constant WIDTH  : INTEGER := 2 * 10;
  constant HEIGHT : INTEGER := 1 *  8;

  constant THP : INTEGER := 2 *  2;
  constant THB : INTEGER := 2 *  1;
  constant THF : INTEGER := 2 *  1;
  constant TVP : INTEGER := 1 *  2;
  constant TVB : INTEGER := 1 *  1;
  constant TVF : INTEGER := 1 *  1;
  
--  constant WIDTH  : INTEGER := 2 * 640;
--  constant HEIGHT : INTEGER := 1 * 480;
--
--  constant THP : INTEGER := 2 * 96;
--  constant THB : INTEGER := 2 * 48;
--  constant THF : INTEGER := 2 * 16;
--  constant TVP : INTEGER := 1 *  2;
--  constant TVB : INTEGER := 1 * 31;
--  constant TVF : INTEGER := 1 * 12;
  
  constant TH  : INTEGER := THP + THB + WIDTH  + THF;
  constant TV  : INTEGER := TVP + TVB + HEIGHT + TVF;
  
begin

  -- column counter
  process (RESET, CLK_X1, CLK_X2) is
  begin
    if RESET = '1' then
      COLUMN(11 downto 1) <= (others => '1');
      COLUMN(0) <= '0'; -- H should be active when CLK_X1 is low and CLK_X2 is falling
    elsif rising_edge(CLK_X2) then
      if COLUMN = std_logic_vector(to_unsigned(TH-1, COLUMN'length)) then
        COLUMN <= (others => '0');
      else
        COLUMN <= COLUMN + 1;
      end if;
    end if;
  end process;
  
  -- row counter
  process (RESET, H_TMP)
  begin
    if RESET = '1' then
      ROW <= (others => '1');
    elsif rising_edge(H_TMP) then
      if ROW = std_logic_vector(to_unsigned(TV-1, ROW'length)) then
        ROW <= (others => '0');
      else
        ROW <= ROW + 1;
      end if;
    end if;
  end process;
  
  -- synchronized setting of V, H_TMP, DE and SEND_DATA_FRAME
  process (CLK_X2, COLUMN, ROW) is
  begin
    if reset = '1' then
      H_TMP  <= '1'; -- inactive
      V      <= '1'; -- inactive
      DE_TMP <= '0'; -- inactive
      SEND_DATA_FRAME <= '0'; -- inactive
    elsif falling_edge(CLK_X2) then
      -- H_TMP signal
      -- H_TMP <= '0' when COLUMN < std_logic_vector(to_unsigned( THP , COLUMN'length)) else '1';
      if COLUMN = std_logic_vector(to_unsigned( 0 , COLUMN'length)) then
        H_TMP <= '0'; -- low active
      elsif COLUMN = std_logic_vector(to_unsigned( THP , COLUMN'length)) then
        H_TMP <= '1'; -- inactive
      end if;
      
      -- V signal
      -- V <= '0' when ROW < std_logic_vector(to_unsigned( TVP , ROW'length)) else '1';
      if ROW = std_logic_vector(to_unsigned( 0 , ROW'length)) then
        V <= '0'; -- low active
      elsif ROW = std_logic_vector(to_unsigned( TVP , ROW'length)) then
        V <= '1'; -- inactive
      end if;
      
      -- DE signal and SEND_DATA_FRAME
      if 
          COLUMN =  std_logic_vector(to_unsigned( THP + THB , COLUMN'length)) and
          ROW    >= std_logic_vector(to_unsigned( TVP + TVB , ROW'length))    and
          ROW    <  std_logic_vector(to_unsigned( TV  - TVF , ROW'length))    then
        DE_TMP <= '1'; -- high active
        SEND_DATA_FRAME <= '1'; -- high active
      else
        if COLUMN = std_logic_vector(to_unsigned( TH - THF , COLUMN'length)) then
          DE_TMP <= '0'; -- inactive
        elsif COLUMN = std_logic_vector(to_unsigned( TH - THF - 1 , COLUMN'length)) then
          SEND_DATA_FRAME <= '0'; -- inactive
        end if;
      end if;
    end if;
  end process;
  
  H  <= H_TMP;
  DE <= DE_TMP;
  
  -- SEND_DATA_TMP signal
  process (RESET, CLK_X2, CLK_X1)
  begin
    if RESET = '1' then
      SEND_DATA_TMP <= '0';
    elsif falling_edge(CLK_X2) then
      SEND_DATA_TMP <= not CLK_X1;
    end if;
  end process;
  
  SEND_DATA <= SEND_DATA_FRAME and SEND_DATA_TMP;
end structure;
