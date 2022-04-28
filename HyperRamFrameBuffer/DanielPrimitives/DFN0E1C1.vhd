Library IEEE;
USE IEEE.Std_logic_1164.all;
use IEEE.std_logic_ARITH.ALL;
use IEEE.std_logic_UNSIGNED.ALL;

entity DFN01E1C1 is 
   port(
      Q : out std_logic;    
      CLK, E, CLR, D :in std_logic);
end DFN01E1C1;
architecture Behavioral of DFN01E1C1 is  
begin  
 process(CLK)
 begin 
 if(CLR='0') then 

    if(E = '1') then
    if(falling_edge(CLK)) then
    Q <= D;
    end if;
    end if;

    else 
    Q <= '0'; 
    end if;     
 
 end process;  
end Behavioral; 