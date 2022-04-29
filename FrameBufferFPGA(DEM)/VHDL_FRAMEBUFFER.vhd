----------------------------------------------------------------------
-- Created by SmartDesign Tue Jan 25 21:43:42 2022
-- Version: v11.9 SP5 11.9.5.5
----------------------------------------------------------------------

----------------------------------------------------------------------
-- Libraries
----------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;


----------------------------------------------------------------------
-- VHDL_FRAMEBUFFER entity declaration
----------------------------------------------------------------------
entity VHDL_FRAMEBUFFER is
    -- Port list
    port(
        -- Inputs
        CAM_DATA         : in    std_logic_vector(7 downto 0);
        CAPTURE_READ     : in    std_logic;
        HREF             : in    std_logic;
        PCLK             : in    std_logic;
        RESET            : in    std_logic;
        SPI_CLK          : in    std_logic;
        VSYNC            : in    std_logic;
        -- Outputs
        CAPTURE_COMPLETE : out   std_logic;
        OE_N             : out   std_logic;
        READ_COMPLETE    : out   std_logic;
        SPI_MISO         : out   std_logic;
        SRAM_ADDR        : out   std_logic_vector(19 downto 0);
        WE_N             : out   std_logic;
        -- Inouts
        SRAM_DATA        : inout std_logic_vector(7 downto 0)
        );
end VHDL_FRAMEBUFFER;
----------------------------------------------------------------------
-- VHDL_FRAMEBUFFER architecture body
----------------------------------------------------------------------
architecture RTL of VHDL_FRAMEBUFFER is
----------------------------------------------------------------------
-- Component declarations
----------------------------------------------------------------------
-- addrMUX
component addrMUX
    -- Port list
    port(
        -- Inputs
        Data0_port : in  std_logic_vector(19 downto 0);
        Data1_port : in  std_logic_vector(19 downto 0);
        Sel0       : in  std_logic;
        -- Outputs
        Result     : out std_logic_vector(19 downto 0)
        );
end component;
-- AND2
component AND2
    -- Port list
    port(
        -- Inputs
        A : in  std_logic;
        B : in  std_logic;
        -- Outputs
        Y : out std_logic
        );
end component;
-- compareADDR
component compareADDR
    -- Port list
    port(
        -- Inputs
        DataA : in  std_logic_vector(19 downto 0);
        DataB : in  std_logic_vector(19 downto 0);
        -- Outputs
        AEB   : out std_logic
        );
end component;
-- DFN0C1
component DFN0C1
    -- Port list
    port(
        -- Inputs
        CLK : in  std_logic;
        CLR : in  std_logic;
        D   : in  std_logic;
        -- Outputs
        Q   : out std_logic
        );
end component;
-- DFN1C1
component DFN1C1
    -- Port list
    port(
        -- Inputs
        CLK : in  std_logic;
        CLR : in  std_logic;
        D   : in  std_logic;
        -- Outputs
        Q   : out std_logic
        );
end component;
-- imgSizeCNT
component imgSizeCNT
    -- Port list
    port(
        -- Inputs
        Aclr   : in  std_logic;
        Clock  : in  std_logic;
        Enable : in  std_logic;
        -- Outputs
        Q      : out std_logic_vector(4 downto 0);
        Tcnt   : out std_logic
        );
end component;
-- imgSizeMUX
component imgSizeMUX
    -- Port list
    port(
        -- Inputs
        Data0_port  : in  std_logic;
        Data10_port : in  std_logic;
        Data11_port : in  std_logic;
        Data12_port : in  std_logic;
        Data13_port : in  std_logic;
        Data14_port : in  std_logic;
        Data15_port : in  std_logic;
        Data16_port : in  std_logic;
        Data17_port : in  std_logic;
        Data18_port : in  std_logic;
        Data19_port : in  std_logic;
        Data1_port  : in  std_logic;
        Data20_port : in  std_logic;
        Data21_port : in  std_logic;
        Data22_port : in  std_logic;
        Data23_port : in  std_logic;
        Data24_port : in  std_logic;
        Data25_port : in  std_logic;
        Data26_port : in  std_logic;
        Data27_port : in  std_logic;
        Data28_port : in  std_logic;
        Data29_port : in  std_logic;
        Data2_port  : in  std_logic;
        Data30_port : in  std_logic;
        Data31_port : in  std_logic;
        Data3_port  : in  std_logic;
        Data4_port  : in  std_logic;
        Data5_port  : in  std_logic;
        Data6_port  : in  std_logic;
        Data7_port  : in  std_logic;
        Data8_port  : in  std_logic;
        Data9_port  : in  std_logic;
        Sel0        : in  std_logic;
        Sel1        : in  std_logic;
        Sel2        : in  std_logic;
        Sel3        : in  std_logic;
        Sel4        : in  std_logic;
        -- Outputs
        Result      : out std_logic
        );
end component;
-- INV
component INV
    -- Port list
    port(
        -- Inputs
        A : in  std_logic;
        -- Outputs
        Y : out std_logic
        );
end component;
-- NOR3
component NOR3
    -- Port list
    port(
        -- Inputs
        A : in  std_logic;
        B : in  std_logic;
        C : in  std_logic;
        -- Outputs
        Y : out std_logic
        );
end component;
-- OR2
component OR2
    -- Port list
    port(
        -- Inputs
        A : in  std_logic;
        B : in  std_logic;
        -- Outputs
        Y : out std_logic
        );
end component;
-- OR3
component OR3
    -- Port list
    port(
        -- Inputs
        A : in  std_logic;
        B : in  std_logic;
        C : in  std_logic;
        -- Outputs
        Y : out std_logic
        );
end component;
-- readCNT
component readCNT
    -- Port list
    port(
        -- Inputs
        Aclr   : in  std_logic;
        Clock  : in  std_logic;
        Enable : in  std_logic;
        -- Outputs
        Q      : out std_logic_vector(19 downto 0)
        );
end component;
-- spiClkMUX
component spiClkMUX
    -- Port list
    port(
        -- Inputs
        Data0_port : in  std_logic;
        Data1_port : in  std_logic;
        Sel0       : in  std_logic;
        -- Outputs
        Result     : out std_logic
        );
end component;
-- spiCNT
component spiCNT
    -- Port list
    port(
        -- Inputs
        Aclr   : in  std_logic;
        Clock  : in  std_logic;
        Enable : in  std_logic;
        -- Outputs
        Q      : out std_logic_vector(2 downto 0)
        );
end component;
-- spiMUX
component spiMUX
    -- Port list
    port(
        -- Inputs
        Data0_port : in  std_logic;
        Data1_port : in  std_logic;
        Sel0       : in  std_logic;
        -- Outputs
        Result     : out std_logic
        );
end component;
-- spiSHIFT
component spiSHIFT
    -- Port list
    port(
        -- Inputs
        Aclr     : in  std_logic;
        Clock    : in  std_logic;
        Data     : in  std_logic_vector(7 downto 0);
        Enable   : in  std_logic;
        Shiften  : in  std_logic;
        Shiftin  : in  std_logic;
        -- Outputs
        Shiftout : out std_logic
        );
end component;
-- sramBUF
component sramBUF
    -- Port list
    port(
        -- Inputs
        Data  : in    std_logic_vector(7 downto 0);
        Trien : in    std_logic;
        -- Outputs
        Y     : out   std_logic_vector(7 downto 0);
        -- Inouts
        PAD   : inout std_logic_vector(7 downto 0)
        );
end component;
-- writeCNT
component writeCNT
    -- Port list
    port(
        -- Inputs
        Aclr   : in  std_logic;
        Clock  : in  std_logic;
        Enable : in  std_logic;
        -- Outputs
        Q      : out std_logic_vector(19 downto 0)
        );
end component;
----------------------------------------------------------------------
-- Signal declarations
----------------------------------------------------------------------
signal AND2_0_Y               : std_logic;
signal AND2_1_Y               : std_logic;
signal AND2_2_Y               : std_logic;
signal CAPTURE_COMPLETE_net_0 : std_logic;
signal DFN0C1_0_Q             : std_logic;
signal DFN1C1_0_Q             : std_logic;
signal imgSizeCNT_0_Q0to0     : std_logic_vector(0 to 0);
signal imgSizeCNT_0_Q1to1     : std_logic_vector(1 to 1);
signal imgSizeCNT_0_Q2to2     : std_logic_vector(2 to 2);
signal imgSizeCNT_0_Q3to3     : std_logic_vector(3 to 3);
signal imgSizeCNT_0_Q4to4     : std_logic_vector(4 to 4);
signal imgSizeCNT_0_Tcnt      : std_logic;
signal imgSizeMUX_0_Result    : std_logic;
signal INV_0_Y                : std_logic;
signal INV_1_Y                : std_logic;
signal INV_2_Y                : std_logic;
signal INV_5_Y                : std_logic;
signal NOR3_0_Y               : std_logic;
signal OR2_0_Y                : std_logic;
signal OR2_1_Y                : std_logic;
signal READ_COMPLETE_2        : std_logic;
signal readCNT_0_Q            : std_logic_vector(19 downto 0);
signal SPI_MISO_0             : std_logic;
signal spiClkMUX_0_Result     : std_logic;
signal spiCNT_0_Q0to0         : std_logic_vector(0 to 0);
signal spiCNT_0_Q1to1         : std_logic_vector(1 to 1);
signal spiCNT_0_Q2to2         : std_logic_vector(2 to 2);
signal spiSHIFT_0_Shiftout    : std_logic;
signal SRAM_ADDR_net_0        : std_logic_vector(19 downto 0);
signal sramBUF_0_Y            : std_logic_vector(7 downto 0);
signal WE_N_net_0             : std_logic;
signal writeCNT_0_Q           : std_logic_vector(19 downto 0);
signal writeCNT_0_Q0to0       : std_logic_vector(0 to 0);
signal writeCNT_0_Q1to1       : std_logic_vector(1 to 1);
signal writeCNT_0_Q2to2       : std_logic_vector(2 to 2);
signal writeCNT_0_Q3to3       : std_logic_vector(3 to 3);
signal writeCNT_0_Q4to4       : std_logic_vector(4 to 4);
signal writeCNT_0_Q5to5       : std_logic_vector(5 to 5);
signal writeCNT_0_Q6to6       : std_logic_vector(6 to 6);
signal writeCNT_0_Q7to7       : std_logic_vector(7 to 7);
signal writeCNT_0_Q8to8       : std_logic_vector(8 to 8);
signal writeCNT_0_Q9to9       : std_logic_vector(9 to 9);
signal writeCNT_0_Q10to10     : std_logic_vector(10 to 10);
signal writeCNT_0_Q11to11     : std_logic_vector(11 to 11);
signal writeCNT_0_Q12to12     : std_logic_vector(12 to 12);
signal writeCNT_0_Q13to13     : std_logic_vector(13 to 13);
signal writeCNT_0_Q14to14     : std_logic_vector(14 to 14);
signal writeCNT_0_Q15to15     : std_logic_vector(15 to 15);
signal writeCNT_0_Q16to16     : std_logic_vector(16 to 16);
signal writeCNT_0_Q17to17     : std_logic_vector(17 to 17);
signal writeCNT_0_Q18to18     : std_logic_vector(18 to 18);
signal writeCNT_0_Q19to19     : std_logic_vector(19 to 19);
signal SPI_MISO_0_net_0       : std_logic;
signal READ_COMPLETE_2_net_0  : std_logic;
signal CAPTURE_READ_0_net_0   : std_logic;
signal WE_N_net_1             : std_logic;
signal CAPTURE_COMPLETE_net_1 : std_logic;
signal SRAM_ADDR_net_1        : std_logic_vector(19 downto 0);
signal Q_net_0                : std_logic_vector(4 downto 0);
signal Q_net_1                : std_logic_vector(2 downto 0);
----------------------------------------------------------------------
-- TiedOff Signals
----------------------------------------------------------------------
signal VCC_net                : std_logic;
signal GND_net                : std_logic;
----------------------------------------------------------------------
-- Inverted Signals
----------------------------------------------------------------------
signal B_IN_POST_INV0_0       : std_logic;

begin
----------------------------------------------------------------------
-- Constant assignments
----------------------------------------------------------------------
 VCC_net <= '1';
 GND_net <= '0';
----------------------------------------------------------------------
-- Inversions
----------------------------------------------------------------------
 B_IN_POST_INV0_0 <= NOT CAPTURE_COMPLETE_net_0;
----------------------------------------------------------------------
-- Top level output port assignments
----------------------------------------------------------------------
 SPI_MISO_0_net_0       <= SPI_MISO_0;
 SPI_MISO               <= SPI_MISO_0_net_0;
 READ_COMPLETE_2_net_0  <= READ_COMPLETE_2;
 READ_COMPLETE          <= READ_COMPLETE_2_net_0;
 CAPTURE_READ_0_net_0   <= CAPTURE_READ;
 OE_N                   <= CAPTURE_READ_0_net_0;
 WE_N_net_1             <= WE_N_net_0;
 WE_N                   <= WE_N_net_1;
 CAPTURE_COMPLETE_net_1 <= CAPTURE_COMPLETE_net_0;
 CAPTURE_COMPLETE       <= CAPTURE_COMPLETE_net_1;
 SRAM_ADDR_net_1        <= SRAM_ADDR_net_0;
 SRAM_ADDR(19 downto 0) <= SRAM_ADDR_net_1;
----------------------------------------------------------------------
-- Slices assignments
----------------------------------------------------------------------
 imgSizeCNT_0_Q0to0(0)  <= Q_net_0(0);
 imgSizeCNT_0_Q1to1(1)  <= Q_net_0(1);
 imgSizeCNT_0_Q2to2(2)  <= Q_net_0(2);
 imgSizeCNT_0_Q3to3(3)  <= Q_net_0(3);
 imgSizeCNT_0_Q4to4(4)  <= Q_net_0(4);
 spiCNT_0_Q0to0(0)      <= Q_net_1(0);
 spiCNT_0_Q1to1(1)      <= Q_net_1(1);
 spiCNT_0_Q2to2(2)      <= Q_net_1(2);
 writeCNT_0_Q0to0(0)    <= writeCNT_0_Q(0);
 writeCNT_0_Q1to1(1)    <= writeCNT_0_Q(1);
 writeCNT_0_Q2to2(2)    <= writeCNT_0_Q(2);
 writeCNT_0_Q3to3(3)    <= writeCNT_0_Q(3);
 writeCNT_0_Q4to4(4)    <= writeCNT_0_Q(4);
 writeCNT_0_Q5to5(5)    <= writeCNT_0_Q(5);
 writeCNT_0_Q6to6(6)    <= writeCNT_0_Q(6);
 writeCNT_0_Q7to7(7)    <= writeCNT_0_Q(7);
 writeCNT_0_Q8to8(8)    <= writeCNT_0_Q(8);
 writeCNT_0_Q9to9(9)    <= writeCNT_0_Q(9);
 writeCNT_0_Q10to10(10) <= writeCNT_0_Q(10);
 writeCNT_0_Q11to11(11) <= writeCNT_0_Q(11);
 writeCNT_0_Q12to12(12) <= writeCNT_0_Q(12);
 writeCNT_0_Q13to13(13) <= writeCNT_0_Q(13);
 writeCNT_0_Q14to14(14) <= writeCNT_0_Q(14);
 writeCNT_0_Q15to15(15) <= writeCNT_0_Q(15);
 writeCNT_0_Q16to16(16) <= writeCNT_0_Q(16);
 writeCNT_0_Q17to17(17) <= writeCNT_0_Q(17);
 writeCNT_0_Q18to18(18) <= writeCNT_0_Q(18);
 writeCNT_0_Q19to19(19) <= writeCNT_0_Q(19);
----------------------------------------------------------------------
-- Component instances
----------------------------------------------------------------------
-- addrMUX_0
addrMUX_0 : addrMUX
    port map( 
        -- Inputs
        Sel0       => CAPTURE_READ,
        Data0_port => readCNT_0_Q,
        Data1_port => writeCNT_0_Q,
        -- Outputs
        Result     => SRAM_ADDR_net_0 
        );
-- AND2_0
AND2_0 : AND2
    port map( 
        -- Inputs
        A => HREF,
        B => PCLK,
        -- Outputs
        Y => AND2_0_Y 
        );
-- AND2_1
AND2_1 : AND2
    port map( 
        -- Inputs
        A => DFN1C1_0_Q,
        B => INV_5_Y,
        -- Outputs
        Y => AND2_1_Y 
        );
-- AND2_2
AND2_2 : AND2
    port map( 
        -- Inputs
        A => DFN1C1_0_Q,
        B => B_IN_POST_INV0_0,
        -- Outputs
        Y => AND2_2_Y 
        );
-- compareADDR_0
compareADDR_0 : compareADDR
    port map( 
        -- Inputs
        DataA => readCNT_0_Q,
        DataB => writeCNT_0_Q,
        -- Outputs
        AEB   => READ_COMPLETE_2 
        );
-- DFN0C1_0
DFN0C1_0 : DFN0C1
    port map( 
        -- Inputs
        D   => imgSizeCNT_0_Tcnt,
        CLK => SPI_CLK,
        CLR => RESET,
        -- Outputs
        Q   => DFN0C1_0_Q 
        );
-- DFN1C1_0
DFN1C1_0 : DFN1C1
    port map( 
        -- Inputs
        D   => VCC_net,
        CLK => VSYNC,
        CLR => RESET,
        -- Outputs
        Q   => DFN1C1_0_Q 
        );
-- DFN1C1_1
DFN1C1_1 : DFN1C1
    port map( 
        -- Inputs
        D   => VCC_net,
        CLK => AND2_1_Y,
        CLR => RESET,
        -- Outputs
        Q   => CAPTURE_COMPLETE_net_0 
        );
-- imgSizeCNT_0
imgSizeCNT_0 : imgSizeCNT
    port map( 
        -- Inputs
        Aclr   => RESET,
        Clock  => SPI_CLK,
        Enable => imgSizeCNT_0_Tcnt,
        -- Outputs
        Tcnt   => imgSizeCNT_0_Tcnt,
        Q      => Q_net_0 
        );
-- imgSizeMUX_0
imgSizeMUX_0 : imgSizeMUX
    port map( 
        -- Inputs
        Data0_port  => GND_net,
        Data1_port  => GND_net,
        Data2_port  => GND_net,
        Data3_port  => GND_net,
        Data4_port  => GND_net,
        Data5_port  => GND_net,
        Data6_port  => GND_net,
        Data7_port  => GND_net,
        Data8_port  => GND_net,
        Data9_port  => GND_net,
        Data10_port => GND_net,
        Data11_port => GND_net,
        Data12_port => writeCNT_0_Q19to19(19),
        Data13_port => writeCNT_0_Q18to18(18),
        Data14_port => writeCNT_0_Q17to17(17),
        Data15_port => writeCNT_0_Q16to16(16),
        Data16_port => writeCNT_0_Q15to15(15),
        Data17_port => writeCNT_0_Q14to14(14),
        Data18_port => writeCNT_0_Q13to13(13),
        Data19_port => writeCNT_0_Q12to12(12),
        Data20_port => writeCNT_0_Q11to11(11),
        Data21_port => writeCNT_0_Q10to10(10),
        Data22_port => writeCNT_0_Q9to9(9),
        Data23_port => writeCNT_0_Q8to8(8),
        Data24_port => writeCNT_0_Q7to7(7),
        Data25_port => writeCNT_0_Q6to6(6),
        Data26_port => writeCNT_0_Q5to5(5),
        Data27_port => writeCNT_0_Q4to4(4),
        Data28_port => writeCNT_0_Q3to3(3),
        Data29_port => writeCNT_0_Q2to2(2),
        Data30_port => writeCNT_0_Q1to1(1),
        Data31_port => writeCNT_0_Q0to0(0),
        Sel0        => imgSizeCNT_0_Q0to0(0),
        Sel1        => imgSizeCNT_0_Q1to1(1),
        Sel2        => imgSizeCNT_0_Q2to2(2),
        Sel3        => imgSizeCNT_0_Q3to3(3),
        Sel4        => imgSizeCNT_0_Q4to4(4),
        -- Outputs
        Result      => imgSizeMUX_0_Result 
        );
-- INV_0
INV_0 : INV
    port map( 
        -- Inputs
        A => AND2_0_Y,
        -- Outputs
        Y => INV_0_Y 
        );
-- INV_1
INV_1 : INV
    port map( 
        -- Inputs
        A => AND2_2_Y,
        -- Outputs
        Y => INV_1_Y 
        );
-- INV_2
INV_2 : INV
    port map( 
        -- Inputs
        A => CAPTURE_READ,
        -- Outputs
        Y => INV_2_Y 
        );
-- INV_5
INV_5 : INV
    port map( 
        -- Inputs
        A => VSYNC,
        -- Outputs
        Y => INV_5_Y 
        );
-- NOR3_0
NOR3_0 : NOR3
    port map( 
        -- Inputs
        A => spiCNT_0_Q2to2(2),
        B => spiCNT_0_Q1to1(1),
        C => spiCNT_0_Q0to0(0),
        -- Outputs
        Y => NOR3_0_Y 
        );
-- OR2_0
OR2_0 : OR2
    port map( 
        -- Inputs
        A => CAPTURE_READ,
        B => READ_COMPLETE_2,
        -- Outputs
        Y => OR2_0_Y 
        );
-- OR2_1
OR2_1 : OR2
    port map( 
        -- Inputs
        A => RESET,
        B => CAPTURE_READ,
        -- Outputs
        Y => OR2_1_Y 
        );
-- OR3_0
OR3_0 : OR3
    port map( 
        -- Inputs
        A => INV_2_Y,
        B => INV_0_Y,
        C => INV_1_Y,
        -- Outputs
        Y => WE_N_net_0 
        );
-- readCNT_0
readCNT_0 : readCNT
    port map( 
        -- Inputs
        Aclr   => RESET,
        Clock  => NOR3_0_Y,
        Enable => OR2_0_Y,
        -- Outputs
        Q      => readCNT_0_Q 
        );
-- spiClkMUX_0
spiClkMUX_0 : spiClkMUX
    port map( 
        -- Inputs
        Data0_port => GND_net,
        Data1_port => SPI_CLK,
        Sel0       => DFN0C1_0_Q,
        -- Outputs
        Result     => spiClkMUX_0_Result 
        );
-- spiCNT_0
spiCNT_0 : spiCNT
    port map( 
        -- Inputs
        Aclr   => RESET,
        Clock  => spiClkMUX_0_Result,
        Enable => CAPTURE_READ,
        -- Outputs
        Q      => Q_net_1 
        );
-- spiMUX_0
spiMUX_0 : spiMUX
    port map( 
        -- Inputs
        Data0_port => imgSizeMUX_0_Result,
        Data1_port => spiSHIFT_0_Shiftout,
        Sel0       => DFN0C1_0_Q,
        -- Outputs
        Result     => SPI_MISO_0 
        );
-- spiSHIFT_0
spiSHIFT_0 : spiSHIFT
    port map( 
        -- Inputs
        Enable   => NOR3_0_Y,
        Shiften  => NOR3_0_Y,
        Shiftin  => GND_net,
        Aclr     => OR2_1_Y,
        Clock    => spiClkMUX_0_Result,
        Data     => sramBUF_0_Y,
        -- Outputs
        Shiftout => spiSHIFT_0_Shiftout 
        );
-- sramBUF_0
sramBUF_0 : sramBUF
    port map( 
        -- Inputs
        Trien => CAPTURE_READ,
        Data  => CAM_DATA,
        -- Outputs
        Y     => sramBUF_0_Y,
        -- Inouts
        PAD   => SRAM_DATA 
        );
-- writeCNT_0
writeCNT_0 : writeCNT
    port map( 
        -- Inputs
        Aclr   => RESET,
        Clock  => WE_N_net_0,
        Enable => CAPTURE_READ,
        -- Outputs
        Q      => writeCNT_0_Q 
        );

end RTL;