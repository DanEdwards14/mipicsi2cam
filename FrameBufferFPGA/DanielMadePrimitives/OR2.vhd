library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.std_logic_ARITH.ALL;
use IEEE.std_logic_UNSIGNED.ALL;

--DANIEL EDWARDS MASTERMINDS OR2 GATES FOR WORLD TO SEE

entity OR2 is
    port (A,B: in std_logic;
          Y: out std_logic);
    end OR2; 

    architecture BEHAVIORAL of OR2 is
        begin
        Y <= (A OR B);

            end BEHAVIORAL;