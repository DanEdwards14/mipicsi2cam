library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.std_logic_ARITH.ALL;
use IEEE.std_logic_UNSIGNED.ALL;

--DANIEL EDWARDS MASTERMINDS XOR2 GATES FOR WORLD TO SEE


entity XOR2 is
    port (A,B: in std_logic;
          Y: out std_logic);
    end XOR2; 
    
    architecture BEHAVIORAL of XOR2 is
    begin
      Y <= (A XOR B );
    end BEHAVIORAL;