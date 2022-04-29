library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.std_logic_ARITH.ALL;
use IEEE.std_logic_UNSIGNED.ALL;

--DANIEL EDWARDS MASTERMINDS AND2 GATES FOR WORLD TO SEE

entity AND2 is
port (A,B: in std_logic;
      Y: out std_logic);
end AND2; 

architecture BEHAVIORAL of AND2 is
begin
  Y <= (A AND B);
end BEHAVIORAL;