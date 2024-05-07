LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY maxdiff_tb IS

END maxdiff_tb;

ARCHITECTURE Sim OF maxdiff_tb IS
    COMPONENT maxdiff IS
        PORT (clk, start: IN STD_LOGIC;
              MemOut: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
              Addr: OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
              Result: OUT STD_LOGIC_VECTOR (7 DOWNTO 0));
    END COMPONENT maxdiff;
    SIGNAL clk: STD_LOGIC;
    SIGNAL start: STD_LOGIC;
    SIGNAL Addr, MemOut, Result: STD_LOGIC_VECTOR (7 DOWNTO 0);
    TYPE RamArray IS ARRAY (0 to 255) OF STD_LOGIC_VECTOR (7 DOWNTO 0);
    SIGNAL RAM: RamArray := (
       8d"5",8d"176",8d"4",8d"3",-- 0x00: 
       8d"4",8d"4",8d"10",8d"6",-- 0x04: 
       x"00",x"00",x"00",x"00",-- 0x08: 
       x"00",x"00",x"00",x"00",-- 0x0C: 
       x"00",x"00",x"00",x"00",-- 0x10: 
       x"00",x"00",x"00",x"00",-- 0x14: 
       x"00",x"00",x"00",x"00",-- 0x18: 
       x"00",x"00",x"00",x"00",-- 0x1C: 
       x"00",x"00",x"00",x"00",-- 0x20: 
       x"00",x"00",x"00",x"00",-- 0x24: 
       x"00",x"00",x"00",x"00",-- 0x28: 
       x"00",x"00",x"00",x"00",-- 0x2C: 
       x"00",x"00",x"00",x"00",-- 0x30: 
       x"00",x"00",x"00",x"00",-- 0x34: 
       x"00",x"00",x"00",x"00",-- 0x38: 
       x"00",x"00",x"00",x"00",-- 0x3C: 
       x"00",x"00",x"00",x"00",-- 0x40: 
       x"00",x"00",x"00",x"00",-- 0x44: 
       x"00",x"00",x"00",x"00",-- 0x48: 
       x"00",x"00",x"00",x"00",-- 0x4C: 
       x"00",x"00",x"00",x"00",-- 0x50: 
       x"00",x"00",x"00",x"00",-- 0x54: 
       x"00",x"00",x"00",x"00",-- 0x58: 
       x"00",x"00",x"00",x"00",-- 0x5C: 
       x"00",x"00",x"00",x"00",
       x"00",x"00",x"00",x"00",
       x"00",x"00",x"00",x"00",
       x"00",x"00",x"00",x"00",
       x"00",x"00",x"00",x"00",
       x"00",x"00",x"00",x"00",
       x"00",x"00",x"00",x"00",
       x"00",x"00",x"00",x"00",
       x"55",x"66",x"77",x"67",-- 0x00: 
       x"99",x"22",x"00",x"11",-- 0x04: 
       x"00",x"00",x"00",x"00",-- 0x08: 
       x"00",x"00",x"00",x"00",-- 0x0C: 
       x"00",x"00",x"00",x"00",-- 0x10: 
       x"00",x"00",x"00",x"00",-- 0x14: 
       x"00",x"00",x"00",x"00",-- 0x18: 
       x"00",x"00",x"00",x"00",-- 0x1C: 
       x"00",x"00",x"00",x"00",-- 0x20: 
       x"00",x"00",x"00",x"00",-- 0x24: 
       x"00",x"00",x"00",x"00",-- 0x28: 
       x"00",x"00",x"00",x"00",-- 0x2C: 
       x"00",x"00",x"00",x"00",-- 0x30: 
       x"00",x"00",x"00",x"00",-- 0x34: 
       x"00",x"00",x"00",x"00",-- 0x38: 
       x"00",x"00",x"00",x"00",-- 0x3C: 
       x"00",x"00",x"00",x"00",-- 0x40: 
       x"00",x"00",x"00",x"00",-- 0x44: 
       x"00",x"00",x"00",x"00",-- 0x48: 
       x"00",x"00",x"00",x"00",-- 0x4C: 
       x"00",x"00",x"00",x"00",-- 0x50: 
       x"00",x"00",x"00",x"00",-- 0x54: 
       x"00",x"00",x"00",x"00",-- 0x58: 
       x"00",x"00",x"00",x"00",-- 0x5C: 
       x"00",x"00",x"00",x"00",
       x"00",x"00",x"00",x"00",
       x"00",x"00",x"00",x"00",
       x"00",x"00",x"00",x"00",
       x"00",x"00",x"00",x"00",
       x"00",x"00",x"00",x"00",
       x"00",x"00",x"00",x"00",
       x"00",x"00",x"00",x"00"
     );
BEGIN
    dut: maxdiff
        PORT MAP (clk => clk, start => start,
                  MemOut => MemOut, Addr => Addr, Result => Result);
    PROCESS BEGIN
        clk <= '0'; WAIT FOR 5 NS;
        clk <= '1'; WAIT FOR 5 NS;
    END PROCESS;

    MemOut <= RAM(TO_INTEGER(UNSIGNED(Addr)));
    
    PROCESS BEGIN
        start <= '0';
        WAIT FOR 20 ns;
        start <= '1';
        WAIT FOR 10 ns;
        start <= '0';
        WAIT;
    END PROCESS;
END Sim;
