library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.std_logic_ARITH.ALL;
use IEEE.std_logic_UNSIGNED.ALL;

--DANIEL EDWARDS MASTERMINDS XNOR2 GATES FOR WORLD TO SEE

entity BIBUF is
port (PAD : inout std_logic;
E, D: in std_logic;
Y : out std_logic);
end BIBUF;
architecture BEHAVIORAL of BIBUF is
begin
process (E, D)
begin
case E is
when '1' => PAD <= D;
when '0' => PAD <= 'Z';
when others => PAD <= 'X';
end case;
end process;
Y <= PAD;
end BEHAVIORAL;