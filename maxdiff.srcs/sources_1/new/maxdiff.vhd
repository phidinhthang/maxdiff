LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY maxdiff IS
    PORT (clk, start: IN STD_LOGIC;
          MemOut: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
          Addr: OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
          Result: OUT STD_LOGIC_VECTOR (7 DOWNTO 0));
END ENTITY maxdiff;

ARCHITECTURE Structural OF maxdiff IS
    COMPONENT datapath IS
        PORT (clk: IN STD_LOGIC;
              ALUSrcA, ALUSrcB: IN STD_LOGIC_VECTOR (1 DOWNTO 0);
              ALUOp: IN STD_LOGIC;
              MaxSrc, MinSrc, AddrSrc: IN STD_LOGIC;
              MaxWriteEn, MinWriteEn, AddrWriteEn, ValueWriteEn, ResultWriteEn: IN STD_LOGIC;
              lt: OUT STD_LOGIC;
              Addr, Result: OUT STD_LOGIC_VECTOR (7 downto 0);
              MemOut: IN STD_LOGIC_VECTOR (7 downto 0));
    END COMPONENT datapath;
    COMPONENT controller IS
        PORT (clk, start, lt: IN STD_LOGIC;
              ALUSrcA, ALUSrcB: OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
              ALUOp: OUT STD_LOGIC;
              MaxSrc, MinSrc, AddrSrc: OUT STD_LOGIC;
              MaxWriteEn, MinWriteEn, AddrWriteEn, ValueWriteEn, ResultWriteEn: OUT STD_LOGIC);
    END COMPONENT controller;
    
    SIGNAL ALUSrcA, ALUSrcB: STD_LOGIC_VECTOR (1 DOWNTO 0);
    SIGNAL ALUOp: STD_LOGIC;
    SIGNAL MaxSrc, MinSrc, AddrSrc: STD_LOGIC;
    SIGNAL MaxWriteEn, MinWriteEn, AddrWriteEn, ValueWriteEn, ResultWriteEn: STD_LOGIC;
    SIGNAL lt: STD_LOGIC;
BEGIN
    datapath_i: datapath
        PORT MAP (clk => clk, ALUSrcA => ALUSrcA, ALUSrcB => ALUSrcB,
                  ALUOp => ALUOp, MaxSrc => MaxSrc, MinSrc => MinSrc,
                  AddrSrc => AddrSrc, MaxWriteEn => MaxWriteEn,
                  MinWriteEn => MinWriteEn, AddrWriteEn => AddrWriteEn,
                  ValueWriteEn => ValueWriteEn, ResultWriteEn => ResultWriteEn,
                  lt => lt, Addr => Addr, Result => Result, MemOut => MemOut);
    controller_i: controller
        PORT MAP (clk => clk, start => start, lt => lt, ALUSrcA => ALUSrcA,
                  ALUSrcB => ALUSrcB, ALUOp => ALUOp, MaxSrc => MaxSrc,
                  MinSrc => MinSrc, AddrSrc => AddrSrc, MaxWriteEn => MaxWriteEn,
                  MinWriteEn => MinWriteEn, AddrWriteEn => AddrWriteEn,
                  ValueWriteEn => ValueWriteEn, ResultWriteEn => ResultWriteEn);
END ARCHITECTURE Structural;
