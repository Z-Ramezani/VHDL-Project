-- TestBench Template 
package matrix is
type matrix is array (0 to 2 , 0 to 2 ) of integer;
end matrix;

  LIBRARY ieee;
  USE ieee.std_logic_1164.ALL;
  USE ieee.numeric_std.ALL;
  use work.matrix.all;

  ENTITY testbench IS
  END testbench;

  ARCHITECTURE behavior OF testbench IS 

          COMPONENT m1
          PORT(
            clk : in std_logic;
				input1 , input2 : in std_logic_vector(0 to 7);
				output : out std_logic_vector(0 to 15);
				mtx1 , mtx2 , mtx3: IN matrix;
				request : in bit;
				result : out integer 
                  );
          END COMPONENT;

         signal tclk : std_logic;
			signal tinput1 , tinput2 :  std_logic_vector(0 to 7);
			signal toutput : std_logic_vector(0 to 15) := "0000000000000000";
			signal tmtx1 , tmtx2 , tmtx3: matrix;
			signal trequest : bit;
			signal tresult : integer;
          

  BEGIN
  uut: m1 PORT MAP(tclk, tinput1, tinput2, toutput, tmtx1 , tmtx2 , tmtx3,trequest,tresult );

			tinput1 <= "10101010";
			tinput2 <= "00110011";
			tmtx1(0,0) <= 1;	tmtx1(0,1) <= 1;	tmtx1(0,2) <= 1;
			tmtx1(1,0) <= 0; 	tmtx1(1,1) <= 0;  tmtx1(1,2) <= 1;	
			tmtx1(2,0) <= 1; 	tmtx1(2,1) <= 0;  tmtx1(2,2) <= 0;	
			tmtx2(0,0) <= 1;	tmtx2(0,1) <= 1;	tmtx2(0,2) <= 1;
			tmtx2(1,0) <= 0; 	tmtx2(1,1) <= 0;  tmtx2(1,2) <= 1;	
			tmtx2(2,0) <= 1; 	tmtx2(2,1) <= 0;  tmtx2(2,2) <= 0;		
			tmtx3(0,0) <= 1;	tmtx3(0,1) <= 1;	tmtx3(0,2) <= 1;
			tmtx3(1,0) <= 0; 	tmtx3(1,1) <= 0;  tmtx3(1,2) <= 1;	
			tmtx3(2,0) <= 1; 	tmtx3(2,1) <= 0;  tmtx3(2,2) <= 0;	

     clock : PROCESS
     BEGIN
			tclk <= '1';
			wait for 50 ns; 
			tclk <='0';		
			wait for 50 ns;
     END PROCESS clock;
 		
     request : PROCESS
     BEGIN
			wait for 25 ns; 
			trequest <= '1';
			wait for 25 ns; 
			trequest <= '0';
     END PROCESS request;

  END;
