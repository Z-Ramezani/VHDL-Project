
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FA is
port (X, Y, CI: in std_logic; 
      Z, CO: out std_logic);
end entity FA;
architecture FARCH1 of FA is
begin
Z <= X xor Y xor CI;
CO <= (X and Y) or (X and CI) or (Y and CI);
end architecture FARCH1;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity adder is
  port (
        A, B: in std_logic_vector (0 to 7);
        Cin: in std_logic;
        S: out std_logic_vector (0 to 7);
        Cout: out std_logic
		  );
end adder;
architecture F8 OF adder IS
component FA 
 port (X, Y, CI: in std_logic; Z, CO: out std_logic);
end component;
signal C: std_logic_vector (0 to 8);
for all:FA use entity work.FA(FARCH1);

begin
 C(8) <= Cin;
 FAA: for i in 7 downto 1 generate
   FAA_i: FA port map (A(i), B(i), C(i), S(i), C(i+1));
	 end generate FAA;
	FAA_i: FA port map (A(0), B(0), C(0), S(0), cout);

end F8;