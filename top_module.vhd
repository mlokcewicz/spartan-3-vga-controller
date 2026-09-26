----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:40:54 09/25/2026 
-- Design Name: 
-- Module Name:    top_module - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
entity top_module is
   port ( 
          mclk     : in    std_logic; 
	       btn      : in    std_logic_vector (3 downto 0); 
          sw       : in    std_logic_vector (2 downto 0); 
          OutBlue  : out   std_logic_vector (2 downto 1); 
          OutGreen : out   std_logic_vector (2 downto 0); 
          OutRed   : out   std_logic_vector (2 downto 0); 
          HS       : out   std_logic; 
          VS       : out   std_logic;
			 Led      : out   std_logic_vector(7 downto 0)
			);
end top_module;

architecture Structural of top_module is

	signal x_pos    : integer range 0 to 639;
	signal y_pos    : integer range 0 to 479;
	signal color_set_int : std_logic_vector(2 downto 0);


   component DispCtrl
      port ( ck       : in    std_logic; 
             HS       : out   std_logic; 
             VS       : out   std_logic; 
             outRed   : out   std_logic_vector (2 downto 0); 
             outGreen : out   std_logic_vector (2 downto 0); 
             outBlue  : out   std_logic_vector (2 downto 1);
				 x        : in integer range 0 to 639;
             y        : in integer range 0 to 479;
				 color_set : in std_logic_vector(2 downto 0)
				);
   end component;
   
   component ButtonCtrl
      port ( btn   : in   std_logic_vector (3 downto 0); 
				 sw    : in   std_logic_vector (2 downto 0);
				 x     : out    integer range 0 to 639;
				 y     : out    integer range 0 to 479;
				 color_set : out std_logic_vector(2 downto 0);
				 ck    : in std_logic
			  );
   end component;
   
begin

   DispCtrlInst : DispCtrl
      port map (
		          ck=>mclk,
                HS=>HS,
                VS=>VS,
                outRed(2 downto 0)=>OutRed(2 downto 0),
                outGreen(2 downto 0)=>OutGreen(2 downto 0),
                outBlue(2 downto 1)=>OutBlue(2 downto 1),
					 x=>x_pos,
					 y=>y_pos,
					 color_set=>color_set_int
					 );
   
   ButtonCtrlInst : ButtonCtrl
      port map (
		          btn(3 downto 0)=>btn(3 downto 0),
                sw(2 downto 0)=>sw(2 downto 0),
					 x=>x_pos,
					 y=>y_pos,
					 color_set=>color_set_int,
					 ck=>mclk
				    );
	
   -- Add load to stabilize the internal oscillator
	Led <= x"FF";
   
end Structural;



