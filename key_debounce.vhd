----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:22:33 02/29/2016 
-- Design Name: 
-- Module Name:    test - Behavioral 
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity key_debounce is
	port(clk,key_in: in std_logic;
		key_out: out std_logic);
end key_debounce;

architecture Behavioral of key_debounce is
	signal cnt :std_logic_vector(2 downto 0);
	signal k1,k2 :std_logic;
begin
	U1:process(key_in,clk)
	begin
		if key_in = '1' then
			cnt<="000";
		elsif falling_edge(clk) then
			if cnt /= 7 then
				cnt<=cnt+1;
			end if;
		end if;
	end process;
	U2:process(clk)
	begin
		if falling_edge(clk) then
			if cnt /= 7 then
				k1<='0';
			else
				k1<='1';	
			end if;
			k2 <= k1;
		end if;
	end process;
	U3:key_out <= (not k1) and k2;
end Behavioral;
