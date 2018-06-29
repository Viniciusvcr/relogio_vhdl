library ieee ;
	use ieee.std_logic_1164.all ;
	use ieee.numeric_std.all ;

ENTITY cont_sinc_mod6 IS
	PORT(j, k, clr, clk : IN STD_LOGIC;
		q, qbar : BUFFER STD_LOGIC_VECTOR (2 DOWNTO 0));
END cont_sinc_mod6;

ENTITY cont_sinc_mod10 IS
	PORT(j, k, clr, clk : IN STD_LOGIC;
		q, qbar : BUFFER STD_LOGIC_VECTOR (3 DOWNTO 0));
END cont_sinc_mod10;

ARCHITECTURE estrutural OF ffjk IS
BEGIN

END estrutural;