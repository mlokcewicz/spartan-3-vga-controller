----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:20:15 09/25/2026 
-- Design Name: 
-- Module Name:    ButtonCtrl - Behavioral 
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

library UNISIM;
use UNISIM.VComponents.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ButtonCtrl is		  
	 Port ( btn  : in   std_logic_vector (3 downto 0); 
			  sw   : in   std_logic_vector (7 downto 0);
				x   : out integer range 0 to 639;
				y   : out integer range 0 to 479
			 );
end ButtonCtrl;

architecture Behavioral of ButtonCtrl is

begin

	x <= 100;
	y <= 100;

end Behavioral;





