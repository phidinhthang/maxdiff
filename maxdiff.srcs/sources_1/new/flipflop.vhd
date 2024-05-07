LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY flipflop IS
    GENERIC (width: INTEGER := 8);
    PORT (clk, en: IN STD_LOGIC;
          d: IN STD_LOGIC_VECTOR (width-1 DOWNTO 0);
          q: OUT STD_LOGIC_VECTOR (width-1 DOWNTO 0));
END ENTITY flipflop;

ARCHITECTURE Behavioral OF flipflop is
BEGIN
    PROCESS (clk) IS
    BEGIN
       IF RISING_EDGE (CLK) THEN
            IF EN = '1' THEN
                q <= d;
            END IF;
       END IF; 
    END PROCESS;
END ARCHITECTURE Behavioral;