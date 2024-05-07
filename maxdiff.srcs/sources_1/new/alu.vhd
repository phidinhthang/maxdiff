LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY alu IS
    PORT (a, b: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
          ALUOp: IN STD_LOGIC;
          ALUResult: OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
          lt: OUT STD_LOGIC);
END ENTITY alu;

ARCHITECTURE Structural OF alu IS
    COMPONENT adder8bit IS
        PORT (a, b: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
          cin: IN STD_LOGIC;
          s: OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
          cout: OUT STD_LOGIC);
    END COMPONENT adder8bit;  
    COMPONENT mux2 IS 
        GENERIC (width: INTEGER := 8);
        PORT (d0, d1: IN STD_LOGIC_VECTOR (width-1 DOWNTO 0);
              s: IN STD_LOGIC;
              y: OUT STD_LOGIC_VECTOR (width-1 DOWNTO 0));
    END COMPONENT mux2;
    signal notB, bOrNotB, s: STD_LOGIC_VECTOR (7 DOWNTO 0);
    signal cout, neg, v: STD_LOGIC;
BEGIN
    mux2_i: mux2 GENERIC MAP (8) PORT MAP (d0 => b, d1 => notB, s => ALUOp, y => bOrNotB);
    sum: adder8bit PORT MAP (a => a, b => bOrNotB, cin => ALUOp, s => s, cout => cout); 
    notB <= not B;
    ALUResult <= s;
    neg <= s(7);
    v <= (NOT (a(7) XOR b(7) XOR ALUOp)) AND (a(7) XOR s(7));
    lt <= neg XOR v;
END ARCHITECTURE Structural;
