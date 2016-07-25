--updated 2016.3.3
-- Number of Slices:                       68  out of   1792     3%  
-- Number of Slice Flip Flops:             85  out of   3584     2%  
-- Number of 4 input LUTs:                115  out of   3584     3%  
-- Number of IOs:                          19
-- Number of bonded IOBs:                  19  out of    195     9%  
-- Number of GCLKs:                         3  out of     24    12%  





--Device utilization summary:
-----------------------------
--
--Selected Device : 3s200aft256-5 
--
-- Number of Slices:                       72  out of   1792     4%  
-- Number of Slice Flip Flops:             87  out of   3584     2%  
-- Number of 4 input LUTs:                124  out of   3584     3%  
-- Number of IOs:                          19
-- Number of bonded IOBs:                  19  out of    195     9%  
-- Number of GCLKs:                         4  out of     24    16%  

---------------------------



 
 
 
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;

entity top is
	port(
		clk : in std_logic ;
		start_stop_in, split_reset_in : in std_logic;
		seg : out std_logic_vector ( 7 downto 0); -- seg
		dig : out std_logic_vector ( 8 downto 1) -- dig
	);
end top;


architecture Behavioral of top is
	component clkdivider
    Port ( 
		clk_in : in  STD_LOGIC;
      clk_out : out  STD_LOGIC := '0'
	);
	end component;

	component outputlogic is
	port(
		seg : out std_logic_vector ( 7 downto 0); -- seg
		dig : out std_logic_vector ( 8 downto 1); -- dig
		clk_1kHz, latch, rst, en: in std_logic 
		);
	end component;
	
	component key_debounce is
	port(
		clk,key_in: in std_logic;
		key_out: out std_logic
		);
	end component;
	
	component control is
	port(
		clk, split_reset, start_stop : in std_logic;
		en, rst, latch : out std_logic
		);
	end component;
	
	
	signal clk_1kHz, start_stop, split_reset : std_logic := '0';
	
	
	--missing
	signal latch, rst, en: std_logic;
	--end missing
		
begin

	u_clkdivider : clkdivider 
		PORT MAP(
			clk_in => clk,
			clk_out => clk_1kHz
		);

	u_outputlogic : outputlogic
		port map(
			seg => seg,
			dig => dig,
			clk_1kHz => clk_1kHz, 
			latch => latch, 
			rst => rst, 
			en => en
		);

	u_start_stop : key_debounce
		port map(
			clk => clk_1kHz,
			key_in => start_stop_in,
			key_out => start_stop
		);
		
	u_split_reset : key_debounce
		port map(
			clk => clk_1kHz,
			key_in => split_reset_in,
			key_out => split_reset
		);
	
	u_control : control
	port map(
		clk => clk_1kHz,
		split_reset => split_reset,
		start_stop => start_stop,
		en => en,
		rst => rst,
		latch => latch
		);
	
	--missing
	--latch <= '0';
	--rst <= '0';
	--en <= '1';
	--end missing


end Behavioral;
