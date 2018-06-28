library ieee ;
	use ieee.std_logic_1164.all ;
	use ieee.numeric_std.all ;

ENTITY ffjk IS
	PORT(j, k, clr, clk : IN STD_LOGIC
		q, qbar : OUT STD_LOGIC);
END ffjk;

ARCHITECTURE arch OF ffjk IS
BEGIN
	PROCESS(j,k,clr,clk)
	VARIABLE qv, qvbar : STD_LOGIC;
	BEGIN
		IF(clr = '0') THEN
			qv := '0'
			qvbar := NOT qv;
		ELSIF(falling_edge(clk))
		END IF;
	END PROCESS;
END arch;