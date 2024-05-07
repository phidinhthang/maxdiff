LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY controller IS
    PORT (clk, start, lt: IN STD_LOGIC;
          ALUSrcA, ALUSrcB: OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
          ALUOp: OUT STD_LOGIC;
          MaxSrc, MinSrc, AddrSrc: OUT STD_LOGIC;
          MaxWriteEn, MinWriteEn, AddrWriteEn, ValueWriteEn, ResultWriteEn: OUT STD_LOGIC);
END ENTITY controller;

ARCHITECTURE Behavioral OF controller IS
    SIGNAL state: STD_LOGIC_VECTOR (3 DOWNTO 0) := 4d"0";
    SIGNAL nextstate: STD_LOGIC_VECTOR (3 DOWNTO 0) := 4d"0";
BEGIN
    PROCESS (clk) BEGIN
        IF RISING_EDGE (clk) THEN
            IF start = '1' THEN
                state <= 4d"1";
            ELSE
                state <= nextstate;
            END IF;
        END IF;
    END PROCESS;
    
    PROCESS (ALL) BEGIN
            CASE state IS
                WHEN 4d"1" => nextstate <= 4d"2"; 
                WHEN 4d"2" => nextstate <= 4d"3" WHEN lt = '1' ELSE 4d"9";
                WHEN 4d"3" => nextstate <= 4d"4";
                WHEN 4d"4" => nextstate <= 4d"5" WHEN lt = '1' ELSE 4d"6";
                WHEN 4d"5" => nextstate <= 4d"6";
                WHEN 4d"6" => nextstate <= 4d"7" WHEN lt = '1' ELSE 4d"8";
                WHEN 4d"7" => nextstate <= 4d"8";
                WHEN 4d"8" => nextstate <= 4d"2";
                WHEN OTHERS => nextstate <= 4d"0";
            END CASE;
    END PROCESS;
    
    PROCESS (ALL) BEGIN
        CASE state IS
            WHEN 4d"1" =>
                MaxSrc <= '0';
                MinSrc <= '0';
                MaxWriteEn <= '1';
                MinWriteEn <= '1';
                AddrSrc <= '0';
                AddrWriteEn <= '1';
            WHEN 4d"2" =>
                MaxWriteEn <= '0';
                MinWriteEn <= '0';
                AddrWriteEn <= '0';
                ALUSrcA <= "00";
                ALUSrcB <= "00";
                ALUOp <= '1';
            WHEN 4d"3" =>
                ValueWriteEn <= '1';
            WHEN 4d"4" =>
                ValueWriteEn <= '0';
                ALUSrcA <= "10";
                ALUSrcB <= "10";
                ALUOp <= '1';
            WHEN 4d"5" =>
                MinSrc <= '1';
                MinWriteEn <= '1';
            WHEN 4d"6" =>
                MinWriteEn <= '0';
                ALUSrcA <= "01";
                ALUSrcB <= "11";
                ALUOp <= '1';
            WHEN 4d"7" =>
                MaxSrc <= '1';
                MaxWriteEn <= '1';
            WHEN 4d"8" =>
                MinWriteEn <= '0';
                MaxWriteEn <= '0';
                ALUSrcA <= "00";
                ALUSrcB <= "01";
                ALUOp <= '0';
                AddrSrc <= '1';
                AddrWriteEn <= '1';
            WHEN 4d"9" =>
                ALUSrcA <= "01";
                ALUSrcB <= "10";
                ALUOp <= '1';
                ResultWriteEn <= '1';
            WHEN OTHERS =>
                MinWriteEn <= '0';
                MaxWriteEn <= '0';
                ValueWriteEn <= '0';
                ResultWriteEn <= '0';
                AddrWriteEn <= '0';
        END CASE;
    END PROCESS;
END ARCHITECTURE Behavioral;
