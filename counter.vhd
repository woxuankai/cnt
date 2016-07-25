library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;


entity counter is
	port(
		min_L, min_H, sec_L, sec_H, centisec_L, centisec_H : out std_logic_vector( 3 downto 0);
		clk_1kHz, rst, en: in std_logic
	);
end counter;

architecture Behavioral of counter is
signal clk : std_logic := '0'; --100Hz
signal cnt_8 : std_logic_vector(2 downto 0) := "000";
signal 	c_min_L,
			c_sec_L, c_sec_H, 
			c_centisec_L, c_centisec_H : std_logic;
			
component singlecnt is
	port(
		cntmax : in std_logic_vector( 3 downto 0);
		
		cnt_out : out std_logic_vector( 3 downto 0);
		carry_out : out std_logic;
		
		carry_in : in std_logic;
		
		clk : in std_logic;
		rst : in std_logic
	);
end component;

begin


u_centisec_L : singlecnt 
	port map(
			cntmax => "1001",
			cnt_out => centisec_L,
			carry_out => c_centisec_L,
			carry_in => '1',
			clk => clk,
			rst => rst
		);

u_centisec_H : singlecnt 
	port map(
			cntmax => "1001",
			cnt_out => centisec_H,
			carry_out => c_centisec_H,
			carry_in => c_centisec_L,
			clk => clk,
			rst => rst
		);

u_sec_L : singlecnt 
	port map(
			cntmax => "1001",
			cnt_out => sec_L,
			carry_out => c_sec_L,
			carry_in => c_centisec_H,
			clk => clk,
			rst => rst
		);

u_sec_H : singlecnt 
	port map(
			cntmax => "0101",
			cnt_out => sec_H,
			carry_out => c_sec_H,
			carry_in => c_sec_L,
			clk => clk,
			rst => rst
		);



u_min_L : singlecnt 
	port map(
			cntmax => "1001",
			cnt_out => min_L,
			carry_out => c_min_L,
			carry_in => c_sec_H,
			clk => clk,
			rst => rst
		);

u_min_H : singlecnt 
	port map(
			cntmax => "0101",
			cnt_out => min_H,
			carry_out => open,
			carry_in => c_min_L,
			clk => clk,
			rst => rst
		);





--divide from 1kHz to 100Hz
process(clk_1kHz)
begin
	if rising_edge(clk_1kHz) then
		cnt_8 <= cnt_8 + 1;
	end if;
end process;

clk <= cnt_8(0) and cnt_8(1) and cnt_8(2) and en;

end Behavioral;

