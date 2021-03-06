library ieee ;
	use ieee.std_logic_1164.all ;
	use ieee.numeric_std.all ;

ENTITY ffjk IS
	PORT(j, k, clr, clk : IN BIT;
		q, qbar : BUFFER BIT);
END ffjk;

ARCHITECTURE arch OF ffjk IS
BEGIN
	PROCESS(j,k,clr,clk)
	VARIABLE qv, qvbar : BIT;
	BEGIN
		IF(clr = '0') THEN
			qv := '0';
			qvbar := NOT qv;
		ELSIF(clk'EVENT AND clk = '0') THEN
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
		PORT(j, k, clr, clk : IN BIT;
			q, qbar : BUFFER BIT);
	END COMPONENT;
END ffjk_package;