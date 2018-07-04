LIBRARY ieee;
	USE ieee.std_logic_1164.all;

LIBRARY work;
	USE work.cont_sinc_package.all;
	USE work.decod_bcd_package.all;

ENTITY relogio_vhdl IS
	PORT(entrada, clk, clr : IN BIT;
		dez_min, uni_min, dez_seg, uni_seg : OUT BIT_VECTOR(6 DOWNTO 0));
END relogio_vhdl;

ARCHITECTURE arch_relogio_vhdl OF relogio_vhdl IS

SIGNAL seg_uni, seg_dez, min_uni, min_dez, qbarra_4 : BIT_VECTOR(3 DOWNTO 0);
SIGNAL min_dez_2, dez_seg_2, qbarra_3 : BIT_VECTOR(2 DOWNTO 0);
SIGNAL clk_dez_min, clk_dez_seg : BIT;

BEGIN
	unidade_seg : cont_sinc_mod10 PORT MAP(entrada, clr, clk, seg_uni, qbarra_4);
	clock_dez_seg : and_2 PORT MAP(seg_uni(0), seg_uni(3), clk_dez_seg);
	dezena_seg : cont_sinc_mod6 PORT MAP(entrada, clr, clk_dez_seg, dez_seg_2, qbarra_3);
	seg_dez <= '0'&dez_seg_2; --Resultado concatenado com 0 para entrada do decodificador BCD

	unidade_min : cont_sinc_mod10 PORT MAP(entrada, clr, seg_dez(2), min_uni, qbarra_4);
	clock_dez_min : and_2 PORT MAP(min_uni(0), min_uni(3), clk_dez_min);
	dezena_min : cont_sinc_mod6 PORT MAP(entrada, clr, clk_dez_min, min_dez_2, qbarra_3);
	min_dez <= '0'&min_dez_2; --Resultado concatenado com 0 para entrada do decodificador BCD

	bcd_dez_min : decod_bcd PORT MAP(min_dez, dez_min);
	bcd_uni_min : decod_bcd PORT MAP(min_uni, uni_min);
	bcd_dez_seg : decod_bcd PORT MAP(seg_dez, dez_seg);
	bcd_uni_seg : decod_bcd PORT MAP(seg_uni, uni_seg);
END arch_relogio_vhdl;