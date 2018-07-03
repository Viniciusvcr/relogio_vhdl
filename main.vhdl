library ieee ;
	use ieee.std_logic_1164.all ;
	use ieee.numeric_std.all ;
	use work.ffjk_package.all;

ENTITY cont_sinc_mod6 IS
	PORT(j, k, clr, clk : IN STD_LOGIC;
		q, qbar : BUFFER STD_LOGIC_VECTOR (2 DOWNTO 0));
END cont_sinc_mod6;

ENTITY cont_sinc_mod10 IS
	PORT(j, k, clr, clk : IN STD_LOGIC;
		q, qbar : BUFFER STD_LOGIC_VECTOR (3 DOWNTO 0));
END cont_sinc_mod10;

ENTITY and_2 IS
	PORT(a, b : IN BIT
		s : OUT BIT);
END and_2;

ARCHITECTURE arch_and_2 OF and_2 IS
BEGIN
	s <= a AND b;
END arch_and_2;

ARCHITECTURE arch_cont_sinc_mod6 OF cont_sinc_mod6 IS
COMPONENT and_2 IS
	PORT(a, b : IN BIT
		s : OUT BIT);
END COMPONENT;

SIGNAL and_mod_6, clear, clock : BIT;

BEGIN
	FF1 : ffjk PORT MAP('1', '1', clear, clock, q(2), qbar(2));
	FF2 : ffjk PORT MAP(q(2), q(2), clear, clock, q(1), qbar(1));
	MO6 : and_2 PORT MAP(q(2), q(1), and_mod_6);
	FF3 : ffjk PORT MAP(and_mod_6, and_mod_6, clear, clock, q(0), qbar(0));

END arch_cont_sinc_mod6;