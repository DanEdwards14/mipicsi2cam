library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.std_logic_ARITH.ALL;
use IEEE.std_logic_UNSIGNED.ALL;

--DANIEL EDWARDS MASTERMINDS NOR3 GATES FOR WORLD TO SEE

entity NOR3 is
    port (A,B,C: in std_logic;
          Y: out std_logic);
    end NOR3; 

    architecture BEHAVIORAL of NOR3 is
        begin
        Y <= NOT (A OR B OR C);

            end BEHAVIORAL;