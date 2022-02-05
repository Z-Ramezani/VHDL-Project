library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;
use work.matrix.all;

entity M1 is port(
		clk : in std_logic;
		input1 , input2 : in std_logic_vector(0 to 7);
		output : out std_logic_vector(0 to 15);
		mtx1 , mtx2 , mtx3: IN matrix;
		request : in bit;
		result : out integer);
end M1;

architecture ALU of M1 is
component M2
	port(
mtx1 , mtx2 , mtx3: IN matrix;
d0 , d1, d2 : OUT integer;
request , ack : IN BIT);
end component;


function count_ones(s : std_logic_vector) return integer is
  variable temp : natural := 0;
begin
  for i in s'range loop
    if s(i) = '1' then temp := temp + 1; 
    end if;
  end loop;
  return temp;
end function count_ones;


type states is (ADD, SUB, MULT, XORR, START, ANDD, FINISH);
signal state : states :=SUB;
shared variable num , num2 : natural :=0;
signal out_temp : std_logic_vector(0 to 7):="00000000";
signal ack : bit := '0';
signal s0, s1, s2:  integer;
signal sum : std_logic_vector(0 to 7):="00000000";
begin
U1: M2 port map (mtx1,mtx2,mtx3, s0, s1, s2, request , ack);

process(clk , request , state)
begin
	if request = '1' then 
		result <= s0 * s1 * s2; 
		ack <= '1';
	end if;
if clk'event and clk='1' then
		case state is 
			when START =>
				state <= XORR;
		
			when XORR =>
				out_temp <= input1 XOR input2;			
				if count_ones(out_temp) < 4 then state <= ADD;
				else state <= ANDD;
				end if;
			
			when ANDD =>
				out_temp <= input1 AND input2;
				for i in 0 to 7 loop
					if out_temp(i)/='0' then 
						state <= FINISH;
						num2:=num2+1;
					end if;
				end loop;
				if num2=0 then state <= MULT; end if;
				num2:=0;
			
			when ADD =>
				out_temp <= input1+input2;			
				if input1(0) = '0' and input2(0)='0' and out_temp(0)='1' then
					state <= SUB;
				else if input1(0) = '1' and input2(0)='1' and out_temp(0)='0' then
					state <= SUB;
				else state<=FINISH;
				end if;
				end if;
			
			when MULT =>
				state <= ADD;	
				
			when SUB =>
				out_temp <= input1 - input2;	
				if out_temp < "00000000" then 
					state <=ADD;
				else state <= XORR;
			end if;
			
		when FINISH =>
			null;
end case;
end if;
end process;

process (clk,state)
begin
if clk'event and clk='1' then

	case state is
		when START =>
			output <= "0000000000000000";
		when XORR =>
			output <= "00000000" & out_temp;
		when ANDD =>
			output <= "00000000" & out_temp;
		when ADD =>
			output <= "00000000" & out_temp;
		when MULT =>
			output <= input1 * input2;
		when SUB =>
			output <= "00000000" & out_temp;
		when FINISH =>
			output <="UUUUUUUUUUUUUUUU";
end case;
end if;
end process;
end ALU;


