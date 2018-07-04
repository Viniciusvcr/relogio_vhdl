LIBRARY ieee;
	USE ieee.std_logic_1164.all;
	USE ieee.numeric_std.all;
LIBRARY work;
	USE work.ffjk_package.all;

ENTITY cont_sinc_mod6 IS
	PORT(entrada, clr, clk : IN BIT;
		q, qbar : BUFFER BIT_VECTOR (2 DOWNTO 0));
END cont_sinc_mod6;

ENTITY cont_sinc_mod10 IS
	PORT(entrada, clr, clk : IN BIT;
		q, qbar : BUFFER BIT_VECTOR (3 DOWNTO 0));
END cont_sinc_mod10;

ENTITY and_2 IS
	PORT(a, b : IN BIT;
		s : OUT BIT);
END and_2;

ARCHITECTURE arch_and_2 OF and_2 IS
BEGIN
	s <= a AND b;
END arch_and_2;

ARCHITECTURE arch_cont_sinc_mod6 OF cont_sinc_mod6 IS
COMPONENT and_2 IS
	PORT(a, b : IN BIT;
		s : OUT BIT);
END COMPONENT;

SIGNAL and_mod_6_1, and_mod_6_2 : BIT;

BEGIN
	FF0 : ffjk PORT MAP(entrada, entrada, clr, clk, q(0), qbar(0));
	AND1: and_2 PORT MAP(q(0), qbar(0), and_mod_6_1);
	FF1 : ffjk PORT MAP(and_mod_6_1, q(0), clr, clk, q(1), qbar(1));
	AND2: and_2 PORT MAP(q(0), q(1), and_mod_6_2);
	FF2 : ffjk PORT MAP(and_mod_6_2, q(0), clr, clk, q(2), qbar(2));
END arch_cont_sinc_mod6;

ARCHITECTURE arch_cont_sinc_mod10 OF cont_sinc_mod10 IS
COMPONENT and_2 IS
	PORT(a, b : IN BIT;
		s : OUT BIT);
END COMPONENT;

SIGNAL and_mod_10_1, and_mod_10_2, and_mod_10_3 : BIT;

BEGIN
	FF0 : ffjk PORT MAP(entrada, entrada, clr, clk, q(0), qbar(0));
	AND1: and_2 PORT MAP(q(0), qbar(3), and_mod_10_1);
	FF1 : ffjk PORT MAP(and_mod_10_1, q(0), clr, clk, q(1), qbar(1));
	AND2: and_2 PORT MAP(q(0), q(1), and_mod_10_2);
	FF2 : ffjk PORT MAP(and_mod_10_2, and_mod_10_2, clr, clk, q(2), qbar(2));
	AND3: and_2 PORT MAP(and_mod_10_2, q(2), and_mod_10_3);
	FF3 : ffjk PORT MAP(and_mod_10_3, q(0), clr, clk, q(3), qbar(3));
END arch_cont_sinc_mod10;

PACKAGE cont_sinc_package IS
	COMPONENT cont_sinc_mod6
		PORT(entrada, clr, clk : IN STD_LOGIC;
			q, qbar : OUT BIT_VECTOR(2 DOWNTO 0));
	END COMPONENT;

	COMPONENT cont_sinc_mod10 IS
		PORT(entrada, clr, clk : IN STD_LOGIC;
			q, qbar : BUFFER BIT_VECTOR (3 DOWNTO 0));
	END COMPONENT;

	COMPONENT and_2 IS
		PORT(a, b : IN BIT;
			s : OUT BIT);
	END COMPONENT;
END cont_sinc_package;