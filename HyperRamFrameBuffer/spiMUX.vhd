-- Version: v11.7 SP2 11.7.2.2

library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity spiMUX is

    port( Data0_port : in    std_logic;
          Data1_port : in    std_logic;
          Sel0       : in    std_logic;
          Result     : out   std_logic
        );

end spiMUX;

architecture DEF_ARCH of spiMUX is 

  component MX2
    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          S : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;


begin 


    MX2_Result : MX2
      port map(A => Data0_port, B => Data1_port, S => Sel0, Y => 
        Result);
    

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
-- DESDIR:F:/Box Sync/AIM project/2017-01 AIM2.0 FPGA design files/IGLOO_FRAMEBUFFER_VHDL_V19/smartgen\spiMUX
-- GEN_BEHV_MODULE:F
-- SMARTGEN_DIE:UN2X2DIV3M0LPLV
-- SMARTGEN_PACKAGE:qn68
-- AGENIII_IS_SUBPROJECT_LIBERO:T
-- WIDTH:1
-- SIZE:2
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

