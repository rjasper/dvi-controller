
library ieee;
use ieee.std_logic_1164.all;

entity i2c_serializer is
  generic (
      n : integer := 8
    );
  port (
      WE     : in    std_logic;
      WR     : in    std_logic;
      PDATA  : inout std_logic_vector(0 to n-1);
      SDATA  : inout std_logic;
      CLK    : in    std_logic;
      RESET  : in    std_logic
    );
end entity i2c_serializer;

architecture structure of i2c_serializer is
  signal CLK_INV : std_logic;
  signal DATA : std_logic_vector(0 to n-1);
  signal SEL : std_logic_vector(0 to n-1);
  signal SEL_NEXT : std_logic_vector(0 to n-1);
  signal TMP : std_logic_vector(0 to n-1);
  signal ZEROS : std_logic_vector(0 to n-1) := (others => '0');
begin
  CLK_INV <= not CLK;
  
  process (WE, WR, PDATA) is
  begin
    -- if in write mode and write is enabled
    if WE = '1' and WR = '0' then
      DATA <= PDATA;
    end if;
  end process;

  process (CLK, RESET) is
  begin
    if RESET = '1' then
      SEL(0) <= '1';
      SEL(1 to n-1) <= (others => '0');
    elsif rising_edge(CLK) then
      SEL(0 to n-1) <= SEL_NEXT(0 to n-1);
    end if;
  end process;
  
  process (CLK_INV, RESET) is
  begin
    if RESET = '1' then
      SEL_NEXT(0 to n-1) <= SEL(0 to n-1);
    elsif rising_edge(CLK_INV) then
      SEL_NEXT(0) <= SEL(n-1);
      SEL_NEXT(1 to n-1) <= SEL(0 to n-2);
    end if;
  end process;
  
  f0:
  for i in 0 to n-1 generate
    TMP(i) <= SEL(i) and DATA(i);
  end generate f0;
  
  SDATA <= '0' when TMP = ZEROS else '1';
end architecture structure;
