library ieee;
	use ieee.std_logic_1164.all;
	use ieee.numeric_std.all;

ENTITY decod_bcd IS
	PORT(entrada : IN BIT_VECTOR(3 DOWNTO 0);
		segmentos : OUT BIT_VECTOR(6 DOWNTO 0));
END decod_bcd;

ARCHITECTURE logica OF decod_bcd IS
BEGIN
	segmentos <= "1111110" WHEN entrada = "0000" ELSE
                 "0110000" WHEN entrada = "0001" ELSE
                 "1101101" WHEN entrada = "0010" ELSE
                 "1111001" WHEN entrada = "0011" ELSE
                 "0110011" WHEN entrada = "0100" ELSE
                 "1011011" WHEN entrada = "0101" ELSE
                 "1011111" WHEN entrada = "0110" ELSE
                 "1110000" WHEN entrada = "0111" ELSE
                 "1111111" WHEN entrada = "1000" ELSE
                 "1111011" WHEN entrada = "1001";
END logica;

PACKAGE decod_bcd IS
	COMPONENT decod_bcd
		PORT(entrada : IN BIT_VECTOR(3 DOWNTO 0);
			segmentos : OUT BIT_VECTOR(6 DOWNTO 0));
	END COMPONENT;
END decod_bcd;