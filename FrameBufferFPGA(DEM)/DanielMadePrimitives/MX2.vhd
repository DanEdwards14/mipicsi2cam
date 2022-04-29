library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.std_logic_ARITH.ALL;
use IEEE.std_logic_UNSIGNED.ALL;

--DANIEL EDWARDS MASTERMINDS MX2 GATES FOR WORLD TO SEE


entity MX2 is
    port (A,B,S: in std_logic;
          Y: out std_logic);
    end MX2; 

    architecture BEHAVIORAL of MX2 is
        begin
        Y <= (A and not S) or (B and S);
        end BEHAVIORAL;