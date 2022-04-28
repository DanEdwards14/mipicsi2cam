-- Version: v11.7 SP2 11.7.2.2

library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;


entity spiSHIFT is

    port( Data     : in    std_logic_vector(7 downto 0);
          Enable   : in    std_logic;
          Shiften  : in    std_logic;
          Shiftin  : in    std_logic;
          Aclr     : in    std_logic;
          Clock    : in    std_logic;
          Shiftout : out   std_logic
        );

end spiSHIFT;

architecture DEF_ARCH of spiSHIFT is 

  component BUFF
    port( A : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component DFN1C1
    port( D   : in    std_logic := 'U';
          CLK : in    std_logic := 'U';
          CLR : in    std_logic := 'U';
          Q   : out   std_logic
        );
  end component;

  component MX2
    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          S : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

    signal \Shiftout\, BUFF_1_Y, BUFF_0_Y, BUFF_3_Y, BUFF_2_Y, 
        DFN1C1_5_Q, DFN1C1_4_Q, DFN1C1_2_Q, DFN1C1_0_Q, 
        DFN1C1_1_Q, DFN1C1_3_Q, DFN1C1_6_Q, MX2_2_Y, MX2_7_Y, 
        MX2_10_Y, MX2_22_Y, MX2_12_Y, MX2_8_Y, MX2_16_Y, MX2_21_Y, 
        MX2_1_Y, MX2_15_Y, MX2_3_Y, MX2_18_Y, MX2_9_Y, MX2_4_Y, 
        MX2_11_Y, MX2_5_Y, MX2_23_Y, MX2_20_Y, MX2_17_Y, MX2_14_Y, 
        MX2_0_Y, MX2_6_Y, MX2_13_Y, MX2_19_Y : std_logic;

begin 

    Shiftout <= \Shiftout\;

    BUFF_3 : BUFF
      port map(A => Shiften, Y => BUFF_3_Y);
    
    DFN1C1_6 : DFN1C1
      port map(D => MX2_1_Y, CLK => Clock, CLR => Aclr, Q => 
        DFN1C1_6_Q);
    
    MX2_19 : MX2
      port map(A => MX2_6_Y, B => MX2_13_Y, S => BUFF_0_Y, Y => 
        MX2_19_Y);
    
    DFN1C1_3 : DFN1C1
      port map(D => MX2_10_Y, CLK => Clock, CLR => Aclr, Q => 
        DFN1C1_3_Q);
    
    MX2_9 : MX2
      port map(A => DFN1C1_4_Q, B => DFN1C1_2_Q, S => BUFF_3_Y, Y
         => MX2_9_Y);
    
    DFN1C1_2 : DFN1C1
      port map(D => MX2_11_Y, CLK => Clock, CLR => Aclr, Q => 
        DFN1C1_2_Q);
    
    BUFF_1 : BUFF
      port map(A => Enable, Y => BUFF_1_Y);
    
    MX2_0 : MX2
      port map(A => MX2_17_Y, B => MX2_14_Y, S => BUFF_1_Y, Y => 
        MX2_0_Y);
    
    MX2_21 : MX2
      port map(A => Data(6), B => Data(6), S => BUFF_2_Y, Y => 
        MX2_21_Y);
    
    DFN1C1_5 : DFN1C1
      port map(D => MX2_20_Y, CLK => Clock, CLR => Aclr, Q => 
        DFN1C1_5_Q);
    
    MX2_11 : MX2
      port map(A => MX2_9_Y, B => MX2_4_Y, S => BUFF_1_Y, Y => 
        MX2_11_Y);
    
    MX2_6 : MX2
      port map(A => DFN1C1_6_Q, B => \Shiftout\, S => BUFF_2_Y, Y
         => MX2_6_Y);
    
    DFN1C1_Shiftout : DFN1C1
      port map(D => MX2_19_Y, CLK => Clock, CLR => Aclr, Q => 
        \Shiftout\);
    
    DFN1C1_1 : DFN1C1
      port map(D => MX2_8_Y, CLK => Clock, CLR => Aclr, Q => 
        DFN1C1_1_Q);
    
    MX2_20 : MX2
      port map(A => MX2_5_Y, B => MX2_23_Y, S => BUFF_1_Y, Y => 
        MX2_20_Y);
    
    MX2_3 : MX2
      port map(A => Data(3), B => Data(3), S => BUFF_3_Y, Y => 
        MX2_3_Y);
    
    MX2_10 : MX2
      port map(A => MX2_2_Y, B => MX2_7_Y, S => BUFF_0_Y, Y => 
        MX2_10_Y);
    
    DFN1C1_0 : DFN1C1
      port map(D => MX2_18_Y, CLK => Clock, CLR => Aclr, Q => 
        DFN1C1_0_Q);
    
    MX2_4 : MX2
      port map(A => Data(2), B => Data(2), S => BUFF_3_Y, Y => 
        MX2_4_Y);
    
    BUFF_2 : BUFF
      port map(A => Shiften, Y => BUFF_2_Y);
    
    BUFF_0 : BUFF
      port map(A => Enable, Y => BUFF_0_Y);
    
    DFN1C1_4 : DFN1C1
      port map(D => MX2_0_Y, CLK => Clock, CLR => Aclr, Q => 
        DFN1C1_4_Q);
    
    MX2_5 : MX2
      port map(A => Shiftin, B => DFN1C1_5_Q, S => BUFF_3_Y, Y
         => MX2_5_Y);
    
    MX2_17 : MX2
      port map(A => DFN1C1_5_Q, B => DFN1C1_4_Q, S => BUFF_3_Y, Y
         => MX2_17_Y);
    
    MX2_15 : MX2
      port map(A => DFN1C1_2_Q, B => DFN1C1_0_Q, S => BUFF_3_Y, Y
         => MX2_15_Y);
    
    MX2_8 : MX2
      port map(A => MX2_22_Y, B => MX2_12_Y, S => BUFF_0_Y, Y => 
        MX2_8_Y);
    
    MX2_16 : MX2
      port map(A => DFN1C1_3_Q, B => DFN1C1_6_Q, S => BUFF_2_Y, Y
         => MX2_16_Y);
    
    MX2_23 : MX2
      port map(A => Data(0), B => Data(0), S => BUFF_3_Y, Y => 
        MX2_23_Y);
    
    MX2_2 : MX2
      port map(A => DFN1C1_1_Q, B => DFN1C1_3_Q, S => BUFF_2_Y, Y
         => MX2_2_Y);
    
    MX2_7 : MX2
      port map(A => Data(5), B => Data(5), S => BUFF_2_Y, Y => 
        MX2_7_Y);
    
    MX2_13 : MX2
      port map(A => Data(7), B => Data(7), S => BUFF_2_Y, Y => 
        MX2_13_Y);
    
    MX2_1 : MX2
      port map(A => MX2_16_Y, B => MX2_21_Y, S => BUFF_0_Y, Y => 
        MX2_1_Y);
    
    MX2_14 : MX2
      port map(A => Data(1), B => Data(1), S => BUFF_3_Y, Y => 
        MX2_14_Y);
    
    MX2_22 : MX2
      port map(A => DFN1C1_0_Q, B => DFN1C1_1_Q, S => BUFF_2_Y, Y
         => MX2_22_Y);
    
    MX2_18 : MX2
      port map(A => MX2_15_Y, B => MX2_3_Y, S => BUFF_1_Y, Y => 
        MX2_18_Y);
    
    MX2_12 : MX2
      port map(A => Data(4), B => Data(4), S => BUFF_2_Y, Y => 
        MX2_12_Y);
    

end DEF_ARCH; 

-- _Disclaimer: Please leave the following comments in the file, they are for internal purposes only._


-- _GEN_File_Contents_

-- Version:11.7.2.2
-- ACTGENU_CALL:1
-- BATCH:T
-- FAM:PA3LCLP
-- OUTFORMAT:VHDL
-- LPMTYPE:LPM_DFF
-- LPM_HINT:PISO
-- INSERT_PAD:NO
-- INSERT_IOREG:NO
-- GEN_BHV_VHDL_VAL:F
-- GEN_BHV_VERILOG_VAL:F
-- MGNTIMER:F
-- MGNCMPL:T
-- DESDIR:C:/Users/Edward/OneDrive/Code/IGLOO_MEM_TEST_V12/IGLOO_FRAMEBUFFER_VHDL/smartgen\spiSHIFT
-- GEN_BEHV_MODULE:F
-- SMARTGEN_DIE:UN2X2DIV3M0LPLV
-- SMARTGEN_PACKAGE:qn68
-- AGENIII_IS_SUBPROJECT_LIBERO:T
-- CLR_POLARITY:1
-- CLR_FANIN:AUTO
-- CLR_VAL:8
-- EN_POLARITY:1
-- EN_FANIN:AUTO
-- EN_VAL:6
-- SHEN_POLARITY:0
-- SHEN_FANIN:AUTO
-- SHEN_VAL:6
-- CLK_EDGE:RISE
-- CLK_FANIN:MANUAL
-- CLK_VAL:1
-- WIDTH:8
-- FF_TYPE:REGULAR

-- _End_Comments_

