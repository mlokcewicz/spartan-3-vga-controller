library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity DispCtrl is
  Port (ck: in std_logic;  -- 50MHz
        HS: out std_logic;	-- horizontal synchro signal					
        VS: out std_logic;	-- verical synchro signal 

        outRed  : out std_logic_vector(2 downto 0); -- final color
        outGreen: out std_logic_vector(2 downto 0); -- outputs
        outBlue : out std_logic_vector(2 downto 1);
		  
        x : in integer range 0 to 639;
        y : in integer range 0 to 479
       );
end DispCtrl;

architecture Behavioral of DispCtrl is

-- constants for Synchro module
  constant PAL:integer:=640;		--Pixels/Active Line (pixels)
  constant LAF:integer:=480;		--Lines/Active Frame (lines)
  constant PLD: integer:=800;	   --Pixel/Line Divider
  constant LFD: integer:=521;	   --Line/Frame Divider
  constant HPW:integer:=96;		--Horizontal synchro Pulse Width (pixels)
  constant HFP:integer:=16;		--Horizontal synchro Front Porch (pixels)
  constant VPW:integer:=2;		   --Verical synchro Pulse Width (lines)
  constant VFP:integer:=10;		--Verical synchro Front Porch (lines)

-- signals for VGA Demo
  signal intHcnt: integer range 0 to PLD-1;  -- PLD-1 - horizontal counter
  signal intVcnt: integer range 0 to LFD-1;  -- LFD-1 - verical counter

  signal ck25MHz: std_logic;		-- ck 25MHz
  
  signal color : std_logic_vector(7 downto 0);

begin

  -- set RGB, HS, VS
  outRed   <= color(7 downto 5);
  outGreen <= color(4 downto 2);
  outBlue  <= color(1 downto 0);
  
  HS <= '0' when (intHcnt >= PAL + HFP and intHcnt < PAL + HFP + HPW)
				else '1';

  VS <= '0' when (intVcnt >= LAF + VFP and intVcnt < LAF + VFP + VPW)
				else '1';

  -- divide 50MHz clock to 25MHz
  div2: process(ck)
  begin
    if ck'event and ck = '1' then
	   ck25MHz <= not ck25MHz; 
    end if;
  end process;	 

  -- generate Horizontal and Vertical synchro signals
  syncro: process (ck25MHz)
  begin

  if ck25MHz'event and ck25MHz='1' then
    if intHcnt=PLD-1 then
       intHcnt<=0;
      if intVcnt=LFD-1 then intVcnt<=0;
      else intVcnt<=intVcnt+1;
      end if;
    else intHcnt<=intHcnt+1;
    end if;
end if;
end process; 

  mixer: process(intHcnt, intVcnt) 
  begin
    if intHcnt < PAL and intVcnt < LAF then	-- in the active screen
			if (intVcnt < 160) then 	-- red strip
				color <= x"e0";
			elsif (intVcnt < 320) then -- green strip
				color <= x"1c";
			else 								-- blue strip
				color <= x"03";
			end if;
    else
		color <= x"00";
    end if;   
  end process;

end Behavioral;
