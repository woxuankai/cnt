library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity onelatch is
	port(
		latch : in std_logic; --active high
		bcd_1, bcd_2, bcd_3, bcd_4,bcd_5,bcd_6,bcd_7,bcd_8 : out std_logic_vector( 3 downto 0) := "0000";
		min_L, min_H, sec_L, sec_H, centisec_L, centisec_H : in std_logic_vector( 3 downto 0)
		);
end onelatch;

architecture Behavioral of onelatch is
begin
	bcd_3 <= "1011";
	bcd_6 <= "1011";

	process(latch, min_H, min_L, sec_L, sec_H, centisec_L, centisec_H)
	begin
		if latch = '0' then
			bcd_8 <= min_H;
			bcd_7 <= min_L;
			bcd_5 <= sec_H;
			bcd_4 <= sec_L;
			bcd_2 <= centisec_H;
			bcd_1 <= centisec_L;
		end if;
	end process;
end Behavioral;

