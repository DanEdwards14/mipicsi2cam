//I2C initialization of Raspberry Pi Cam Module 2 Sony IMX219
//Based off of code from https://elixir.bootlin.com/linux/latest/source/drivers/media/i2c/imx219.c
//Author: Daniel Edwards


 #include <clk.h>
//Need to go through and find corresponding libraries for Arduino from remaining linux libraries
/*
   
  #include <linux/delay.h>
  #include <linux/gpio/consumer.h>
  #include <linux/i2c.h>              --done
  #include <linux/module.h>
  #include <linux/pm_runtime.h>
  #include <linux/regulator/consumer.h>
  #include <media/v4l2-ctrls.h>
  #include <media/v4l2-device.h>
  #include <media/v4l2-event.h>
  #include <media/v4l2-fwnode.h>
  #include <media/v4l2-mediabus.h>
  #include <asm/unaligned.h>
*/

#include <Wire.h>                     //I2C library from Arduino's website -> have to finish replacing functions from linux example.
#include <SPI.h>

#define IMX219_REG_VALUE_08BIT    1           //Assigning Registers and values for better understanding later on
#define IMX219_REG_VALUE_16BIT    2


#define IMX219_REG_MODE_SELECT    0x0100
#define IMX219_MODE_STANDBY       0x00
#define IMX219_MODE_STREAMING     0x01

/* Chip ID */
#define IMX219_REG_CHIP_ID    0x0000
#define IMX219_CHIP_ID      0x0219

/* External clock frequency is 24.0M */
#define IMX219_XCLK_FREQ    24000000


/* Pixel rate is fixed at 182.4M for all the modes */
#define IMX219_PIXEL_RATE    182400000

#define IMX219_DEFAULT_LINK_FREQ  456000000

/* V_TIMING internal */
#define IMX219_REG_VTS            0x0160
#define IMX219_VTS_15FPS          0x0dc6
#define IMX219_VTS_30FPS_1080P    0x06e3
#define IMX219_VTS_30FPS_BINNED   0x06e3
#define IMX219_VTS_30FPS_640x480  0x06e3
#define IMX219_VTS_MAX            0xffff

#define IMX219_VBLANK_MIN         4

/*Frame Length Line*/
#define IMX219_FLL_MIN        0x08a6
#define IMX219_FLL_MAX        0xffff
#define IMX219_FLL_STEP        1
#define IMX219_FLL_DEFAULT    0x0c98

/* HBLANK control - read only */
#define IMX219_PPL_DEFAULT    3448

/* Exposure control */
#define IMX219_REG_EXPOSURE       0x015a
#define IMX219_EXPOSURE_MIN       4
#define IMX219_EXPOSURE_STEP      1
#define IMX219_EXPOSURE_DEFAULT   0x640
#define IMX219_EXPOSURE_MAX       65535


/* Analog gain control */
#define IMX219_REG_ANALOG_GAIN    0x0157
#define IMX219_ANA_GAIN_MIN       0
#define IMX219_ANA_GAIN_MAX       232
#define IMX219_ANA_GAIN_STEP      1
#define IMX219_ANA_GAIN_DEFAULT   0x0

/* Digital gain control */
#define IMX219_REG_DIGITAL_GAIN   0x0158
#define IMX219_DGTL_GAIN_MIN      0x0100
#define IMX219_DGTL_GAIN_MAX      0x0fff
#define IMX219_DGTL_GAIN_DEFAULT  0x0100
#define IMX219_DGTL_GAIN_STEP     1

#define IMX219_REG_ORIENTATION    0x0172

/* Test Pattern Control */
#define IMX219_REG_TEST_PATTERN         0x0600
#define IMX219_TEST_PATTERN_DISABLE     0
#define IMX219_TEST_PATTERN_SOLID_COLOR 1
#define IMX219_TEST_PATTERN_COLOR_BARS  2
#define IMX219_TEST_PATTERN_GREY_COLOR  3
#define IMX219_TEST_PATTERN_PN9         4

/* Test pattern colour components */
#define IMX219_REG_TESTP_RED      0x0602
#define IMX219_REG_TESTP_GREENR   0x0604
#define IMX219_REG_TESTP_BLUE     0x0606
#define IMX219_REG_TESTP_GREENB   0x0608
#define IMX219_TESTP_COLOUR_MIN   0
#define IMX219_TESTP_COLOUR_MAX   0x03ff
#define IMX219_TESTP_COLOUR_STEP  1
#define IMX219_TESTP_RED_DEFAULT  IMX219_TESTP_COLOUR_MAX
#define IMX219_TESTP_GREENR_DEFAULT 0
#define IMX219_TESTP_BLUE_DEFAULT   0
#define IMX219_TESTP_GREENB_DEFAULT 0

/* IMX219 native and active pixel array size. */            //Pixel array size for 8MP image capture
#define IMX219_NATIVE_WIDTH       3296U
#define IMX219_NATIVE_HEIGHT      2480U
#define IMX219_PIXEL_ARRAY_LEFT   8U
#define IMX219_PIXEL_ARRAY_TOP    8U
#define IMX219_PIXEL_ARRAY_WIDTH  3280U
#define IMX219_PIXEL_ARRAY_HEIGHT 2464U


struct imx219_reg {   //defines the register data type with 16bit address and 8bit value
  u16 address;
  u8 val;
};

struct imx219_reg_list {      //defines register list for storage of created registers used later on
  unsigned int num_of_regs;
  const struct imx219_reg *regs;
};

// Mode : resolution and related config&values
struct imx219_mode {
  /* Frame width */
  unsigned int width;
  /* Frame height */
  unsigned int height;

  /* Analog crop rectangle. */      //Rectangle Crop      // Error field 'crop' has incomplete type 'v4l2_rect'
  struct v4l2_rect crop;

  /* V-timing */                //IDK what V-timing is yet
  unsigned int vts_def;

  /* Default register values */
  struct imx219_reg_list reg_list;
};
/*
   Register sets lifted off the i2C interface from the Raspberry Pi firmware
   driver.
   3280x2464 = mode 2, 1920x1080 = mode 1, 1640x1232 = mode 4, 640x480 = mode 7.
*/
//Sets varuious registers for parameters desired for 8MP image capture
static const struct imx219_reg mode_3280x2464_regs[] = {    //I'm just using the 3280x2464 mode '2' for 8MP
  {0x0100, 0x00},
  {0x30eb, 0x0c},
  {0x30eb, 0x05},
  {0x300a, 0xff},
  {0x300b, 0xff},
  {0x30eb, 0x05},
  {0x30eb, 0x09},
  {0x0114, 0x01},
  {0x0128, 0x00},
  {0x012a, 0x18},
  {0x012b, 0x00},
  {0x0164, 0x00},
  {0x0165, 0x00},
  {0x0166, 0x0c},
  {0x0167, 0xcf},
  {0x0168, 0x00},
  {0x0169, 0x00},
  {0x016a, 0x09},
  {0x016b, 0x9f},
  {0x016c, 0x0c},
  {0x016d, 0xd0},
  {0x016e, 0x09},
  {0x016f, 0xa0},
  {0x0170, 0x01},
  {0x0171, 0x01},
  {0x0174, 0x00},
  {0x0175, 0x00},
  {0x0301, 0x05},
  {0x0303, 0x01},
  {0x0304, 0x03},
  {0x0305, 0x03},
  {0x0306, 0x00},
  {0x0307, 0x39},
  {0x030b, 0x01},
  {0x030c, 0x00},
  {0x030d, 0x72},
  {0x0624, 0x0c},
  {0x0625, 0xd0},
  {0x0626, 0x09},
  {0x0627, 0xa0},
  {0x455e, 0x00},
  {0x471e, 0x4b},
  {0x4767, 0x0f},
  {0x4750, 0x14},
  {0x4540, 0x00},
  {0x47b4, 0x14},
  {0x4713, 0x30},
  {0x478b, 0x10},
  {0x478f, 0x10},
  {0x4793, 0x10},
  {0x4797, 0x0e},
  {0x479b, 0x0e},
  {0x0162, 0x0d},
  {0x0163, 0x78},
};

static const struct imx219_reg raw8_framefmt_regs[] = {
  {0x018c, 0x08},
  {0x018d, 0x08},
  {0x0309, 0x08},
};

static const struct imx219_reg raw10_framefmt_regs[] = {
  {0x018c, 0x0a},
  {0x018d, 0x0a},
  {0x0309, 0x0a},
};

static const s64 imx219_link_freq_menu[] = {
  IMX219_DEFAULT_LINK_FREQ,
};

static const char * const imx219_test_pattern_menu[] = { //Menu display options for testing patterns for camera I'm assuming
  "Disabled",
  "Color Bars",
  "Solid Color",
  "Grey Color Bars",
  "PN9"
};

static const int imx219_test_pattern_val[] = {
  IMX219_TEST_PATTERN_DISABLE,
  IMX219_TEST_PATTERN_COLOR_BARS,
  IMX219_TEST_PATTERN_SOLID_COLOR,
  IMX219_TEST_PATTERN_GREY_COLOR,
  IMX219_TEST_PATTERN_PN9,
};

/* regulator supplies */                                //Voltage regulators?
static const char * const imx219_supply_name[] = {
  /* Supplies can be enabled in any order */
  "VANA",  /* Analog (2.8V) supply */
  "VDIG",  /* Digital Core (1.8V) supply */
  "VDDL",  /* IF (1.2V) supply */
};

#define IMX219_NUM_SUPPLIES ARRAY_SIZE(imx219_supply_name)
/*
   The supported formats.
   This table MUST contain 4 entries per format, to cover the various flip
   combinations in the order
   - no flip
   - h flip
   - v flip
   - h&v flips
*/

static const u32 codes[] = {                  //Image flipping (Horizontal, vertical, no flip, h&v)
  MEDIA_BUS_FMT_SRGGB10_1X10,
  MEDIA_BUS_FMT_SGRBG10_1X10,
  MEDIA_BUS_FMT_SGBRG10_1X10,
  MEDIA_BUS_FMT_SBGGR10_1X10,

  MEDIA_BUS_FMT_SRGGB8_1X8,
  MEDIA_BUS_FMT_SGRBG8_1X8,
  MEDIA_BUS_FMT_SGBRG8_1X8,
  MEDIA_BUS_FMT_SBGGR8_1X8,
};
/*
   Initialisation delay between XCLR low->high and the moment when the sensor
   can start capture (i.e. can leave software stanby) must be not less than:
     t4 + max(t5, t6 + <time to initialize the sensor register over I2C>)
   where
     t4 is fixed, and is max 200uS,
     t5 is fixed, and is 6000uS,
     t6 depends on the sensor external clock, and is max 32000 clock periods.
   As per sensor datasheet, the external clock must be from 6MHz to 27MHz.
   So for any acceptable external clock t6 is always within the range of
   1185 to 5333 uS, and is always less than t5.
   For this reason this is always safe to wait (t4 + t5) = 6200 uS, then
   initialize the sensor over I2C, and then exit the software standby.

   This delay doesn't account for the power supply startup time. If needed,
   this should be taken care of via the regulator framework. E.g. in the
   case of DT for regulator-fixed one should define the startup-delay-us
   property.
*/
#define IMX219_XCLR_MIN_DELAY_US  6200
#define IMX219_XCLR_DELAY_RANGE_US  1000

/*Mode configs */
static const struct imx219_mode supported_modes[] = {     //Edited supported mode struct for only 8MP image capture (Took out potential needed modes for later on)
  {
    /* 8MPix 15fps mode */
    .width = 3280,
    .height = 2464,
    .crop = {
      .left = IMX219_PIXEL_ARRAY_LEFT,
      .top = IMX219_PIXEL_ARRAY_TOP,
      .width = 3280,
      .height = 2464
    },
    .vts_def = IMX219_VTS_15FPS,
    .reg_list = {
      .num_of_regs = ARRAY_SIZE(mode_3280x2464_regs),
      .regs = mode_3280x2464_regs,
    },
  }
};

struct imx219 {                                           //Need to add more descriptions before moving on
  struct v4l2_subdev sd;                                  //Each sub-device driver must have a v4l2_subdev struct.
  struct media_pad pad;                                   

  struct v4l2_mbus_framefmt fmt;                          

  struct clk *xclk; /* system clock to IMX219 */
  u32 xclk_freq;

  struct gpio_desc *reset_gpio;                                 //General-purpose input/output
  struct regulator_bulk_data supplies[IMX219_NUM_SUPPLIES];

  struct v4l2_ctrl_handler ctrl_handler;
  /* V4L2 Controls */
  struct v4l2_ctrl *pixel_rate;
  struct v4l2_ctrl *link_freq;
  struct v4l2_ctrl *exposure;
  struct v4l2_ctrl *vflip;
  struct v4l2_ctrl *hflip;
  struct v4l2_ctrl *vblank;
  struct v4l2_ctrl *hblank;

  /* Current mode */
  const struct imx219_mode *mode;

  /*
   * Mutex for serialized access:
   * Protect sensor module set pad format and start/stop streaming safely.
   */
  struct mutex mutex;           

  /* Streaming on/off */
  bool streaming;
};

void setup() {
  // put your setup code here, to run once:

}

void loop() {

}
