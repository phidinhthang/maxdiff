LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_TEXTIO.ALL;
USE STD.TEXTIO.ALL;

ENTITY flipflop_tb IS
END flipflop_tb;

ARCHITECTURE sim of flipflop_tb IS
    COMPONENT flipflop IS
        GENERIC (width: INTEGER := 8);
        PORT (clk, en: IN STD_LOGIC;
          d: IN STD_LOGIC_VECTOR (width-1 DOWNTO 0);
          q: OUT STD_LOGIC_VECTOR (width-1 DOWNTO 0));
    END COMPONENT flipflop;
    SIGNAL clk, en: STD_LOGIC;
    SIGNAL d, q: STD_LOGIC_VECTOR (7 DOWNTO 0);
BEGIN
    dut: flipflop GENERIC MAP (8)
        PORT MAP (clk => clk, en => en, d => d, q => q);    

    PROCESS BEGIN
        clk <= '0'; WAIT FOR 5 ns;
        clk <= '1'; WAIT FOR 5 ns;
    END PROCESS;
    
    PROCESS BEGIN
        d <= 8b"01010101";
        en <= '0';
        wait for 10 ns;
        en <= '1';
        wait;
    END PROCESS;
END;
