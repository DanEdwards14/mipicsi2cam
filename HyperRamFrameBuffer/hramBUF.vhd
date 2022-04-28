-- Version: v11.7 SP2 11.7.2.2

library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;


entity hramBUF is

    port( Data  : in    std_logic_vector(7 downto 0);
          Y     : out   std_logic_vector(7 downto 0);
          Trien : in    std_logic;
          PAD   : inout std_logic_vector(7 downto 0) := (others => 'Z')
        );

end hramBUF;

architecture DEF_ARCH of hramBUF is 

  component BIBUF
    port( PAD : inout   std_logic;
          D   : in    std_logic := 'U';
          E   : in    std_logic := 'U';
          Y   : out   std_logic
        );
  end component;


begin 


\BIBUF[2]\ : BIBUF
port map(PAD => PAD(2), D => Data(2), E => Trien, Y => Y(2));

\BIBUF[6]\ : BIBUF
port map(PAD => PAD(6), D => Data(6), E => Trien, Y => Y(6));

\BIBUF[4]\ : BIBUF
port map(PAD => PAD(4), D => Data(4), E => Trien, Y => Y(4));

\BIBUF[5]\ : BIBUF
port map(PAD => PAD(5), D => Data(5), E => Trien, Y => Y(5));

\BIBUF[0]\ : BIBUF
port map(PAD => PAD(0), D => Data(0), E => Trien, Y => Y(0));

\BIBUF[3]\ : BIBUF
port map(PAD => PAD(3), D => Data(3), E => Trien, Y => Y(3));

\BIBUF[7]\ : BIBUF
port map(PAD => PAD(7), D => Data(7), E => Trien, Y => Y(7));

\BIBUF[1]\ : BIBUF
port map(PAD => PAD(1), D => Data(1), E => Trien, Y => Y(1));


end DEF_ARCH; 