LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY datapath IS
    PORT (clk: IN STD_LOGIC;
          ALUSrcA, ALUSrcB: IN STD_LOGIC_VECTOR (1 DOWNTO 0);
          ALUOp: IN STD_LOGIC;
          MaxSrc, MinSrc, AddrSrc: IN STD_LOGIC;
          MaxWriteEn, MinWriteEn, AddrWriteEn, ValueWriteEn, ResultWriteEn: IN STD_LOGIC;
          lt: OUT STD_LOGIC;
          Addr, Result: OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
          MemOut: IN STD_LOGIC_VECTOR (7 DOWNTO 0));
END ENTITY datapath;

ARCHITECTURE Structural OF datapath IS
    COMPONENT flipflop IS
        GENERIC (width: INTEGER := 8);
        PORT (clk, en: IN STD_LOGIC;
              d: IN STD_LOGIC_VECTOR (width-1 DOWNTO 0);
              q: OUT STD_LOGIC_VECTOR (width-1 DOWNTO 0));
    END COMPONENT flipflop;
    COMPONENT mux2 IS
        GENERIC (width: INTEGER := 8);
        PORT (d0, d1: IN STD_LOGIC_VECTOR (width-1 DOWNTO 0);
              s: IN STD_LOGIC;
              y: OUT STD_LOGIC_VECTOR (width-1 DOWNTO 0));
    END COMPONENT mux2;
    COMPONENT mux4 IS
        GENERIC (width: INTEGER := 8);
        PORT (d0, d1, d2, d3: IN STD_LOGIC_VECTOR (width-1 DOWNTO 0);
              s: IN STD_LOGIC_VECTOR (1 DOWNTO 0);
              y: OUT STD_LOGIC_VECTOR (width-1 DOWNTO 0));
    END COMPONENT mux4;
    COMPONENT alu IS
        PORT (a, b: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
              ALUOp: IN STD_LOGIC;
              ALUResult: OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
              lt: OUT STD_LOGIC);
    END COMPONENT alu;
    SIGNAL Value, Max, Min, ALUResult: STD_LOGIC_VECTOR (7 DOWNTO 0);
    SIGNAL MaxD, MinD, AddrD: STD_LOGIC_VECTOR (7 DOWNTO 0);
    SIGNAL ALUA, ALUB: STD_LOGIC_VECTOR (7 DOWNTO 0);
BEGIN
    value_ff: flipflop PORT MAP (clk => clk, en => ValueWriteEn, d => MemOut, q => Value);
    min_ff: flipflop PORT MAP (clk => clk, en => MinWriteEn, d => MinD, q => Min);
    max_ff: flipflop PORT MAP (clk => clk, en => MaxWriteEn, d => MaxD, q => Max);
    addr_ff: flipflop PORT MAP (clk => clk, en => AddrWriteEn, d => AddrD, q => Addr);
    result_ff: flipflop PORT MAP (clk => clk, en => ResultWriteEn, d => ALUResult, q => Result);
    alu_i: alu PORT MAP (a => ALUA, b => ALUB, ALUOp => ALUOp, ALUResult => ALUResult, lt => lt);
    max_mux: mux2 PORT MAP (d0 => 8x"80", d1 => Value, s => MaxSrc, y => MaxD);
    min_mux: mux2 PORT MAP (d0 => 8d"127", d1 => Value, s => MinSrc, y => MinD);
    addr_mux: mux2 PORT MAP (d0 => 8d"0", d1 => ALUResult, s => AddrSrc, y => AddrD);
    alua_mux: mux4 PORT MAP (d0 => Addr, d1 => Max, d2 => Value, d3 => Value,
                             s => ALUSrcA, y => ALUA);
    alub_mux: mux4 PORT MAP (d0 => 8d"8", d1 => 8d"1", d2 => Min, d3 => Value,
                             s => ALUSrcB, y => ALUB);
END ARCHITECTURE Structural;