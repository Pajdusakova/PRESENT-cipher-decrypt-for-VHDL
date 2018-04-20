library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity sBoxLayer_dec is
	port( X: in std_logic_vector(63 downto 0);
			Y: out std_logic_vector(63 downto 0));
end sBoxLayer_dec;

architecture rtl of sBoxLayer_dec is
	type s is array(0 to 15) of std_logic_vector(3 downto 0);
	constant sbox_inv: s := ("0101", "1110", "1111", "1000", "1100", "0001", "0010", "1101", "1011", "0100", "0110", "0011", "0000", "0111", "1001", "1010");
begin
	Y<=sbox_inv(conv_integer(X(63 downto 60))) & 
		sbox_inv(conv_integer(X(59 downto 56))) & 
		sbox_inv(conv_integer(X(55 downto 52))) & 
		sbox_inv(conv_integer(X(51 downto 48))) & 
		sbox_inv(conv_integer(X(47 downto 44))) & 
		sbox_inv(conv_integer(X(43 downto 40))) & 
		sbox_inv(conv_integer(X(39 downto 36))) & 
		sbox_inv(conv_integer(X(35 downto 32))) & 
		sbox_inv(conv_integer(X(31 downto 28))) & 
		sbox_inv(conv_integer(X(27 downto 24))) & 
		sbox_inv(conv_integer(X(23 downto 20))) & 
		sbox_inv(conv_integer(X(19 downto 16))) & 
		sbox_inv(conv_integer(X(15 downto 12))) & 
		sbox_inv(conv_integer(X(11 downto  8))) & 
		sbox_inv(conv_integer(X( 7 downto  4))) & 
		sbox_inv(conv_integer(X( 3 downto  0)));
end rtl;