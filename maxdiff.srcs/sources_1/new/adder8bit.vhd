LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY adder8bit IS
    PORT (a, b: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
          cin: IN STD_LOGIC;
          s: OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
          cout: OUT STD_LOGIC);
END ENTITY adder8bit;

ARCHITECTURE Structural OF adder8bit IS
    COMPONENT fulladder IS
        PORT (a, b, cin: IN STD_LOGIC;
               s, cout: OUT STD_LOGIC);
    END COMPONENT fulladder;
    SIGNAL co: STD_LOGIC_VECTOR(6 DOWNTO 0);
BEGIN
    fa0: fulladder PORT MAP (a => a(0), b => b(0), cin => cin, s => s(0), cout => co(0));
    fa1: fulladder PORT MAP (a => a(1), b => b(1), cin => co(0), s => s(1), cout => co(1));
    fa2: fulladder PORT MAP (a => a(2), b => b(2), cin => co(1), s => s(2), cout => co(2));
    fa3: fulladder PORT MAP (a => a(3), b => b(3), cin => co(2), s => s(3), cout => co(3));
    fa4: fulladder PORT MAP (a => a(4), b => b(4), cin => co(3), s => s(4), cout => co(4));
    fa5: fulladder PORT MAP (a => a(5), b => b(5), cin => co(4), s => s(5), cout => co(5));
    fa6: fulladder PORT MAP (a => a(6), b => b(6), cin => co(5), s => s(6), cout => co(6));
    fa7: fulladder PORT MAP (a => a(7), b => b(7), cin => co(6), s => s(7), cout => cout);
END Structural;
