///////////////////////////////////////////////////////////////////////////////////////////////////
// Company: <Name>
//
// File: simulate_SPI_READ.v
// File history:
//      <Revision number>: <Date>: <Comments>
//      <Revision number>: <Date>: <Comments>
//      <Revision number>: <Date>: <Comments>
//
// Description: 
//
// <Description here>
//
// Targeted device: <Family::IGLOO> <Die::AGLN020V2> <Package::68 QFN>
// Author: <Name>
//
/////////////////////////////////////////////////////////////////////////////////////////////////// 

`timescale 1ns/10ps

module simulate_SPI_READ;

parameter SYSCLK_PERIOD = 25;// 40MHZ

reg SYSCLK;
reg NSYSRESET;

//My definitions
reg CAPTURE_READ;
reg SPI_CLK;

//wire [19:0] SRAM_ADDR;
wire SPI_MISO;
//wire READ_COMPLETE;

initial
begin
    SYSCLK = 1'b0;
    NSYSRESET = 1'b1;
    SPI_CLK = 1'b0;
    CAPTURE_READ = 1'b0;
end

//////////////////////////////////////////////////////////////////////
// Reset Pulse
//////////////////////////////////////////////////////////////////////
initial
begin
    #(SYSCLK_PERIOD * 10 )
        NSYSRESET = 1'b0;
end


//////////////////////////////////////////////////////////////////////
// Clock Driver
//////////////////////////////////////////////////////////////////////
always @(SYSCLK)
    #(SYSCLK_PERIOD / 2.0) SYSCLK <= !SYSCLK;


//////////////////////////////////////////////////////////////////////
// Instantiate Unit Under Test:  mem_test
//////////////////////////////////////////////////////////////////////
VHDL_FRAMEBUFFER VHDL_FRAMEBUFFER_0 (
    // Inputs
    .RESET(NSYSRESET),
    .SPI_CLK(SPI_CLK),
    .CAPTURE_READ(CAPTURE_READ),

    // Outputs
    .SPI_MISO(SPI_MISO)
 //   .SRAM_ADDR(SRAM_ADDR),
 //   .READ_COMPLETE(READ_COMPLETE)

    // Inouts

);

//////////////////////////////////////////////////////////////////////
// Stimulus
//////////////////////////////////////////////////////////////////////
initial
begin
#10
CAPTURE_READ = 1'b1;
NSYSRESET = 1'b0;
#20
repeat(16) #12.5 SPI_CLK=~SPI_CLK;
#20
CAPTURE_READ = 1'b0;
repeat(144) #12.5 SPI_CLK=~SPI_CLK;

end

endmodule

