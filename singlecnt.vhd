----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:57:12 03/01/2016 
-- Design Name: 
-- Module Name:    singlecnt - Behavioral 
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
use IEEE.STD_LOGIC_unsigned.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity singlecnt is
	port(
		cntmax : in std_logic_vector( 3 downto 0);
		
		cnt_out : out std_logic_vector( 3 downto 0);
		carry_out : out std_logic;
		
		carry_in : in std_logic;
		
		clk : in std_logic;
		rst : in std_logic
	);
end singlecnt;

architecture Behavioral of singlecnt is
signal cnt : std_logic_vector( 3 downto 0) := "0000";
signal carry : std_logic := '0';
begin
	carry_out <= carry and carry_in;
	
	cnt_out <= cnt;
	
	process(clk,rst)
	begin
		if rst='1' then
			cnt <= "0000";
		else
			if (rising_edge(clk) 
				and carry_in='1') then
				if cnt < cntmax then
					cnt <= cnt + 1;
					if cnt = cntmax - 1 then
						carry <= '1';
					else
						carry <= '0';
					end if;
				elsif cnt = cntmax then
					cnt <= "0000";
					carry <= '0';
				else
					cnt <= "0000";
					carry <= '0';
				end if;
			end if;
		end if;
	end process;

	
	
end Behavioral;

