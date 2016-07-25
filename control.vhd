library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity control is
	port(
		clk, split_reset, start_stop : in std_logic;
		en, rst, latch : out std_logic
		);
end control;

architecture Behavioral of control is
     
	  signal c_state: std_logic_vector(2 downto 0):="111";
     signal n_state: std_logic_vector(2 downto 0);
     signal a: std_logic_vector(1 downto 0);
	  
begin
	
--	en <=  start_stop;
--	rst <=  split_reset;
--	latch <= start_stop and split_reset;
	
	
a(1)<=start_stop;  
a(0)<=split_reset;

process(c_state, a )
begin
	case c_state is
		when "111" => case a is           ----¸´Î»×´Ì¬
							when "10" => n_state<="011";
							when others => n_state<="111";
							end case;
		when "011"=> case a is            ----Õý³£ÏÔÊ¾×´Ì¬
							when "01" => n_state<="010";
							when "10" => n_state<="001";
							when others => n_state<="011";
							end case;
		 when "001"=>  case a is           ----ÔÝÍ£×´Ì¬
							when "01" => n_state<="111";
							when "10" => n_state<="011";
							when others => n_state<="001";
							end case;
		 when "010"=>  case a is           ----ÏÔÊ¾Ëø¶¨×´Ì¬
							when "01" => n_state<="011";
							when others => n_state<="010";
							end case;
		 when others=> n_state<="111";
	  end case;
end process;

p2:process(clk)
begin
     if rising_edge(clk) then
        c_state <= n_state;
     end if;
end process;

rst <= c_state(2);
en <= c_state(1);
latch <=not  c_state(0);

--
--process(c_state)
--begin
--	case c_state is
--		----¸´Î»×´Ì¬
--		when "111" =>
--			rst <= '1';
--			en <= '0';
--			latch <= '1'
--		when "011"=> 
--		----Õý³£ÏÔÊ¾×´Ì¬
--			case a is            
--							when "01" => n_state<="010";
--							when "10" => n_state<="001";
--							when others => n_state<="011";
--							end case;
--		 when "001"=>  case a is           ----ÔÝÍ£×´Ì¬
--							when "01" => n_state<="111";
--							when "10" => n_state<="011";
--							when others => n_state<="001";
--							end case;
--		 when "010"=>  case a is           ----ÏÔÊ¾Ëø¶¨×´Ì¬
--							when "01" => n_state<="011";
--							when others => n_state<="010";
--							end case;
--		 when others=> n_state<="111";
--	  end case;
--end process;




end Behavioral;
