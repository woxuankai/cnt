----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:41:09 06/26/2013 
-- Design Name: 
-- Module Name:    bcd2seg - Behavioral 
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity bcd2seg is
	port(bcd_code:in std_logic_vector(3 downto 0);
			--ncs:out std_logic;
			seg:out std_logic_vector(6 downto 0)
			);
end bcd2seg;

architecture Behavioral of bcd2seg is

begin
	--ncs<='0';
	process(bcd_code)
	begin
		case bcd_code is
			when "0000"=>seg<="0000001";--0
			when "0001"=>seg<="1001111";--1
			when "0010"=>seg<="0010010";--2
			when "0011"=>seg<="0000110";--3
			when "0100"=>seg<="1001100";--4
			when "0101"=>seg<="0100100";--5
			when "0110"=>seg<="0100000";--6
			when "0111"=>seg<="0001111";--7
			when "1000"=>seg<="0000000";--8
			when "1001"=>seg<="0000100";--9
			when "1010"=>seg<="1111110";--' '<=10
			when "1011"=>seg<="1111110";--'-'<=11
			when others=>seg<="1111111";
		end case;
	end process;



end Behavioral;

