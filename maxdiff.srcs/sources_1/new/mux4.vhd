LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY mux4 IS
    GENERIC (width: INTEGER := 8);
    PORT (d0, d1, d2, d3: IN STD_LOGIC_VECTOR (width-1 DOWNTO 0);
          s: IN STD_LOGIC_VECTOR (1 DOWNTO 0);
          y: OUT STD_LOGIC_VECTOR (width-1 DOWNTO 0));
END ENTITY mux4;

ARCHITECTURE Structural OF mux4 IS
    COMPONENT mux2 IS
        GENERIC (width: INTEGER := 8);
        PORT (d0, d1: IN STD_LOGIC_VECTOR (width-1 DOWNTO 0);
          s: IN STD_LOGIC;
          y: OUT STD_LOGIC_VECTOR (width-1 DOWNTO 0));
    END COMPONENT mux2;
    SIGNAL y0, y1: STD_LOGIC_VECTOR (width-1 DOWNTO 0);
BEGIN
    mux2_1: mux2 GENERIC MAP (width)
            PORT MAP (d0 => d0, d1 => d1, s => s(0), y => y0);
    mux2_2: mux2 GENERIC MAP (width)
            PORT MAP (d0 => d2, d1 => d3, s => s(0), y => y1);
    mux2_3: mux2 GENERIC MAP (width)
            PORT MAP (d0 => y0, d1 => y1, s => s(1), y => y);
END ARCHITECTURE Structural;