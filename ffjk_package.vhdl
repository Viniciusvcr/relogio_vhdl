library ieee ;
	use ieee.std_logic_1164.all ;
	use ieee.numeric_std.all ;

ENTITY ffjk IS
	PORT(j, k, clr, clk : IN STD_LOGIC
		q, qbar : BUFFER STD_LOGIC);
END ffjk;

ARCHITECTURE arch OF ffjk IS
BEGIN
	PROCESS(j,k,clr,clk)
	VARIABLE qv, qvbar : STD_LOGIC;
	BEGIN
		IF(clr = '0') THEN
			qv := '0'
			qvbar := NOT qv;
		ELSIF(falling_edge(clk)) THEN
			IF(j = '1' AND k = '0') THEN
				qv := '1';
				qvbar := NOT qv;
			ELSIF(j = '0' AND k = '1') THEN
				qv := '0';
				qvbar := NOT qv;
			ELSIF(j = '1' AND k = '1') THEN
				qv := NOT qv;
				qvbar := NOT qv;
			ELSE
				qv := qv;
				qvbar := NOT qv;
			END IF;
		END IF;
		q <= qv;
		qbar <= qvbar;
	END PROCESS;
END arch;

PACKAGE ffjk_package IS
	COMPONENT ffjk
		PORT(j, k, clr, clk : IN STD_LOGIC
			q, qbar : BUFFER STD_LOGIC);
	END COMPONENT;
END ffjk_package;