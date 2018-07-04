library ieee ;
	use ieee.std_logic_1164.all ;
	use ieee.numeric_std.all ;
	use work.ffjk_package.all;

ENTITY cont_sinc_mod6 IS
	PORT(j, k, clr, clk : IN STD_LOGIC;
		q, qbar : BUFFER BIT_VECTOR (2 DOWNTO 0));
END cont_sinc_mod6;

ENTITY cont_sinc_mod10 IS
	PORT(j, k, clr, clk : IN STD_LOGIC;
		q, qbar : BUFFER BIT_VECTOR (3 DOWNTO 0));
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
	clear <= '1';
	FF1 : ffjk PORT MAP('1', '1', clear, clock, q(2), qbar(2));
	FF2 : ffjk PORT MAP(q(2), q(2), clear, clock, q(1), qbar(1));
	MO6 : and_2 PORT MAP(q(2), q(1), and_mod_6);
	FF3 : ffjk PORT MAP(and_mod_6, and_mod_6, clear, clock, q(0), qbar(0));
END arch_cont_sinc_mod6;

ARCHITECTURE arch_cont_sinc_mod10 OF cont_sinc_mod10 IS
COMPONENT and_2 IS
	PORT(a, b : IN BIT
		s : OUT BIT);
END COMPONENT;

SIGNAL and_mod_10_1, and_mod_10_2, and_mod_10_3, clear, clock : BIT;

BEGIN
	clear <= '1';
	FF1 : ffjk PORT MAP('1', '1', clear, clock, q(3), qbar(3));
	FF2 : ffjk PORT MAP(and_mod_10_1, q(3), clear, clock, q(2), qbar(2));
	FF3 : ffjk PORT MAP(and_mod_10_2, and_mod_10_2, clear, clock, q(1), qbar(1));
	FF4 : ffjk PORT MAP(and_mod_10_3, q(3), clear, clock, q(0), qbar(0));
	AND1: and_2 PORT MAP(q(3), qbar(0), and_mod_10_1);
	AND2: and_2 PORT MAP(q(3), q(2), and_mod_10_2);
	AND3: and_2 PORT MAP(and_mod_10_2, q(1), and_mod_10_3);
END arch_cont_sinc_mod10;
