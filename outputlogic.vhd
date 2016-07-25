library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;

entity outputlogic is
	port(
		seg : out std_logic_vector ( 7 downto 0); -- seg
		dig : out std_logic_vector ( 8 downto 1); -- dig
		clk_1kHz, latch, rst, en: in std_logic 
	);
end outputlogic;


architecture Behavioral of outputlogic is
	component clkdivider
    Port ( 
		clk_in : in  STD_LOGIC;
      clk_out : out  STD_LOGIC := '0'
	);
	end component;
	
	component disp is
		port(
			seg : out std_logic_vector ( 7 downto 0); -- seg
			dig : out std_logic_vector ( 8 downto 1); -- dig
			clk_1kHz : in std_logic ;
			latch : in std_logic ;
			min_L, min_H, sec_L, sec_H, centisec_L, centisec_H : in std_logic_vector( 3 downto 0)
		);
	end component;

	component counter is
	port(
		min_L, min_H, sec_L, sec_H, centisec_L, centisec_H : out std_logic_vector( 3 downto 0);
		clk_1kHz, rst, en: in std_logic
	);
	end component;

	signal min_L, min_H, sec_L, sec_H, centisec_L, centisec_H : std_logic_vector( 3 downto 0);
		
begin
	u_disp : disp
		PORT MAP(
			seg => seg,
			dig => dig,
			clk_1kHz => clk_1kHz,
			latch => latch,
			min_L => min_L,
			min_H => min_H, 
			sec_L => sec_L, 
			sec_H => sec_H, 
			centisec_L => centisec_L, 
			centisec_H => centisec_H
		);
		
	u_counter : counter
		port map(
			min_L => min_L,
			min_H => min_H, 
			sec_L => sec_L, 
			sec_H => sec_H, 
			centisec_L => centisec_L, 
			centisec_H => centisec_H,
			clk_1kHz => clk_1kHz,
			rst => rst,
			en => en
		);
		
end Behavioral;
