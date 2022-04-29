-- Version: v11.7 SP2 11.7.2.2

library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
--library ice;
--use ice.vcomponent_vital.all;

entity compareADDR is

    port( DataA : in    std_logic_vector(19 downto 0);
          DataB : in    std_logic_vector(19 downto 0);
          AEB   : out   std_logic
        );

end compareADDR;

architecture DEF_ARCH of compareADDR is 

  component XNOR2
    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component AND3
    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          C : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component AND2
    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

    signal XNOR2_7_Y, XNOR2_9_Y, XNOR2_13_Y, XNOR2_8_Y, 
        XNOR2_0_Y, XNOR2_16_Y, XNOR2_10_Y, XNOR2_3_Y, XNOR2_2_Y, 
        XNOR2_6_Y, XNOR2_15_Y, XNOR2_18_Y, XNOR2_19_Y, XNOR2_4_Y, 
        XNOR2_1_Y, XNOR2_17_Y, XNOR2_12_Y, XNOR2_5_Y, XNOR2_14_Y, 
        XNOR2_11_Y, AND3_8_Y, AND3_3_Y, AND3_0_Y, AND3_1_Y, 
        AND3_6_Y, AND3_4_Y, AND3_5_Y, AND3_7_Y, AND3_2_Y
         : std_logic;

begin 


    XNOR2_19 : XNOR2
      port map( A => DataA(12), B => DataB(12), Y => XNOR2_19_Y);
    
    AND3_4 : AND3
      port map( A => XNOR2_18_Y, B => XNOR2_19_Y, C => AND3_6_Y, Y
         => AND3_4_Y);
    
    AND3_2 : AND3
      port map( A => XNOR2_8_Y, B => XNOR2_0_Y, C => XNOR2_16_Y, Y
         => AND3_2_Y);
    
    AND3_6 : AND3
      port map(A => XNOR2_4_Y, B => XNOR2_1_Y, C => XNOR2_17_Y, Y
         => AND3_6_Y);
    
    XNOR2_13 : XNOR2
      port map(A => DataA(2), B => DataB(2), Y => XNOR2_13_Y);
    
    XNOR2_3 : XNOR2
      port map(A => DataA(7), B => DataB(7), Y => XNOR2_3_Y);
    
    XNOR2_5 : XNOR2
      port map(A => DataA(17), B => DataB(17), Y => XNOR2_5_Y);
    
    XNOR2_11 : XNOR2
      port map(A => DataA(19), B => DataB(19), Y => XNOR2_11_Y);
    
    XNOR2_18 : XNOR2
      port map(A => DataA(11), B => DataB(11), Y => XNOR2_18_Y);
    
    AND3_0 : AND3
      port map(A => AND3_4_Y, B => AND3_3_Y, C => AND3_5_Y, Y => 
        AND3_0_Y);
    
    XNOR2_14 : XNOR2
      port map(A => DataA(18), B => DataB(18), Y => XNOR2_14_Y);
    
    XNOR2_12 : XNOR2
      port map(A => DataA(16), B => DataB(16), Y => XNOR2_12_Y);
    
    AND3_1 : AND3
      port map(A => XNOR2_12_Y, B => XNOR2_5_Y, C => XNOR2_14_Y, 
        Y => AND3_1_Y);
    
    XNOR2_10 : XNOR2
      port map(A => DataA(6), B => DataB(6), Y => XNOR2_10_Y);
    
    XNOR2_8 : XNOR2
      port map(A => DataA(3), B => DataB(3), Y => XNOR2_8_Y);
    
    XNOR2_4 : XNOR2
      port map(A => DataA(13), B => DataB(13), Y => XNOR2_4_Y);
    
    AND3_5 : AND3
      port map(A => AND3_1_Y, B => XNOR2_6_Y, C => XNOR2_15_Y, Y
         => AND3_5_Y);
    
    XNOR2_9 : XNOR2
      port map(A => DataA(1), B => DataB(1), Y => XNOR2_9_Y);
    
    XNOR2_0 : XNOR2
      port map(A => DataA(4), B => DataB(4), Y => XNOR2_0_Y);
    
    XNOR2_2 : XNOR2
      port map(A => DataA(8), B => DataB(8), Y => XNOR2_2_Y);
    
    XNOR2_17 : XNOR2
      port map(A => DataA(15), B => DataB(15), Y => XNOR2_17_Y);
    
    XNOR2_7 : XNOR2
      port map(A => DataA(0), B => DataB(0), Y => XNOR2_7_Y);
    
    AND3_8 : AND3
      port map(A => XNOR2_7_Y, B => XNOR2_9_Y, C => XNOR2_13_Y, Y
         => AND3_8_Y);
    
    AND2_AEB : AND2
      port map(A => AND3_0_Y, B => XNOR2_11_Y, Y => AEB);
    
    XNOR2_6 : XNOR2
      port map(A => DataA(9), B => DataB(9), Y => XNOR2_6_Y);
    
    XNOR2_1 : XNOR2
      port map(A => DataA(14), B => DataB(14), Y => XNOR2_1_Y);
    
    XNOR2_16 : XNOR2
      port map(A => DataA(5), B => DataB(5), Y => XNOR2_16_Y);
    
    XNOR2_15 : XNOR2
      port map(A => DataA(10), B => DataB(10), Y => XNOR2_15_Y);
    
    AND3_3 : AND3
      port map(A => AND3_7_Y, B => AND3_8_Y, C => AND3_2_Y, Y => 
        AND3_3_Y);
    
    AND3_7 : AND3
      port map(A => XNOR2_10_Y, B => XNOR2_3_Y, C => XNOR2_2_Y, Y
         => AND3_7_Y);
    

end DEF_ARCH; 

-- _Disclaimer: Please leave the following comments in the file, they are for internal purposes only._


-- _GEN_File_Contents_

-- Version:11.7.2.2
-- ACTGENU_CALL:1
-- BATCH:T
-- FAM:PA3LCLP
-- OUTFORMAT:VHDL
-- LPMTYPE:LPM_COMPARE
-- LPM_HINT:EQCOMP
-- INSERT_PAD:NO
-- INSERT_IOREG:NO
-- GEN_BHV_VHDL_VAL:F
-- GEN_BHV_VERILOG_VAL:F
-- MGNTIMER:F
-- MGNCMPL:T
-- DESDIR:C:/Users/Edward/OneDrive/Code/IGLOO_MEM_TEST_V12/IGLOO_FRAMEBUFFER_VHDL/smartgen\compareADDR
-- GEN_BEHV_MODULE:F
-- SMARTGEN_DIE:UN2X2DIV3M0LPLV
-- SMARTGEN_PACKAGE:qn68
-- AGENIII_IS_SUBPROJECT_LIBERO:T
-- WIDTH:20
-- REPRESENTATION:UNSIGNED
-- GEQRHS_POLARITY:1
-- AEB_POLARITY:1

-- _End_Comments_

