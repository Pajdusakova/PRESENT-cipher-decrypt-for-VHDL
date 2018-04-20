library IEEE;
use IEEE.std_logic_1164.all;

library work;
use work.array_roundkey.all;

entity present_decrypt_80 is
	port( clk: in std_logic;
			D3,D2,D1,D0: out std_logic_vector(7 downto 0));
end present_decrypt_80;

architecture rtl of present_decrypt_80 is
	signal cipher: std_logic_vector(63 downto 0) := (others=>'0');
	signal key: std_logic_vector(79 downto 0) := (others=>'0');
	signal plaintxt: std_logic_vector(63 downto 0);
	signal roundkey: rk;
	component show_16digit is
		port( clk: in std_logic;
				C: in std_logic_vector(63 downto 0);
				D3,D2,D1,D0: out std_logic_vector(7 downto 0));
	end component;
	component generateRoundKeys is
		port( X: in std_logic_vector(79 downto 0);
				Y: out rk);
	end component;
	component decryption is
		port( X: in std_logic_vector(63 downto 0);
				roundkey: in rk;
				Y: out std_logic_vector(63 downto 0));
	end component;
	component sBoxLayer_dec is
	port( X: in std_logic_vector(63 downto 0);
			Y: out std_logic_vector(63 downto 0));
	end component;
begin
	--A:sBoxLayer_dec port map("0000000100100011010001010110011110001001101010111100110111101111", plaintxt);
	UU1:generateRoundKeys port map(key,roundkey);
	UU2:decryption port map(cipher,roundkey,plaintxt);
	U:show_16digit port map(clk,plaintxt,D3,D2,D1,D0);
end rtl;