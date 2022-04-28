Library IEEE;
USE IEEE.Std_logic_1164.all;
use IEEE.std_logic_ARITH.ALL;
use IEEE.std_logic_UNSIGNED.ALL;

--DANIEL MADE CODE FOR D FLIP FLOP with Active High Clear

entity DFN1C1 is 
   port(
      Q : out std_logic;    
      CLK, CLR, D :in std_logic);
end DFN1C1;
architecture Behavioral of DFN1C1 is  
begin  
 process(CLK)
 begin 
 if(CLR='0') then 

    if(rising_edge(CLK)) then
    Q <= D;
    else 
    Q <= '0'; 
    end if;
    end if;     
 
 end process;  
end Behavioral; 