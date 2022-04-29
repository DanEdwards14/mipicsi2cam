library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.std_logic_ARITH.ALL;
use IEEE.std_logic_UNSIGNED.ALL;

--DANIEL EDWARDS MASTERMINDS OR3 GATES FOR WORLD TO SEE

entity OR3 is
    port (A,B,C: in std_logic;
          Y: out std_logic);
    end OR3; 

    architecture BEHAVIORAL of OR3 is
        begin
        Y <= (A OR B OR C);

            end BEHAVIORAL;