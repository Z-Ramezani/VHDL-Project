package matrix is
type matrix is array (0 to 2 , 0 to 2 ) of integer;
end matrix;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.matrix.all;


entity M2 is port(
mtx1 , mtx2 , mtx3: IN matrix;
d0 , d1, d2 : OUT integer;
request , ack : in bit);
end M2;
architecture Behavioral of M2 is

begin

	D0<= (mtx1(0,0)*(mtx1(2,2)*mtx1(1,1)-(mtx1(1,2)*mtx1(2,1))))-(mtx1(0,1)*((mtx1(1,0)*mtx1(2,2))-(mtx1(2,0)*mtx1(1,2))))+(mtx1(0,2)*((mtx1(1,0)*mtx1(2,1))-(mtx1(2,0)*mtx1(1,1))));
	D1<= (mtx2(0,0)*(mtx2(2,2)*mtx2(1,1)-(mtx2(1,2)*mtx2(2,1))))-(mtx2(0,1)*((mtx2(1,0)*mtx2(2,2))-(mtx2(2,0)*mtx2(1,2))))+(mtx2(0,2)*((mtx2(1,0)*mtx2(2,1))-(mtx2(2,0)*mtx2(1,1))));
	D2<= (mtx3(0,0)*(mtx3(2,2)*mtx3(1,1)-(mtx3(1,2)*mtx3(2,1))))-(mtx3(0,1)*((mtx3(1,0)*mtx3(2,2))-(mtx3(2,0)*mtx3(1,2))))+(mtx3(0,2)*((mtx3(1,0)*mtx3(2,1))-(mtx3(2,0)*mtx3(1,1))));

end Behavioral;
