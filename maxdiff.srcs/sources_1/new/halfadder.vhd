LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY halfadder IS
    PORT (a, b: IN STD_LOGIC;
          s, c: OUT STD_LOGIC);
END ENTITY halfadder;

ARCHITECTURE Behavioral of halfadder IS
BEGIN
    s <= a XOR b;
    c <= a AND b;
END ARCHITECTURE Behavioral;
