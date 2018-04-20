library IEEE;
use IEEE.std_logic_1164.all;

library work;
use work.array_roundkey.all;

entity decryption is
	port( X: in std_logic_vector(63 downto 0);
			roundkey: in rk;
			Y: out std_logic_vector(63 downto 0));
end decryption;

architecture rtl of decryption is
	component sBoxLayer_dec is
		port( X: in std_logic_vector(63 downto 0);
				Y: out std_logic_vector(63 downto 0));
	end component;
	component pLayer_dec is
		port( X: in std_logic_vector(63 downto 0);
				Y: out std_logic_vector(63 downto 0));
	end component;
	type temp is array(0 to 31) of std_logic_vector(63 downto 0);
	signal bP: temp;	-- before permutate
	signal bS: temp;	-- before sBoxLayer
	signal bA: temp;	-- before add roundkey
	constant round: integer := 32;
begin
	bA(31)<=X;
	decrypting: for i in round-2 downto 0 generate
		bP(i)<=bA(i+1) xor roundkey(i+2);
		U2:pLayer_dec port map(bP(i),bS(i));
		U1:sBoxLayer_dec port map(bS(i),bA(i));
	end generate;
	Y<=bA(0) xor roundkey(1);
end rtl;