library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.std_logic_ARITH.ALL;
use IEEE.std_logic_UNSIGNED.ALL;

--DANIEL EDWARDS MASTERMINDS INV GATES FOR WORLD TO SEE

entity INV is
port (A: in std_logic;
      Y: out std_logic);
end INV; 

architecture BEHAVIORAL of INV is
begin
  Y <= NOT A;
end BEHAVIORAL;