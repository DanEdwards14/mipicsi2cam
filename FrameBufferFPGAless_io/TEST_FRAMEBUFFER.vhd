--------------------------------------------------------------------------------
-- Company: <Name>
--
-- File: TEST_FRAMEBUFFER.vhd
-- File history:
--      <Revision number>: <Date>: <Comments>
--      <Revision number>: <Date>: <Comments>
--      <Revision number>: <Date>: <Comments>
--
-- Description: 
--
-- <Description here>
--
-- Targeted device: <Family::IGLOO> <Die::AGLN020V2> <Package::68 QFN>
-- Author: <Name>
--
--------------------------------------------------------------------------------




library ieee;
use ieee.std_logic_1164.all;
--use ieee.std_logic_arith.all;
use ieee.numeric_std.all;
use IEEE.std_logic_unsigned.all;



entity TEST_FRAMEBUFFER is
end TEST_FRAMEBUFFER;

architecture behavioral of TEST_FRAMEBUFFER is

    constant SYSCLK_PERIOD : time := 100 ns; -- 10MHZ

    signal SYSCLK : std_logic := '0';
    signal NSYSRESET : std_logic := '0';
    signal SPI_MISO : std_logic;
    signal CAPTURE_READ : std_logic := '0';
    signal SPI_CLK : std_logic := '0';
    signal READ_COMPLETE : std_logic; 
    signal OE_N : std_logic;
    signal WE_N : std_logic;
    signal CAPTURE_COMPLETE : std_logic;
    signal HREF : std_logic :='0';
    signal PCLK : std_logic :='0';
    signal SRAM_ADDR : std_logic_vector (19 downto 0);
    signal SRAM_DATA : std_logic_vector (7 downto 0);
    signal CAM_DATA : std_logic_vector (7 downto 0);
    signal VSYNC : std_logic :='0';

    type ram_type is array (0 to 2**8-1) of std_logic_vector(7 downto 0);
    signal ram1: ram_type:= (others=> (others=> '0'));


    component VHDL_FRAMEBUFFER
        -- ports
        port( 
            -- Inputs
            RESET : in std_logic;
            SPI_CLK : in std_logic;
            CAPTURE_READ : in std_logic;
            HREF : in std_logic;
            PCLK : in std_logic;
            VSYNC : in std_logic;
            CAM_DATA : in std_logic_vector (7 downto 0);

            -- Outputs
            SPI_MISO : out std_logic;
            READ_COMPLETE : out std_logic;
            OE_N : out std_logic;
            WE_N : out std_logic;
            CAPTURE_COMPLETE : out std_logic;
            SRAM_ADDR : out std_logic_vector (19 downto 0);

            -- Inouts
            SRAM_DATA : inout std_logic_vector (7 downto 0)

        );
    end component;

    --component SRAM20
        ---- ports
        --port( 
            ---- Inputs
            --MEM_WE : in std_logic;
            --MEM_OE : in std_logic;
            --MEM_ADDRESS : in std_logic_vector (19 downto 0);
--
            ---- Outputs
--
            ---- Inouts
            --MEM_DATA : inout std_logic_vector (7 downto 0)
--
        --);
    --end component;


begin

    -- Instantiate Unit Under Test:  VHDL_FRAMEBUFFER
    VHDL_FRAMEBUFFER_0 : VHDL_FRAMEBUFFER
        -- port map
        port map( 
            -- Inputs
            RESET => NSYSRESET,
            SPI_CLK => SPI_CLK,
            CAPTURE_READ => CAPTURE_READ,
            HREF => HREF,
            PCLK => PCLK,
            CAM_DATA => CAM_DATA,
            VSYNC => VSYNC,

            -- Outputs
            SPI_MISO =>  SPI_MISO,
            READ_COMPLETE => READ_COMPLETE,
            SRAM_ADDR => SRAM_ADDR,
            OE_N => OE_N,
            WE_N => WE_N,
            CAPTURE_COMPLETE => CAPTURE_COMPLETE,
            
            -- Inouts
            SRAM_DATA => SRAM_DATA

        );

    ---- Instantiate Unit Under Test:  VHDL_FRAMEBUFFER
    --SRAM20_0 : SRAM20
        ---- port map
        --port map( 
            ---- Inputs
            --MEM_WE => WE_N,
            --MEM_OE => OE_N,
            --MEM_ADDRESS => SRAM_ADDR,
--
            ---- Outputs
            --
            ---- Inouts
            --MEM_DATA => SRAM_DATA
--
        --);


stim_proc: process
   begin        
        NSYSRESET <='1';
        wait for 50 ns;
        HREF<='1';
        VSYNC<='0';
        CAM_DATA<="10000001";
        wait for 50 ns;
        NSYSRESET <='0';
        VSYNC <='1';
-- Eight cycles of PCLK - check for tolerance to free running PCLK
        wait for 50 ns;
          for i in 1 to 16 loop
            PCLK <= not PCLK;
            wait for 25 ns;
          end loop;
        wait for 50 ns;
        HREF<='0';
        wait for 50 ns;
        
        CAPTURE_READ<='1';
        wait for 50ns;
        HREF<='1';
        wait for 50ns;

-- 255 cycles of PCLK
          for i in 1 to 255 loop
            CAM_DATA<=std_logic_vector(to_unsigned(i, 8));
            PCLK <= not PCLK;
            wait for 25 ns;
            PCLK<= not PCLK;
            wait for 25 ns;
          end loop;
      --  CAM_DATA<="01011010";
      --    for i in 1 to 8 loop
      --      PCLK <= not PCLK;
      --      wait for 25 ns;
      --    end loop;

        wait for 50 ns;
        HREF<='0';
        wait for 50 ns;
        CAPTURE_READ<='0';
        wait for 50 ns;
-- Read 4 bytes of size (32 clocks) and image data
        for i in 1 to 512 loop
            SPI_CLK <= not SPI_CLK;
            wait for 25 ns;
          end loop;
        wait for 50 ns;
        CAPTURE_READ<='1';
        wait for 100 ns;
        CAPTURE_READ<='0';

        wait;
  end process;

sram: process
   begin 
    SRAM_DATA <= (others=> 'Z');
    --chip is not selected
    if rising_edge(WE_N) then --write
        ram1(to_integer(unsigned(SRAM_ADDR))) <= SRAM_DATA;
        wait for 0 ns;
    end if;
    if  WE_N = '1' and OE_N = '0' then --read
    SRAM_DATA <= ram1(to_integer(unsigned(SRAM_ADDR)));
    else SRAM_DATA <= (others => 'Z');
    end if;
wait on WE_N, OE_N, SRAM_ADDR;
end process;

end behavioral;


