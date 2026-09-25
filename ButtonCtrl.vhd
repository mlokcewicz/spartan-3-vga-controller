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
			  sw   : in   std_logic_vector (2 downto 0);
				x   : out integer range 0 to 639;
				y   : out integer range 0 to 479;
            color_set : out std_logic_vector(2 downto 0);
				ck: in std_logic  -- 50MHz
			 );
end ButtonCtrl;

architecture Behavioral of ButtonCtrl is


constant MOVE_DIV : integer := 500000; -- 50 MHz / 500000 = 100 Hz

signal move_cnt : integer range 0 to MOVE_DIV-1 := 0;
signal x_reg : integer range 0 to 639 := 100;
signal y_reg : integer range 0 to 479 := 100;

begin

process(ck)

begin
    if rising_edge(ck) then

		  if move_cnt = MOVE_DIV-1 then
            move_cnt <= 0;

            if btn(3) = '1' then          -- LEFT
                if x_reg > 0 then
                    x_reg <= x_reg - 1;
                end if;
            end if;

            if btn(2) = '1' then          -- RIGHT
                if x_reg < 639 then
                    x_reg <= x_reg + 1;
                end if;
            end if;

            if btn(1) = '1' then          -- UP
                if y_reg > 0 then
                    y_reg <= y_reg - 1;
                end if;
            end if;

            if btn(0) = '1' then          -- DOWN
                if y_reg < 479 then
                    y_reg <= y_reg + 1;
                end if;
            end if;

        else
            move_cnt <= move_cnt + 1;
        end if;

    end if;
end process;

 x <= x_reg;
 y <= y_reg;
 color_set <= sw;

end Behavioral;





