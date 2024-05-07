LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY fulladder IS
    PORT (a, b, cin: IN STD_LOGIC;
          s, cout: OUT STD_LOGIC);
END ENTITY fulladder;

ARCHITECTURE Structural OF fulladder IS
    COMPONENT halfadder IS
        PORT (a, b: IN STD_LOGIC;
          s, c: OUT STD_LOGIC);
    END COMPONENT halfadder;
    SIGNAL s1, c1, c2: STD_LOGIC;
BEGIN
    hfadder_1: halfadder PORT MAP (a => a, b => b, s => s1, c => c1);
    hfadder_2: halfadder PORT MAP (a => cin, b => s1, s => s, c => c2);
    cout <= c1 OR c2;
END ARCHITECTURE Structural;
