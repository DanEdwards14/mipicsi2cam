library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.std_logic_ARITH.ALL;
use IEEE.std_logic_UNSIGNED.ALL;

--DANIEL EDWARDS MASTERMINDS BUFF GATES FOR WORLD TO SEE

entity BUFF is
    port (A: in std_logic;
          Y: out std_logic);
    end BUFF; 

    architecture BEHAVIORAL of BUFF is
        begin
            Y <= A;

            end BEHAVIORAL;