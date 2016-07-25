library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity clkdivider is
    Port ( clk_in : in  STD_LOGIC;
           clk_out : out  STD_LOGIC := '0');
end clkdivider;

architecture Behavioral of clkdivider is
--	-- input frequency : 48MHz
--	constant f_input : integer := 48000000;
--	-- output frequency : 1kHz
--	constant f_output : integer := 800;
--
--	constant cnt_max : integer := f_input/f_output-1;
constant cnt_max : std_logic_vector(15 downto 0) := "1110101001011111";--59999;
signal count : std_logic_vector(15 downto 0) := "0000000000000000"; 
begin
	process( clk_in) -- divider
	begin
		if rising_edge(clk_in) then
--			if count < cnt_max then
--				clk_out <= '0';
--				count := count + 1;
--			else
--				count := 0;
--				clk_out <= '1';
--			end if;
			if count = cnt_max then
				count <= "0000000000000000";
				clk_out <= '1';
			else
				clk_out <= '0';
				count <= count + 1;
			end if;
		end if;
	end process;

end Behavioral;

