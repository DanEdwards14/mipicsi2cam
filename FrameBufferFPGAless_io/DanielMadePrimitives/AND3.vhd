library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.std_logic_ARITH.ALL;
use IEEE.std_logic_UNSIGNED.ALL;

--DANIEL EDWARDS MASTERMINDS AND3 GATES FOR WORLD TO SEE

entity AND3 is
port (A,B,C: in std_logic;
      Y: out std_logic);
end AND3; 

architecture BEHAVIORAL of AND3 is
begin
  Y <= (A AND B AND C);
end BEHAVIORAL;