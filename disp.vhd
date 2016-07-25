library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;

entity disp is
	port(
		seg : out std_logic_vector ( 7 downto 0); -- seg
		dig : out std_logic_vector ( 8 downto 1); -- dig
		clk_1kHz : in std_logic ;
		latch : in std_logic ;
		min_L, min_H, sec_L, sec_H, centisec_L, centisec_H : in std_logic_vector( 3 downto 0)
	);
end disp;


architecture Behavioral of disp is
	component display_segment
		Port(
			seg : out std_logic_vector ( 7 downto 0); --to segs, active high
			dig : out std_logic_vector ( 8 downto 1); --to digs, active low
			clk : in std_logic;
			bcd_1,bcd_2,bcd_3,bcd_4,bcd_5,bcd_6,bcd_7,bcd_8 : in std_logic_vector (3 downto 0)
		);
	end component;
	
	component clkdivider
    Port ( 
		clk_in : in  STD_LOGIC;
      clk_out : out  STD_LOGIC := '0'
	);
	end component;
	
	component onelatch is
	port(
		latch : in std_logic; --active high
		bcd_1, bcd_2, bcd_3, bcd_4,bcd_5,bcd_6,bcd_7,bcd_8 : out std_logic_vector( 3 downto 0) := "0000";
		min_L, min_H, sec_L, sec_H, centisec_L, centisec_H : in std_logic_vector( 3 downto 0)
		);
	end component;

	signal bcd_1,bcd_2,bcd_3,bcd_4,bcd_5,bcd_6,bcd_7,bcd_8 :  std_logic_vector (3 downto 0);


begin
	u_display_segment : display_segment 
		PORT MAP(
			seg => seg,
			dig => dig,
			clk => clk_1kHz,
			bcd_1 => bcd_1,
			bcd_2 => bcd_2,
			bcd_3 => bcd_3,
			bcd_4 => bcd_4,
			bcd_5 => bcd_5,
			bcd_6 => bcd_6,
			bcd_7 => bcd_7,
			bcd_8 => bcd_8
		);

	u_onelatch : onelatch
	port map(
		latch => latch,
		bcd_1 => bcd_1, 
		bcd_2 => bcd_2, 
		bcd_3 => bcd_3, 
		bcd_4 => bcd_4,
		bcd_5 => bcd_5,
		bcd_6 => bcd_6,
		bcd_7 => bcd_7,
		bcd_8 => bcd_8,
		min_L => min_L, 
		min_H => min_H, 
		sec_L => sec_L, 
		sec_H => sec_H, 
		centisec_L => centisec_L, 
		centisec_H => centisec_H
		);


end Behavioral;
