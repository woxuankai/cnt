library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;

entity display_segment is
	Port(
		seg : out std_logic_vector ( 7 downto 0); --to segs, active high
		dig : out std_logic_vector ( 8 downto 1); --to digs, active low
		clk : in std_logic;
		bcd_1,bcd_2,bcd_3,bcd_4,bcd_5,bcd_6,bcd_7,bcd_8 : in std_logic_vector (3 downto 0)
		);
end display_segment;

architecture Behavioral of display_segment is
	signal digcnt : std_logic_vector ( 3 downto 0) ;--:= "0000" ;
	signal bcd_in : std_logic_vector ( 3 downto 0) := "0000";
	signal seg_out : std_logic_vector ( 7 downto 0);
   component bcd2seg
		port(
			bcd_code:in std_logic_vector(3 downto 0);
			seg:out std_logic_vector(6 downto 0)
			);
   end component;

begin
	u_bcd2seg :  bcd2seg
	PORT MAP(
		bcd_code => bcd_in,
		seg => seg_out( 7 downto 1)
	);
	seg_out(0) <= '1';-- DP always off
	--state
	process( clk )
	begin 
		if rising_edge(clk) then
			if digcnt < 7 then
				digcnt <= digcnt + 1;
			else
				digcnt <= "0000";
			end if;
		end if;
	end process;

	--chose
	process( digcnt )
	begin 
		case digcnt is 
			when "0000"    =>    bcd_in <= bcd_1;
			when "0001"    =>    bcd_in <= bcd_2;
			when "0010"    =>    bcd_in <= bcd_3;
			when "0011"    =>    bcd_in <= bcd_4;
			when "0100"    =>    bcd_in <= bcd_5;
			when "0101"    =>    bcd_in <= bcd_6;
			when "0110"    =>    bcd_in <= bcd_7;
			when "0111"    =>    bcd_in <= bcd_8;
			when others    =>    bcd_in <= "1010";--no disp
		end case;
	end process;
	
	seg <= seg_out;
	
	process( digcnt )
	begin 
		case digcnt is 
			when "0000"    =>    dig <= "11111110";
			when "0001"    =>	 dig <= "11111101";
			when "0010"    =>    dig <= "11111011";
			when "0011"    =>    dig <= "11110111";
			when "0100"    =>    dig <= "11101111";
			when "0101"    =>    dig <= "11011111";
			when "0110"    =>    dig <= "10111111";
			when "0111"    =>    dig <= "01111111";
			when others    =>    dig <= "11111111";--no disp
		end case;
	end process;
end Behavioral;
