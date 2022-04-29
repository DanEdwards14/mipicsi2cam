library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.std_logic_ARITH.ALL;
use IEEE.std_logic_UNSIGNED.ALL;

--DANIEL EDWARDS MASTERMINDS XNOR2 GATES FOR WORLD TO SEE

entity XNOR2 is
    port (A,B: in std_logic;
          Y: out std_logic);
    end XNOR2; 

    architecture BEHAVIORAL of XNOR2 is
        begin
        Y <= (A and B) or (not(A) and not(B));

            end BEHAVIORAL;