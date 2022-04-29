-- Version: v11.7 SP2 11.7.2.2

library ieee;
use ieee.std_logic_1164.all;

entity imgSizeMUX is

    port( Data0_port  : in    std_logic;
          Data1_port  : in    std_logic;
          Data2_port  : in    std_logic;
          Data3_port  : in    std_logic;
          Data4_port  : in    std_logic;
          Data5_port  : in    std_logic;
          Data6_port  : in    std_logic;
          Data7_port  : in    std_logic;
          Data8_port  : in    std_logic;
          Data9_port  : in    std_logic;
          Data10_port : in    std_logic;
          Data11_port : in    std_logic;
          Data12_port : in    std_logic;
          Data13_port : in    std_logic;
          Data14_port : in    std_logic;
          Data15_port : in    std_logic;
          Data16_port : in    std_logic;
          Data17_port : in    std_logic;
          Data18_port : in    std_logic;
          Data19_port : in    std_logic;
          Data20_port : in    std_logic;
          Data21_port : in    std_logic;
          Data22_port : in    std_logic;
          Data23_port : in    std_logic;
          Data24_port : in    std_logic;
          Data25_port : in    std_logic;
          Data26_port : in    std_logic;
          Data27_port : in    std_logic;
          Data28_port : in    std_logic;
          Data29_port : in    std_logic;
          Data30_port : in    std_logic;
          Data31_port : in    std_logic;
          Sel0        : in    std_logic;
          Sel1        : in    std_logic;
          Sel2        : in    std_logic;
          Sel3        : in    std_logic;
          Sel4        : in    std_logic;
          Result      : out   std_logic
        );

end imgSizeMUX;

architecture DEF_ARCH of imgSizeMUX is 

  component BUFF
    port( A : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component MX2
    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          S : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

    signal \SelAux_0[0]\, \SelAux_0[6]\, \SelAux_0[11]\, 
        \SelAux_1[0]\, \SelAux_1[4]\, MX2_6_Y, MX2_0_Y, MX2_17_Y, 
        MX2_22_Y, MX2_1_Y, MX2_7_Y, MX2_19_Y, MX2_13_Y, MX2_5_Y, 
        MX2_18_Y, MX2_11_Y, MX2_12_Y, MX2_21_Y, MX2_28_Y, 
        MX2_29_Y, MX2_4_Y, MX2_15_Y, MX2_10_Y, MX2_20_Y, MX2_25_Y, 
        MX2_2_Y, MX2_24_Y, MX2_8_Y, MX2_3_Y, MX2_9_Y, MX2_27_Y, 
        MX2_16_Y, MX2_14_Y, MX2_23_Y, MX2_26_Y : std_logic;

begin 


    \BUFF_SelAux_1[4]\ : BUFF
      port map(A => Sel1, Y => \SelAux_1[4]\);
    
    \BUFF_SelAux_0[6]\ : BUFF
      port map(A => Sel0, Y => \SelAux_0[6]\);
    
    MX2_29 : MX2
      port map(A => Data14_port, B => Data15_port, S => 
        \SelAux_0[6]\, Y => MX2_29_Y);
    
    MX2_19 : MX2
      port map(A => Data6_port, B => Data7_port, S => 
        \SelAux_0[0]\, Y => MX2_19_Y);
    
    MX2_9 : MX2
      port map(A => Data24_port, B => Data25_port, S => 
        \SelAux_0[11]\, Y => MX2_9_Y);
    
    MX2_0 : MX2
      port map(A => Data2_port, B => Data3_port, S => 
        \SelAux_0[0]\, Y => MX2_0_Y);
    
    MX2_21 : MX2
      port map(A => MX2_28_Y, B => MX2_29_Y, S => \SelAux_1[0]\, 
        Y => MX2_21_Y);
    
    \BUFF_SelAux_1[0]\ : BUFF
      port map(A => Sel1, Y => \SelAux_1[0]\);
    
    MX2_11 : MX2
      port map(A => Data10_port, B => Data11_port, S => 
        \SelAux_0[0]\, Y => MX2_11_Y);
    
    MX2_6 : MX2
      port map(A => Data0_port, B => Data1_port, S => 
        \SelAux_0[0]\, Y => MX2_6_Y);
    
    MX2_20 : MX2
      port map(A => MX2_15_Y, B => MX2_10_Y, S => \SelAux_1[4]\, 
        Y => MX2_20_Y);
    
    MX2_3 : MX2
      port map(A => MX2_16_Y, B => MX2_14_Y, S => Sel2, Y => 
        MX2_3_Y);
    
    MX2_10 : MX2
      port map(A => Data18_port, B => Data19_port, S => 
        \SelAux_0[6]\, Y => MX2_10_Y);
    
    MX2_4 : MX2
      port map(A => MX2_2_Y, B => MX2_3_Y, S => Sel3, Y => 
        MX2_4_Y);
    
    \BUFF_SelAux_0[0]\ : BUFF
      port map(A => Sel0, Y => \SelAux_0[0]\);
    
    \BUFF_SelAux_0[11]\ : BUFF
      port map(A => Sel0, Y => \SelAux_0[11]\);
    
    MX2_Result : MX2
      port map(A => MX2_5_Y, B => MX2_4_Y, S => Sel4, Y => Result);
    
    MX2_27 : MX2
      port map(A => Data26_port, B => Data27_port, S => 
        \SelAux_0[11]\, Y => MX2_27_Y);
    
    MX2_25 : MX2
      port map(A => MX2_24_Y, B => MX2_8_Y, S => \SelAux_1[4]\, Y
         => MX2_25_Y);
    
    MX2_5 : MX2
      port map(A => MX2_1_Y, B => MX2_13_Y, S => Sel3, Y => 
        MX2_5_Y);
    
    MX2_26 : MX2
      port map(A => Data30_port, B => Data31_port, S => 
        \SelAux_0[11]\, Y => MX2_26_Y);
    
    MX2_17 : MX2
      port map(A => MX2_6_Y, B => MX2_0_Y, S => \SelAux_1[0]\, Y
         => MX2_17_Y);
    
    MX2_15 : MX2
      port map(A => Data16_port, B => Data17_port, S => 
        \SelAux_0[6]\, Y => MX2_15_Y);
    
    MX2_8 : MX2
      port map(A => Data22_port, B => Data23_port, S => 
        \SelAux_0[11]\, Y => MX2_8_Y);
    
    MX2_16 : MX2
      port map(A => MX2_9_Y, B => MX2_27_Y, S => \SelAux_1[4]\, Y
         => MX2_16_Y);
    
    MX2_23 : MX2
      port map(A => Data28_port, B => Data29_port, S => 
        \SelAux_0[11]\, Y => MX2_23_Y);
    
    MX2_2 : MX2
      port map(A => MX2_20_Y, B => MX2_25_Y, S => Sel2, Y => 
        MX2_2_Y);
    
    MX2_24 : MX2
      port map(A => Data20_port, B => Data21_port, S => 
        \SelAux_0[6]\, Y => MX2_24_Y);
    
    MX2_7 : MX2
      port map(A => Data4_port, B => Data5_port, S => 
        \SelAux_0[0]\, Y => MX2_7_Y);
    
    MX2_13 : MX2
      port map(A => MX2_12_Y, B => MX2_21_Y, S => Sel2, Y => 
        MX2_13_Y);
    
    MX2_1 : MX2
      port map(A => MX2_17_Y, B => MX2_22_Y, S => Sel2, Y => 
        MX2_1_Y);
    
    MX2_14 : MX2
      port map(A => MX2_23_Y, B => MX2_26_Y, S => \SelAux_1[4]\, 
        Y => MX2_14_Y);
    
    MX2_28 : MX2
      port map(A => Data12_port, B => Data13_port, S => 
        \SelAux_0[6]\, Y => MX2_28_Y);
    
    MX2_22 : MX2
      port map(A => MX2_7_Y, B => MX2_19_Y, S => \SelAux_1[0]\, Y
         => MX2_22_Y);
    
    MX2_18 : MX2
      port map(A => Data8_port, B => Data9_port, S => 
        \SelAux_0[0]\, Y => MX2_18_Y);
    
    MX2_12 : MX2
      port map(A => MX2_18_Y, B => MX2_11_Y, S => \SelAux_1[0]\, 
        Y => MX2_12_Y);
    

end DEF_ARCH; 

-- _Disclaimer: Please leave the following comments in the file, they are for internal purposes only._


-- _GEN_File_Contents_

-- Version:11.7.2.2
-- ACTGENU_CALL:1
-- BATCH:T
-- FAM:PA3LCLP
-- OUTFORMAT:VHDL
-- LPMTYPE:LPM_MUX
-- LPM_HINT:None
-- INSERT_PAD:NO
-- INSERT_IOREG:NO
-- GEN_BHV_VHDL_VAL:F
-- GEN_BHV_VERILOG_VAL:F
-- MGNTIMER:F
-- MGNCMPL:T
-- DESDIR:F:/Box Sync/AIM project/2017-01 AIM2.0 FPGA design files/IGLOO_FRAMEBUFFER_VHDL_V19/smartgen\imgSizeMUX
-- GEN_BEHV_MODULE:F
-- SMARTGEN_DIE:UN2X2DIV3M0LPLV
-- SMARTGEN_PACKAGE:qn68
-- AGENIII_IS_SUBPROJECT_LIBERO:T
-- WIDTH:1
-- SIZE:32
-- SEL0_FANIN:AUTO
-- SEL0_VAL:6
-- SEL0_POLARITY:1
-- SEL1_FANIN:AUTO
-- SEL1_VAL:6
-- SEL1_POLARITY:2
-- SEL2_FANIN:AUTO
-- SEL2_VAL:6
-- SEL2_POLARITY:2
-- SEL3_FANIN:AUTO
-- SEL3_VAL:6
-- SEL3_POLARITY:2
-- SEL4_FANIN:AUTO
-- SEL4_VAL:6
-- SEL4_POLARITY:2

-- _End_Comments_

