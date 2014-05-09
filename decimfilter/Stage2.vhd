-- -------------------------------------------------------------
-- 
-- File Name: Q:\Users\Qlab\Documents\Blake\iirfilter\hdlsrc\polyphaseIIR\Stage2.vhd
-- Created: 2014-05-09 14:18:25
-- 
-- Generated by MATLAB 8.3 and HDL Coder 3.4
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: Stage2
-- Source Path: polyphaseIIR/IIRDecimFilter/Stage2
-- Hierarchy Level: 1
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE work.IIRDecimFilter_pkg.ALL;

ENTITY Stage2 IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb_1_2_0                         :   IN    std_logic;
        enb_1_4_1                         :   IN    std_logic;
        enb_1_4_0                         :   IN    std_logic;
        Input                             :   IN    std_logic_vector(13 DOWNTO 0);  -- sfix14_En11
        Output                            :   OUT   std_logic_vector(14 DOWNTO 0)  -- sfix15_En11
        );
END Stage2;


ARCHITECTURE rtl OF Stage2 IS

  -- Component Declarations
  COMPONENT DecimCommutator_block
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb_1_2_0                       :   IN    std_logic;
          enb_1_4_1                       :   IN    std_logic;
          enb_1_4_0                       :   IN    std_logic;
          input                           :   IN    std_logic_vector(13 DOWNTO 0);  -- sfix14_En11
          output1                         :   OUT   std_logic_vector(13 DOWNTO 0);  -- sfix14_En11
          output2                         :   OUT   std_logic_vector(13 DOWNTO 0)  -- sfix14_En11
          );
  END COMPONENT;

  COMPONENT Phase1_block
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb_1_4_0                       :   IN    std_logic;
          Input                           :   IN    std_logic_vector(13 DOWNTO 0);  -- sfix14_En11
          output                          :   OUT   std_logic_vector(13 DOWNTO 0)  -- sfix14_En11
          );
  END COMPONENT;

  COMPONENT Phase2_block
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb_1_4_0                       :   IN    std_logic;
          Input                           :   IN    std_logic_vector(13 DOWNTO 0);  -- sfix14_En11
          output                          :   OUT   std_logic_vector(13 DOWNTO 0)  -- sfix14_En11
          );
  END COMPONENT;

  -- Signals
  SIGNAL Input_signed                     : signed(13 DOWNTO 0);  -- sfix14_En11
  SIGNAL Input_1                          : signed(13 DOWNTO 0);  -- sfix14_En11
  SIGNAL DecimCommutator_out1             : std_logic_vector(13 DOWNTO 0);  -- ufix14
  SIGNAL DecimCommutator_out2             : std_logic_vector(13 DOWNTO 0);  -- ufix14
  SIGNAL DecimCommutator_out1_signed      : signed(13 DOWNTO 0);  -- sfix14_En11
  SIGNAL delay4_out1                      : signed(13 DOWNTO 0);  -- sfix14_En11
  SIGNAL Phase1_out1                      : std_logic_vector(13 DOWNTO 0);  -- ufix14
  SIGNAL Phase1_out1_signed               : signed(13 DOWNTO 0);  -- sfix14_En11
  SIGNAL delay2_out1                      : signed(13 DOWNTO 0);  -- sfix14_En11
  SIGNAL DecimCommutator_out2_signed      : signed(13 DOWNTO 0);  -- sfix14_En11
  SIGNAL delay5_out1                      : signed(13 DOWNTO 0);  -- sfix14_En11
  SIGNAL Phase2_out1                      : std_logic_vector(13 DOWNTO 0);  -- ufix14
  SIGNAL Phase2_out1_signed               : signed(13 DOWNTO 0);  -- sfix14_En11
  SIGNAL delay1_out1                      : signed(13 DOWNTO 0);  -- sfix14_En11
  SIGNAL Sum1_out1                        : signed(14 DOWNTO 0);  -- sfix15_En11
  SIGNAL delay3_out1                      : signed(14 DOWNTO 0);  -- sfix15_En11
  SIGNAL Gain_cast                        : signed(29 DOWNTO 0);  -- sfix30_En22
  SIGNAL Gain_out1                        : signed(14 DOWNTO 0);  -- sfix15_En11
  SIGNAL delay6_out1                      : signed(14 DOWNTO 0);  -- sfix15_En11
  SIGNAL out_0_pipe1_reg                  : vector_of_signed15(0 TO 1);  -- sfix15 [2]
  SIGNAL delay6_out1_1                    : signed(14 DOWNTO 0);  -- sfix15_En11
  SIGNAL delay6_out1_2                    : signed(14 DOWNTO 0);  -- sfix15_En11

BEGIN
  u_DecimCommutator : DecimCommutator_block
    PORT MAP( clk => clk,
              reset => reset,
              enb_1_2_0 => enb_1_2_0,
              enb_1_4_1 => enb_1_4_1,
              enb_1_4_0 => enb_1_4_0,
              input => std_logic_vector(Input_1),  -- sfix14_En11
              output1 => DecimCommutator_out1,  -- sfix14_En11
              output2 => DecimCommutator_out2  -- sfix14_En11
              );

  u_Phase1 : Phase1_block
    PORT MAP( clk => clk,
              reset => reset,
              enb_1_4_0 => enb_1_4_0,
              Input => std_logic_vector(delay4_out1),  -- sfix14_En11
              output => Phase1_out1  -- sfix14_En11
              );

  u_Phase2 : Phase2_block
    PORT MAP( clk => clk,
              reset => reset,
              enb_1_4_0 => enb_1_4_0,
              Input => std_logic_vector(delay5_out1),  -- sfix14_En11
              output => Phase2_out1  -- sfix14_En11
              );

  Input_signed <= signed(Input);

  in_0_pipe_process : PROCESS (clk)
  BEGIN
    IF rising_edge(clk) THEN
      IF reset = '1' THEN
        Input_1 <= to_signed(2#00000000000000#, 14);
      ELSIF enb_1_2_0 = '1' THEN
        Input_1 <= Input_signed;
      END IF;
    END IF;
  END PROCESS in_0_pipe_process;


  DecimCommutator_out1_signed <= signed(DecimCommutator_out1);

  delay4_process : PROCESS (clk)
  BEGIN
    IF rising_edge(clk) THEN
      IF reset = '1' THEN
        delay4_out1 <= to_signed(2#00000000000000#, 14);
      ELSIF enb_1_4_0 = '1' THEN
        delay4_out1 <= DecimCommutator_out1_signed;
      END IF;
    END IF;
  END PROCESS delay4_process;


  Phase1_out1_signed <= signed(Phase1_out1);

  delay2_process : PROCESS (clk)
  BEGIN
    IF rising_edge(clk) THEN
      IF reset = '1' THEN
        delay2_out1 <= to_signed(2#00000000000000#, 14);
      ELSIF enb_1_4_0 = '1' THEN
        delay2_out1 <= Phase1_out1_signed;
      END IF;
    END IF;
  END PROCESS delay2_process;


  DecimCommutator_out2_signed <= signed(DecimCommutator_out2);

  delay5_process : PROCESS (clk)
  BEGIN
    IF rising_edge(clk) THEN
      IF reset = '1' THEN
        delay5_out1 <= to_signed(2#00000000000000#, 14);
      ELSIF enb_1_4_0 = '1' THEN
        delay5_out1 <= DecimCommutator_out2_signed;
      END IF;
    END IF;
  END PROCESS delay5_process;


  Phase2_out1_signed <= signed(Phase2_out1);

  delay1_process : PROCESS (clk)
  BEGIN
    IF rising_edge(clk) THEN
      IF reset = '1' THEN
        delay1_out1 <= to_signed(2#00000000000000#, 14);
      ELSIF enb_1_4_0 = '1' THEN
        delay1_out1 <= Phase2_out1_signed;
      END IF;
    END IF;
  END PROCESS delay1_process;


  Sum1_out1 <= (resize(delay2_out1, 15)) + (resize(delay1_out1, 15));

  delay3_process : PROCESS (clk)
  BEGIN
    IF rising_edge(clk) THEN
      IF reset = '1' THEN
        delay3_out1 <= to_signed(2#000000000000000#, 15);
      ELSIF enb_1_4_0 = '1' THEN
        delay3_out1 <= Sum1_out1;
      END IF;
    END IF;
  END PROCESS delay3_process;


  Gain_cast <= resize(delay3_out1 & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0', 30);
  Gain_out1 <= Gain_cast(25 DOWNTO 11);

  delay6_process : PROCESS (clk)
  BEGIN
    IF rising_edge(clk) THEN
      IF reset = '1' THEN
        delay6_out1 <= to_signed(2#000000000000000#, 15);
      ELSIF enb_1_4_0 = '1' THEN
        delay6_out1 <= Gain_out1;
      END IF;
    END IF;
  END PROCESS delay6_process;


  out_0_pipe1_process : PROCESS (clk)
  BEGIN
    IF rising_edge(clk) THEN
      IF reset = '1' THEN
        out_0_pipe1_reg <= (OTHERS => to_signed(2#000000000000000#, 15));
      ELSIF enb_1_4_0 = '1' THEN
        out_0_pipe1_reg(0) <= delay6_out1;
        out_0_pipe1_reg(1) <= out_0_pipe1_reg(0);
      END IF;
    END IF;
  END PROCESS out_0_pipe1_process;

  delay6_out1_1 <= out_0_pipe1_reg(1);

  out_0_pipe_process : PROCESS (clk)
  BEGIN
    IF rising_edge(clk) THEN
      IF reset = '1' THEN
        delay6_out1_2 <= to_signed(2#000000000000000#, 15);
      ELSIF enb_1_4_0 = '1' THEN
        delay6_out1_2 <= delay6_out1_1;
      END IF;
    END IF;
  END PROCESS out_0_pipe_process;


  Output <= std_logic_vector(delay6_out1_2);

END rtl;
