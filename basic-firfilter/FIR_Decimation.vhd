-- ------------------------------------------------------------
-- 
-- File Name: Q:\Users\Qlab\Documents\Blake\basic_fir_decimator\hdlsrc\polyphaseFIR\FIR_Decimation
-- Created: 2014-05-12 22:55:33
-- Generated by MATLAB 8.3 and HDL Coder 3.4
-- 
-- ------------------------------------------------------------
-- 
-- 
-- ------------------------------------------------------------
-- 
-- Module: FIR_Decimation
-- Source Path: /FIR_Decimation
-- 
-- ------------------------------------------------------------
-- 
-- HDL Implementation    : Fully parallel
-- Multipliers           : 25
-- Folding Factor        : 1


LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.numeric_std.ALL;

ENTITY FIR_Decimation IS
   PORT( clk                             :   IN    std_logic; 
         enb_1_1_1                       :   IN    std_logic; 
         reset                           :   IN    std_logic; 
         FIR_Decimation_in               :   IN    std_logic_vector(15 DOWNTO 0); -- sfix16_En15
         FIR_Decimation_out              :   OUT   std_logic_vector(15 DOWNTO 0)  -- sfix16_En14
         );

END FIR_Decimation;


----------------------------------------------------------------
--Module Architecture: FIR_Decimation
----------------------------------------------------------------
ARCHITECTURE rtl OF FIR_Decimation IS
  -- Local Functions
  -- Type Definitions
  TYPE input_pipeline_type IS ARRAY (NATURAL range <>) OF signed(15 DOWNTO 0); -- sfix16_En15
  TYPE sumdelay_pipeline_type IS ARRAY (NATURAL range <>) OF signed(32 DOWNTO 0); -- sfix33_En31
  -- Constants
  CONSTANT coeffphase1_1                  : signed(15 DOWNTO 0) := to_signed(0, 16); -- sfix16_En16
  CONSTANT coeffphase1_2                  : signed(15 DOWNTO 0) := to_signed(0, 16); -- sfix16_En16
  CONSTANT coeffphase1_3                  : signed(15 DOWNTO 0) := to_signed(0, 16); -- sfix16_En16
  CONSTANT coeffphase1_4                  : signed(15 DOWNTO 0) := to_signed(0, 16); -- sfix16_En16
  CONSTANT coeffphase1_5                  : signed(15 DOWNTO 0) := to_signed(16423, 16); -- sfix16_En16
  CONSTANT coeffphase1_6                  : signed(15 DOWNTO 0) := to_signed(0, 16); -- sfix16_En16
  CONSTANT coeffphase1_7                  : signed(15 DOWNTO 0) := to_signed(0, 16); -- sfix16_En16
  CONSTANT coeffphase1_8                  : signed(15 DOWNTO 0) := to_signed(0, 16); -- sfix16_En16
  CONSTANT coeffphase1_9                  : signed(15 DOWNTO 0) := to_signed(0, 16); -- sfix16_En16
  CONSTANT coeffphase2_1                  : signed(15 DOWNTO 0) := to_signed(-88, 16); -- sfix16_En16
  CONSTANT coeffphase2_2                  : signed(15 DOWNTO 0) := to_signed(382, 16); -- sfix16_En16
  CONSTANT coeffphase2_3                  : signed(15 DOWNTO 0) := to_signed(-1330, 16); -- sfix16_En16
  CONSTANT coeffphase2_4                  : signed(15 DOWNTO 0) := to_signed(4546, 16); -- sfix16_En16
  CONSTANT coeffphase2_5                  : signed(15 DOWNTO 0) := to_signed(14655, 16); -- sfix16_En16
  CONSTANT coeffphase2_6                  : signed(15 DOWNTO 0) := to_signed(-2353, 16); -- sfix16_En16
  CONSTANT coeffphase2_7                  : signed(15 DOWNTO 0) := to_signed(740, 16); -- sfix16_En16
  CONSTANT coeffphase2_8                  : signed(15 DOWNTO 0) := to_signed(-179, 16); -- sfix16_En16
  CONSTANT coeffphase2_9                  : signed(15 DOWNTO 0) := to_signed(0, 16); -- sfix16_En16
  CONSTANT coeffphase3_1                  : signed(15 DOWNTO 0) := to_signed(-172, 16); -- sfix16_En16
  CONSTANT coeffphase3_2                  : signed(15 DOWNTO 0) := to_signed(761, 16); -- sfix16_En16
  CONSTANT coeffphase3_3                  : signed(15 DOWNTO 0) := to_signed(-2495, 16); -- sfix16_En16
  CONSTANT coeffphase3_4                  : signed(15 DOWNTO 0) := to_signed(10089, 16); -- sfix16_En16
  CONSTANT coeffphase3_5                  : signed(15 DOWNTO 0) := to_signed(10089, 16); -- sfix16_En16
  CONSTANT coeffphase3_6                  : signed(15 DOWNTO 0) := to_signed(-2495, 16); -- sfix16_En16
  CONSTANT coeffphase3_7                  : signed(15 DOWNTO 0) := to_signed(761, 16); -- sfix16_En16
  CONSTANT coeffphase3_8                  : signed(15 DOWNTO 0) := to_signed(-172, 16); -- sfix16_En16
  CONSTANT coeffphase3_9                  : signed(15 DOWNTO 0) := to_signed(0, 16); -- sfix16_En16
  CONSTANT coeffphase4_1                  : signed(15 DOWNTO 0) := to_signed(-179, 16); -- sfix16_En16
  CONSTANT coeffphase4_2                  : signed(15 DOWNTO 0) := to_signed(740, 16); -- sfix16_En16
  CONSTANT coeffphase4_3                  : signed(15 DOWNTO 0) := to_signed(-2353, 16); -- sfix16_En16
  CONSTANT coeffphase4_4                  : signed(15 DOWNTO 0) := to_signed(14655, 16); -- sfix16_En16
  CONSTANT coeffphase4_5                  : signed(15 DOWNTO 0) := to_signed(4546, 16); -- sfix16_En16
  CONSTANT coeffphase4_6                  : signed(15 DOWNTO 0) := to_signed(-1330, 16); -- sfix16_En16
  CONSTANT coeffphase4_7                  : signed(15 DOWNTO 0) := to_signed(382, 16); -- sfix16_En16
  CONSTANT coeffphase4_8                  : signed(15 DOWNTO 0) := to_signed(-88, 16); -- sfix16_En16
  CONSTANT coeffphase4_9                  : signed(15 DOWNTO 0) := to_signed(0, 16); -- sfix16_En16

  -- Signals
  SIGNAL ring_count                       : unsigned(3 DOWNTO 0); -- ufix4
  SIGNAL phase_0                          : std_logic; -- boolean
  SIGNAL phase_1                          : std_logic; -- boolean
  SIGNAL phase_2                          : std_logic; -- boolean
  SIGNAL phase_3                          : std_logic; -- boolean
  SIGNAL input_typeconvert                : signed(15 DOWNTO 0); -- sfix16_En15
  SIGNAL input_pipeline_phase0            : input_pipeline_type(0 TO 3); -- sfix16_En15
  SIGNAL input_pipeline_phase1            : input_pipeline_type(0 TO 7); -- sfix16_En15
  SIGNAL input_pipeline_phase2            : input_pipeline_type(0 TO 7); -- sfix16_En15
  SIGNAL input_pipeline_phase3            : input_pipeline_type(0 TO 7); -- sfix16_En15
  SIGNAL product_phase0_5                 : signed(30 DOWNTO 0); -- sfix31_En31
  SIGNAL mul_temp                         : signed(31 DOWNTO 0); -- sfix32_En31
  SIGNAL product_phase1_1                 : signed(30 DOWNTO 0); -- sfix31_En31
  SIGNAL mul_temp_1                       : signed(31 DOWNTO 0); -- sfix32_En31
  SIGNAL product_phase1_2                 : signed(30 DOWNTO 0); -- sfix31_En31
  SIGNAL mul_temp_2                       : signed(31 DOWNTO 0); -- sfix32_En31
  SIGNAL product_phase1_3                 : signed(30 DOWNTO 0); -- sfix31_En31
  SIGNAL mul_temp_3                       : signed(31 DOWNTO 0); -- sfix32_En31
  SIGNAL product_phase1_4                 : signed(30 DOWNTO 0); -- sfix31_En31
  SIGNAL mul_temp_4                       : signed(31 DOWNTO 0); -- sfix32_En31
  SIGNAL product_phase1_5                 : signed(30 DOWNTO 0); -- sfix31_En31
  SIGNAL mul_temp_5                       : signed(31 DOWNTO 0); -- sfix32_En31
  SIGNAL product_phase1_6                 : signed(30 DOWNTO 0); -- sfix31_En31
  SIGNAL mul_temp_6                       : signed(31 DOWNTO 0); -- sfix32_En31
  SIGNAL product_phase1_7                 : signed(30 DOWNTO 0); -- sfix31_En31
  SIGNAL mul_temp_7                       : signed(31 DOWNTO 0); -- sfix32_En31
  SIGNAL product_phase1_8                 : signed(30 DOWNTO 0); -- sfix31_En31
  SIGNAL mul_temp_8                       : signed(31 DOWNTO 0); -- sfix32_En31
  SIGNAL product_phase2_1                 : signed(30 DOWNTO 0); -- sfix31_En31
  SIGNAL mul_temp_9                       : signed(31 DOWNTO 0); -- sfix32_En31
  SIGNAL product_phase2_2                 : signed(30 DOWNTO 0); -- sfix31_En31
  SIGNAL mul_temp_10                      : signed(31 DOWNTO 0); -- sfix32_En31
  SIGNAL product_phase2_3                 : signed(30 DOWNTO 0); -- sfix31_En31
  SIGNAL mul_temp_11                      : signed(31 DOWNTO 0); -- sfix32_En31
  SIGNAL product_phase2_4                 : signed(30 DOWNTO 0); -- sfix31_En31
  SIGNAL mul_temp_12                      : signed(31 DOWNTO 0); -- sfix32_En31
  SIGNAL product_phase2_5                 : signed(30 DOWNTO 0); -- sfix31_En31
  SIGNAL mul_temp_13                      : signed(31 DOWNTO 0); -- sfix32_En31
  SIGNAL product_phase2_6                 : signed(30 DOWNTO 0); -- sfix31_En31
  SIGNAL mul_temp_14                      : signed(31 DOWNTO 0); -- sfix32_En31
  SIGNAL product_phase2_7                 : signed(30 DOWNTO 0); -- sfix31_En31
  SIGNAL mul_temp_15                      : signed(31 DOWNTO 0); -- sfix32_En31
  SIGNAL product_phase2_8                 : signed(30 DOWNTO 0); -- sfix31_En31
  SIGNAL mul_temp_16                      : signed(31 DOWNTO 0); -- sfix32_En31
  SIGNAL product_phase3_1                 : signed(30 DOWNTO 0); -- sfix31_En31
  SIGNAL mul_temp_17                      : signed(31 DOWNTO 0); -- sfix32_En31
  SIGNAL product_phase3_2                 : signed(30 DOWNTO 0); -- sfix31_En31
  SIGNAL mul_temp_18                      : signed(31 DOWNTO 0); -- sfix32_En31
  SIGNAL product_phase3_3                 : signed(30 DOWNTO 0); -- sfix31_En31
  SIGNAL mul_temp_19                      : signed(31 DOWNTO 0); -- sfix32_En31
  SIGNAL product_phase3_4                 : signed(30 DOWNTO 0); -- sfix31_En31
  SIGNAL mul_temp_20                      : signed(31 DOWNTO 0); -- sfix32_En31
  SIGNAL product_phase3_5                 : signed(30 DOWNTO 0); -- sfix31_En31
  SIGNAL mul_temp_21                      : signed(31 DOWNTO 0); -- sfix32_En31
  SIGNAL product_phase3_6                 : signed(30 DOWNTO 0); -- sfix31_En31
  SIGNAL mul_temp_22                      : signed(31 DOWNTO 0); -- sfix32_En31
  SIGNAL product_phase3_7                 : signed(30 DOWNTO 0); -- sfix31_En31
  SIGNAL mul_temp_23                      : signed(31 DOWNTO 0); -- sfix32_En31
  SIGNAL product_phase3_8                 : signed(30 DOWNTO 0); -- sfix31_En31
  SIGNAL mul_temp_24                      : signed(31 DOWNTO 0); -- sfix32_En31
  SIGNAL product_pipeline_phase0_5        : signed(30 DOWNTO 0); -- sfix31_En31
  SIGNAL product_pipeline_phase1_1        : signed(30 DOWNTO 0); -- sfix31_En31
  SIGNAL product_pipeline_phase1_2        : signed(30 DOWNTO 0); -- sfix31_En31
  SIGNAL product_pipeline_phase1_3        : signed(30 DOWNTO 0); -- sfix31_En31
  SIGNAL product_pipeline_phase1_4        : signed(30 DOWNTO 0); -- sfix31_En31
  SIGNAL product_pipeline_phase1_5        : signed(30 DOWNTO 0); -- sfix31_En31
  SIGNAL product_pipeline_phase1_6        : signed(30 DOWNTO 0); -- sfix31_En31
  SIGNAL product_pipeline_phase1_7        : signed(30 DOWNTO 0); -- sfix31_En31
  SIGNAL product_pipeline_phase1_8        : signed(30 DOWNTO 0); -- sfix31_En31
  SIGNAL product_pipeline_phase2_1        : signed(30 DOWNTO 0); -- sfix31_En31
  SIGNAL product_pipeline_phase2_2        : signed(30 DOWNTO 0); -- sfix31_En31
  SIGNAL product_pipeline_phase2_3        : signed(30 DOWNTO 0); -- sfix31_En31
  SIGNAL product_pipeline_phase2_4        : signed(30 DOWNTO 0); -- sfix31_En31
  SIGNAL product_pipeline_phase2_5        : signed(30 DOWNTO 0); -- sfix31_En31
  SIGNAL product_pipeline_phase2_6        : signed(30 DOWNTO 0); -- sfix31_En31
  SIGNAL product_pipeline_phase2_7        : signed(30 DOWNTO 0); -- sfix31_En31
  SIGNAL product_pipeline_phase2_8        : signed(30 DOWNTO 0); -- sfix31_En31
  SIGNAL product_pipeline_phase3_1        : signed(30 DOWNTO 0); -- sfix31_En31
  SIGNAL product_pipeline_phase3_2        : signed(30 DOWNTO 0); -- sfix31_En31
  SIGNAL product_pipeline_phase3_3        : signed(30 DOWNTO 0); -- sfix31_En31
  SIGNAL product_pipeline_phase3_4        : signed(30 DOWNTO 0); -- sfix31_En31
  SIGNAL product_pipeline_phase3_5        : signed(30 DOWNTO 0); -- sfix31_En31
  SIGNAL product_pipeline_phase3_6        : signed(30 DOWNTO 0); -- sfix31_En31
  SIGNAL product_pipeline_phase3_7        : signed(30 DOWNTO 0); -- sfix31_En31
  SIGNAL product_pipeline_phase3_8        : signed(30 DOWNTO 0); -- sfix31_En31
  SIGNAL quantized_sum                    : signed(32 DOWNTO 0); -- sfix33_En31
  SIGNAL sumvector1                       : sumdelay_pipeline_type(0 TO 12); -- sfix33_En31
  SIGNAL add_cast                         : signed(32 DOWNTO 0); -- sfix33_En31
  SIGNAL add_cast_1                       : signed(32 DOWNTO 0); -- sfix33_En31
  SIGNAL add_temp                         : signed(33 DOWNTO 0); -- sfix34_En31
  SIGNAL add_cast_2                       : signed(32 DOWNTO 0); -- sfix33_En31
  SIGNAL add_cast_3                       : signed(32 DOWNTO 0); -- sfix33_En31
  SIGNAL add_temp_1                       : signed(33 DOWNTO 0); -- sfix34_En31
  SIGNAL add_cast_4                       : signed(32 DOWNTO 0); -- sfix33_En31
  SIGNAL add_cast_5                       : signed(32 DOWNTO 0); -- sfix33_En31
  SIGNAL add_temp_2                       : signed(33 DOWNTO 0); -- sfix34_En31
  SIGNAL add_cast_6                       : signed(32 DOWNTO 0); -- sfix33_En31
  SIGNAL add_cast_7                       : signed(32 DOWNTO 0); -- sfix33_En31
  SIGNAL add_temp_3                       : signed(33 DOWNTO 0); -- sfix34_En31
  SIGNAL add_cast_8                       : signed(32 DOWNTO 0); -- sfix33_En31
  SIGNAL add_cast_9                       : signed(32 DOWNTO 0); -- sfix33_En31
  SIGNAL add_temp_4                       : signed(33 DOWNTO 0); -- sfix34_En31
  SIGNAL add_cast_10                      : signed(32 DOWNTO 0); -- sfix33_En31
  SIGNAL add_cast_11                      : signed(32 DOWNTO 0); -- sfix33_En31
  SIGNAL add_temp_5                       : signed(33 DOWNTO 0); -- sfix34_En31
  SIGNAL add_cast_12                      : signed(32 DOWNTO 0); -- sfix33_En31
  SIGNAL add_cast_13                      : signed(32 DOWNTO 0); -- sfix33_En31
  SIGNAL add_temp_6                       : signed(33 DOWNTO 0); -- sfix34_En31
  SIGNAL add_cast_14                      : signed(32 DOWNTO 0); -- sfix33_En31
  SIGNAL add_cast_15                      : signed(32 DOWNTO 0); -- sfix33_En31
  SIGNAL add_temp_7                       : signed(33 DOWNTO 0); -- sfix34_En31
  SIGNAL add_cast_16                      : signed(32 DOWNTO 0); -- sfix33_En31
  SIGNAL add_cast_17                      : signed(32 DOWNTO 0); -- sfix33_En31
  SIGNAL add_temp_8                       : signed(33 DOWNTO 0); -- sfix34_En31
  SIGNAL add_cast_18                      : signed(32 DOWNTO 0); -- sfix33_En31
  SIGNAL add_cast_19                      : signed(32 DOWNTO 0); -- sfix33_En31
  SIGNAL add_temp_9                       : signed(33 DOWNTO 0); -- sfix34_En31
  SIGNAL add_cast_20                      : signed(32 DOWNTO 0); -- sfix33_En31
  SIGNAL add_cast_21                      : signed(32 DOWNTO 0); -- sfix33_En31
  SIGNAL add_temp_10                      : signed(33 DOWNTO 0); -- sfix34_En31
  SIGNAL add_cast_22                      : signed(32 DOWNTO 0); -- sfix33_En31
  SIGNAL add_cast_23                      : signed(32 DOWNTO 0); -- sfix33_En31
  SIGNAL add_temp_11                      : signed(33 DOWNTO 0); -- sfix34_En31
  SIGNAL sumdelay_pipeline1               : sumdelay_pipeline_type(0 TO 12); -- sfix33_En31
  SIGNAL sumvector2                       : sumdelay_pipeline_type(0 TO 6); -- sfix33_En31
  SIGNAL add_cast_24                      : signed(32 DOWNTO 0); -- sfix33_En31
  SIGNAL add_cast_25                      : signed(32 DOWNTO 0); -- sfix33_En31
  SIGNAL add_temp_12                      : signed(33 DOWNTO 0); -- sfix34_En31
  SIGNAL add_cast_26                      : signed(32 DOWNTO 0); -- sfix33_En31
  SIGNAL add_cast_27                      : signed(32 DOWNTO 0); -- sfix33_En31
  SIGNAL add_temp_13                      : signed(33 DOWNTO 0); -- sfix34_En31
  SIGNAL add_cast_28                      : signed(32 DOWNTO 0); -- sfix33_En31
  SIGNAL add_cast_29                      : signed(32 DOWNTO 0); -- sfix33_En31
  SIGNAL add_temp_14                      : signed(33 DOWNTO 0); -- sfix34_En31
  SIGNAL add_cast_30                      : signed(32 DOWNTO 0); -- sfix33_En31
  SIGNAL add_cast_31                      : signed(32 DOWNTO 0); -- sfix33_En31
  SIGNAL add_temp_15                      : signed(33 DOWNTO 0); -- sfix34_En31
  SIGNAL add_cast_32                      : signed(32 DOWNTO 0); -- sfix33_En31
  SIGNAL add_cast_33                      : signed(32 DOWNTO 0); -- sfix33_En31
  SIGNAL add_temp_16                      : signed(33 DOWNTO 0); -- sfix34_En31
  SIGNAL add_cast_34                      : signed(32 DOWNTO 0); -- sfix33_En31
  SIGNAL add_cast_35                      : signed(32 DOWNTO 0); -- sfix33_En31
  SIGNAL add_temp_17                      : signed(33 DOWNTO 0); -- sfix34_En31
  SIGNAL sumdelay_pipeline2               : sumdelay_pipeline_type(0 TO 6); -- sfix33_En31
  SIGNAL sumvector3                       : sumdelay_pipeline_type(0 TO 3); -- sfix33_En31
  SIGNAL add_cast_36                      : signed(32 DOWNTO 0); -- sfix33_En31
  SIGNAL add_cast_37                      : signed(32 DOWNTO 0); -- sfix33_En31
  SIGNAL add_temp_18                      : signed(33 DOWNTO 0); -- sfix34_En31
  SIGNAL add_cast_38                      : signed(32 DOWNTO 0); -- sfix33_En31
  SIGNAL add_cast_39                      : signed(32 DOWNTO 0); -- sfix33_En31
  SIGNAL add_temp_19                      : signed(33 DOWNTO 0); -- sfix34_En31
  SIGNAL add_cast_40                      : signed(32 DOWNTO 0); -- sfix33_En31
  SIGNAL add_cast_41                      : signed(32 DOWNTO 0); -- sfix33_En31
  SIGNAL add_temp_20                      : signed(33 DOWNTO 0); -- sfix34_En31
  SIGNAL sumdelay_pipeline3               : sumdelay_pipeline_type(0 TO 3); -- sfix33_En31
  SIGNAL sumvector4                       : sumdelay_pipeline_type(0 TO 1); -- sfix33_En31
  SIGNAL add_cast_42                      : signed(32 DOWNTO 0); -- sfix33_En31
  SIGNAL add_cast_43                      : signed(32 DOWNTO 0); -- sfix33_En31
  SIGNAL add_temp_21                      : signed(33 DOWNTO 0); -- sfix34_En31
  SIGNAL add_cast_44                      : signed(32 DOWNTO 0); -- sfix33_En31
  SIGNAL add_cast_45                      : signed(32 DOWNTO 0); -- sfix33_En31
  SIGNAL add_temp_22                      : signed(33 DOWNTO 0); -- sfix34_En31
  SIGNAL sumdelay_pipeline4               : sumdelay_pipeline_type(0 TO 1); -- sfix33_En31
  SIGNAL sum5                             : signed(32 DOWNTO 0); -- sfix33_En31
  SIGNAL add_cast_46                      : signed(32 DOWNTO 0); -- sfix33_En31
  SIGNAL add_cast_47                      : signed(32 DOWNTO 0); -- sfix33_En31
  SIGNAL add_temp_23                      : signed(33 DOWNTO 0); -- sfix34_En31
  SIGNAL output_typeconvert               : signed(15 DOWNTO 0); -- sfix16_En14
  SIGNAL regout                           : signed(15 DOWNTO 0); -- sfix16_En14
  SIGNAL muxout                           : signed(15 DOWNTO 0); -- sfix16_En14


BEGIN

  -- Block Statements
  ce_output : PROCESS (clk)
  BEGIN
    IF rising_edge(clk) THEN
      IF reset = '1' THEN
        ring_count <= to_unsigned(1, 4);
      ELSIF enb_1_1_1 = '1' THEN
        ring_count <= ring_count(0) & ring_count(3 DOWNTO 1);
      END IF;
    END IF; 
  END PROCESS ce_output;

  phase_0 <= ring_count(0)  AND enb_1_1_1;

  phase_1 <= ring_count(1)  AND enb_1_1_1;

  phase_2 <= ring_count(2)  AND enb_1_1_1;

  phase_3 <= ring_count(3)  AND enb_1_1_1;

  input_typeconvert <= signed(FIR_Decimation_in);

  Delay_Pipeline_Phase0_process : PROCESS (clk)
  BEGIN
    IF rising_edge(clk) THEN
      IF reset = '1' THEN
        input_pipeline_phase0(0 TO 3) <= (OTHERS => (OTHERS => '0'));
      ELSIF phase_0 = '1' THEN
        input_pipeline_phase0(0) <= input_typeconvert;
        input_pipeline_phase0(1 TO 3) <= input_pipeline_phase0(0 TO 2);
      END IF;
    END IF; 
  END PROCESS Delay_Pipeline_Phase0_process;

  Delay_Pipeline_Phase1_process : PROCESS (clk)
  BEGIN
    IF rising_edge(clk) THEN
      IF reset = '1' THEN
        input_pipeline_phase1(0 TO 7) <= (OTHERS => (OTHERS => '0'));
      ELSIF phase_1 = '1' THEN
        input_pipeline_phase1(0) <= input_typeconvert;
        input_pipeline_phase1(1 TO 7) <= input_pipeline_phase1(0 TO 6);
      END IF;
    END IF; 
  END PROCESS Delay_Pipeline_Phase1_process;

  Delay_Pipeline_Phase2_process : PROCESS (clk)
  BEGIN
    IF rising_edge(clk) THEN
      IF reset = '1' THEN
        input_pipeline_phase2(0 TO 7) <= (OTHERS => (OTHERS => '0'));
      ELSIF phase_2 = '1' THEN
        input_pipeline_phase2(0) <= input_typeconvert;
        input_pipeline_phase2(1 TO 7) <= input_pipeline_phase2(0 TO 6);
      END IF;
    END IF; 
  END PROCESS Delay_Pipeline_Phase2_process;

  Delay_Pipeline_Phase3_process : PROCESS (clk)
  BEGIN
    IF rising_edge(clk) THEN
      IF reset = '1' THEN
        input_pipeline_phase3(0 TO 7) <= (OTHERS => (OTHERS => '0'));
      ELSIF phase_3 = '1' THEN
        input_pipeline_phase3(0) <= input_typeconvert;
        input_pipeline_phase3(1 TO 7) <= input_pipeline_phase3(0 TO 6);
      END IF;
    END IF; 
  END PROCESS Delay_Pipeline_Phase3_process;

  mul_temp <= input_pipeline_phase0(3) * coeffphase1_5;
  product_phase0_5 <= mul_temp(30 DOWNTO 0);

  mul_temp_1 <= input_pipeline_phase1(0) * coeffphase2_1;
  product_phase1_1 <= mul_temp_1(30 DOWNTO 0);

  mul_temp_2 <= input_pipeline_phase1(1) * coeffphase2_2;
  product_phase1_2 <= mul_temp_2(30 DOWNTO 0);

  mul_temp_3 <= input_pipeline_phase1(2) * coeffphase2_3;
  product_phase1_3 <= mul_temp_3(30 DOWNTO 0);

  mul_temp_4 <= input_pipeline_phase1(3) * coeffphase2_4;
  product_phase1_4 <= mul_temp_4(30 DOWNTO 0);

  mul_temp_5 <= input_pipeline_phase1(4) * coeffphase2_5;
  product_phase1_5 <= mul_temp_5(30 DOWNTO 0);

  mul_temp_6 <= input_pipeline_phase1(5) * coeffphase2_6;
  product_phase1_6 <= mul_temp_6(30 DOWNTO 0);

  mul_temp_7 <= input_pipeline_phase1(6) * coeffphase2_7;
  product_phase1_7 <= mul_temp_7(30 DOWNTO 0);

  mul_temp_8 <= input_pipeline_phase1(7) * coeffphase2_8;
  product_phase1_8 <= mul_temp_8(30 DOWNTO 0);

  mul_temp_9 <= input_pipeline_phase2(0) * coeffphase3_1;
  product_phase2_1 <= mul_temp_9(30 DOWNTO 0);

  mul_temp_10 <= input_pipeline_phase2(1) * coeffphase3_2;
  product_phase2_2 <= mul_temp_10(30 DOWNTO 0);

  mul_temp_11 <= input_pipeline_phase2(2) * coeffphase3_3;
  product_phase2_3 <= mul_temp_11(30 DOWNTO 0);

  mul_temp_12 <= input_pipeline_phase2(3) * coeffphase3_4;
  product_phase2_4 <= mul_temp_12(30 DOWNTO 0);

  mul_temp_13 <= input_pipeline_phase2(4) * coeffphase3_5;
  product_phase2_5 <= mul_temp_13(30 DOWNTO 0);

  mul_temp_14 <= input_pipeline_phase2(5) * coeffphase3_6;
  product_phase2_6 <= mul_temp_14(30 DOWNTO 0);

  mul_temp_15 <= input_pipeline_phase2(6) * coeffphase3_7;
  product_phase2_7 <= mul_temp_15(30 DOWNTO 0);

  mul_temp_16 <= input_pipeline_phase2(7) * coeffphase3_8;
  product_phase2_8 <= mul_temp_16(30 DOWNTO 0);

  mul_temp_17 <= input_pipeline_phase3(0) * coeffphase4_1;
  product_phase3_1 <= mul_temp_17(30 DOWNTO 0);

  mul_temp_18 <= input_pipeline_phase3(1) * coeffphase4_2;
  product_phase3_2 <= mul_temp_18(30 DOWNTO 0);

  mul_temp_19 <= input_pipeline_phase3(2) * coeffphase4_3;
  product_phase3_3 <= mul_temp_19(30 DOWNTO 0);

  mul_temp_20 <= input_pipeline_phase3(3) * coeffphase4_4;
  product_phase3_4 <= mul_temp_20(30 DOWNTO 0);

  mul_temp_21 <= input_pipeline_phase3(4) * coeffphase4_5;
  product_phase3_5 <= mul_temp_21(30 DOWNTO 0);

  mul_temp_22 <= input_pipeline_phase3(5) * coeffphase4_6;
  product_phase3_6 <= mul_temp_22(30 DOWNTO 0);

  mul_temp_23 <= input_pipeline_phase3(6) * coeffphase4_7;
  product_phase3_7 <= mul_temp_23(30 DOWNTO 0);

  mul_temp_24 <= input_pipeline_phase3(7) * coeffphase4_8;
  product_phase3_8 <= mul_temp_24(30 DOWNTO 0);

  product_pipeline_process3 : PROCESS (clk)
  BEGIN
    IF rising_edge(clk) THEN
      IF reset = '1' THEN
        product_pipeline_phase1_1 <= (OTHERS => '0');
        product_pipeline_phase2_1 <= (OTHERS => '0');
        product_pipeline_phase3_1 <= (OTHERS => '0');
        product_pipeline_phase1_2 <= (OTHERS => '0');
        product_pipeline_phase2_2 <= (OTHERS => '0');
        product_pipeline_phase3_2 <= (OTHERS => '0');
        product_pipeline_phase1_3 <= (OTHERS => '0');
        product_pipeline_phase2_3 <= (OTHERS => '0');
        product_pipeline_phase3_3 <= (OTHERS => '0');
        product_pipeline_phase1_4 <= (OTHERS => '0');
        product_pipeline_phase2_4 <= (OTHERS => '0');
        product_pipeline_phase3_4 <= (OTHERS => '0');
        product_pipeline_phase0_5 <= (OTHERS => '0');
        product_pipeline_phase1_5 <= (OTHERS => '0');
        product_pipeline_phase2_5 <= (OTHERS => '0');
        product_pipeline_phase3_5 <= (OTHERS => '0');
        product_pipeline_phase1_6 <= (OTHERS => '0');
        product_pipeline_phase2_6 <= (OTHERS => '0');
        product_pipeline_phase3_6 <= (OTHERS => '0');
        product_pipeline_phase1_7 <= (OTHERS => '0');
        product_pipeline_phase2_7 <= (OTHERS => '0');
        product_pipeline_phase3_7 <= (OTHERS => '0');
        product_pipeline_phase1_8 <= (OTHERS => '0');
        product_pipeline_phase2_8 <= (OTHERS => '0');
        product_pipeline_phase3_8 <= (OTHERS => '0');
      ELSIF phase_0 = '1' THEN
        product_pipeline_phase1_1 <= product_phase1_1;
        product_pipeline_phase2_1 <= product_phase2_1;
        product_pipeline_phase3_1 <= product_phase3_1;
        product_pipeline_phase1_2 <= product_phase1_2;
        product_pipeline_phase2_2 <= product_phase2_2;
        product_pipeline_phase3_2 <= product_phase3_2;
        product_pipeline_phase1_3 <= product_phase1_3;
        product_pipeline_phase2_3 <= product_phase2_3;
        product_pipeline_phase3_3 <= product_phase3_3;
        product_pipeline_phase1_4 <= product_phase1_4;
        product_pipeline_phase2_4 <= product_phase2_4;
        product_pipeline_phase3_4 <= product_phase3_4;
        product_pipeline_phase0_5 <= product_phase0_5;
        product_pipeline_phase1_5 <= product_phase1_5;
        product_pipeline_phase2_5 <= product_phase2_5;
        product_pipeline_phase3_5 <= product_phase3_5;
        product_pipeline_phase1_6 <= product_phase1_6;
        product_pipeline_phase2_6 <= product_phase2_6;
        product_pipeline_phase3_6 <= product_phase3_6;
        product_pipeline_phase1_7 <= product_phase1_7;
        product_pipeline_phase2_7 <= product_phase2_7;
        product_pipeline_phase3_7 <= product_phase3_7;
        product_pipeline_phase1_8 <= product_phase1_8;
        product_pipeline_phase2_8 <= product_phase2_8;
        product_pipeline_phase3_8 <= product_phase3_8;
      END IF;
    END IF; 
  END PROCESS product_pipeline_process3;

  quantized_sum <= resize(product_pipeline_phase3_1, 33);

  add_cast <= quantized_sum;
  add_cast_1 <= resize(product_pipeline_phase3_2, 33);
  add_temp <= resize(add_cast, 34) + resize(add_cast_1, 34);
  sumvector1(0) <= add_temp(32 DOWNTO 0);

  add_cast_2 <= resize(product_pipeline_phase3_3, 33);
  add_cast_3 <= resize(product_pipeline_phase3_4, 33);
  add_temp_1 <= resize(add_cast_2, 34) + resize(add_cast_3, 34);
  sumvector1(1) <= add_temp_1(32 DOWNTO 0);

  add_cast_4 <= resize(product_pipeline_phase3_5, 33);
  add_cast_5 <= resize(product_pipeline_phase3_6, 33);
  add_temp_2 <= resize(add_cast_4, 34) + resize(add_cast_5, 34);
  sumvector1(2) <= add_temp_2(32 DOWNTO 0);

  add_cast_6 <= resize(product_pipeline_phase3_7, 33);
  add_cast_7 <= resize(product_pipeline_phase3_8, 33);
  add_temp_3 <= resize(add_cast_6, 34) + resize(add_cast_7, 34);
  sumvector1(3) <= add_temp_3(32 DOWNTO 0);

  add_cast_8 <= resize(product_pipeline_phase2_1, 33);
  add_cast_9 <= resize(product_pipeline_phase2_2, 33);
  add_temp_4 <= resize(add_cast_8, 34) + resize(add_cast_9, 34);
  sumvector1(4) <= add_temp_4(32 DOWNTO 0);

  add_cast_10 <= resize(product_pipeline_phase2_3, 33);
  add_cast_11 <= resize(product_pipeline_phase2_4, 33);
  add_temp_5 <= resize(add_cast_10, 34) + resize(add_cast_11, 34);
  sumvector1(5) <= add_temp_5(32 DOWNTO 0);

  add_cast_12 <= resize(product_pipeline_phase2_5, 33);
  add_cast_13 <= resize(product_pipeline_phase2_6, 33);
  add_temp_6 <= resize(add_cast_12, 34) + resize(add_cast_13, 34);
  sumvector1(6) <= add_temp_6(32 DOWNTO 0);

  add_cast_14 <= resize(product_pipeline_phase2_7, 33);
  add_cast_15 <= resize(product_pipeline_phase2_8, 33);
  add_temp_7 <= resize(add_cast_14, 34) + resize(add_cast_15, 34);
  sumvector1(7) <= add_temp_7(32 DOWNTO 0);

  add_cast_16 <= resize(product_pipeline_phase1_1, 33);
  add_cast_17 <= resize(product_pipeline_phase1_2, 33);
  add_temp_8 <= resize(add_cast_16, 34) + resize(add_cast_17, 34);
  sumvector1(8) <= add_temp_8(32 DOWNTO 0);

  add_cast_18 <= resize(product_pipeline_phase1_3, 33);
  add_cast_19 <= resize(product_pipeline_phase1_4, 33);
  add_temp_9 <= resize(add_cast_18, 34) + resize(add_cast_19, 34);
  sumvector1(9) <= add_temp_9(32 DOWNTO 0);

  add_cast_20 <= resize(product_pipeline_phase1_5, 33);
  add_cast_21 <= resize(product_pipeline_phase1_6, 33);
  add_temp_10 <= resize(add_cast_20, 34) + resize(add_cast_21, 34);
  sumvector1(10) <= add_temp_10(32 DOWNTO 0);

  add_cast_22 <= resize(product_pipeline_phase1_7, 33);
  add_cast_23 <= resize(product_pipeline_phase1_8, 33);
  add_temp_11 <= resize(add_cast_22, 34) + resize(add_cast_23, 34);
  sumvector1(11) <= add_temp_11(32 DOWNTO 0);

  sumvector1(12) <= resize(product_pipeline_phase0_5, 33);

  sumdelay_pipeline_process1 : PROCESS (clk)
  BEGIN
    IF rising_edge(clk) THEN
      IF reset = '1' THEN
        sumdelay_pipeline1 <= (OTHERS => (OTHERS => '0'));
      ELSIF phase_0 = '1' THEN
        sumdelay_pipeline1(0 TO 12) <= sumvector1(0 TO 12);
      END IF;
    END IF; 
  END PROCESS sumdelay_pipeline_process1;

  add_cast_24 <= sumdelay_pipeline1(0);
  add_cast_25 <= sumdelay_pipeline1(1);
  add_temp_12 <= resize(add_cast_24, 34) + resize(add_cast_25, 34);
  sumvector2(0) <= add_temp_12(32 DOWNTO 0);

  add_cast_26 <= sumdelay_pipeline1(2);
  add_cast_27 <= sumdelay_pipeline1(3);
  add_temp_13 <= resize(add_cast_26, 34) + resize(add_cast_27, 34);
  sumvector2(1) <= add_temp_13(32 DOWNTO 0);

  add_cast_28 <= sumdelay_pipeline1(4);
  add_cast_29 <= sumdelay_pipeline1(5);
  add_temp_14 <= resize(add_cast_28, 34) + resize(add_cast_29, 34);
  sumvector2(2) <= add_temp_14(32 DOWNTO 0);

  add_cast_30 <= sumdelay_pipeline1(6);
  add_cast_31 <= sumdelay_pipeline1(7);
  add_temp_15 <= resize(add_cast_30, 34) + resize(add_cast_31, 34);
  sumvector2(3) <= add_temp_15(32 DOWNTO 0);

  add_cast_32 <= sumdelay_pipeline1(8);
  add_cast_33 <= sumdelay_pipeline1(9);
  add_temp_16 <= resize(add_cast_32, 34) + resize(add_cast_33, 34);
  sumvector2(4) <= add_temp_16(32 DOWNTO 0);

  add_cast_34 <= sumdelay_pipeline1(10);
  add_cast_35 <= sumdelay_pipeline1(11);
  add_temp_17 <= resize(add_cast_34, 34) + resize(add_cast_35, 34);
  sumvector2(5) <= add_temp_17(32 DOWNTO 0);

  sumvector2(6) <= sumdelay_pipeline1(12);

  sumdelay_pipeline_process2 : PROCESS (clk)
  BEGIN
    IF rising_edge(clk) THEN
      IF reset = '1' THEN
        sumdelay_pipeline2 <= (OTHERS => (OTHERS => '0'));
      ELSIF phase_0 = '1' THEN
        sumdelay_pipeline2(0 TO 6) <= sumvector2(0 TO 6);
      END IF;
    END IF; 
  END PROCESS sumdelay_pipeline_process2;

  add_cast_36 <= sumdelay_pipeline2(0);
  add_cast_37 <= sumdelay_pipeline2(1);
  add_temp_18 <= resize(add_cast_36, 34) + resize(add_cast_37, 34);
  sumvector3(0) <= add_temp_18(32 DOWNTO 0);

  add_cast_38 <= sumdelay_pipeline2(2);
  add_cast_39 <= sumdelay_pipeline2(3);
  add_temp_19 <= resize(add_cast_38, 34) + resize(add_cast_39, 34);
  sumvector3(1) <= add_temp_19(32 DOWNTO 0);

  add_cast_40 <= sumdelay_pipeline2(4);
  add_cast_41 <= sumdelay_pipeline2(5);
  add_temp_20 <= resize(add_cast_40, 34) + resize(add_cast_41, 34);
  sumvector3(2) <= add_temp_20(32 DOWNTO 0);

  sumvector3(3) <= sumdelay_pipeline2(6);

  sumdelay_pipeline_process3 : PROCESS (clk)
  BEGIN
    IF rising_edge(clk) THEN
      IF reset = '1' THEN
        sumdelay_pipeline3 <= (OTHERS => (OTHERS => '0'));
      ELSIF phase_0 = '1' THEN
        sumdelay_pipeline3(0 TO 3) <= sumvector3(0 TO 3);
      END IF;
    END IF; 
  END PROCESS sumdelay_pipeline_process3;

  add_cast_42 <= sumdelay_pipeline3(0);
  add_cast_43 <= sumdelay_pipeline3(1);
  add_temp_21 <= resize(add_cast_42, 34) + resize(add_cast_43, 34);
  sumvector4(0) <= add_temp_21(32 DOWNTO 0);

  add_cast_44 <= sumdelay_pipeline3(2);
  add_cast_45 <= sumdelay_pipeline3(3);
  add_temp_22 <= resize(add_cast_44, 34) + resize(add_cast_45, 34);
  sumvector4(1) <= add_temp_22(32 DOWNTO 0);

  sumdelay_pipeline_process4 : PROCESS (clk)
  BEGIN
    IF rising_edge(clk) THEN
      IF reset = '1' THEN
        sumdelay_pipeline4 <= (OTHERS => (OTHERS => '0'));
      ELSIF phase_0 = '1' THEN
        sumdelay_pipeline4(0 TO 1) <= sumvector4(0 TO 1);
      END IF;
    END IF; 
  END PROCESS sumdelay_pipeline_process4;

  add_cast_46 <= sumdelay_pipeline4(0);
  add_cast_47 <= sumdelay_pipeline4(1);
  add_temp_23 <= resize(add_cast_46, 34) + resize(add_cast_47, 34);
  sum5 <= add_temp_23(32 DOWNTO 0);

  output_typeconvert <= sum5(32 DOWNTO 17);

  DataHoldRegister_process : PROCESS (clk)
  BEGIN
    IF rising_edge(clk) THEN
      IF reset = '1' THEN
        regout <= (OTHERS => '0');
      ELSIF phase_0 = '1' THEN
        regout <= output_typeconvert;
      END IF;
    END IF; 
  END PROCESS DataHoldRegister_process;

  muxout <= output_typeconvert WHEN ( phase_0 = '1' ) ELSE
            regout;
  -- Assignment Statements
  FIR_Decimation_out <= std_logic_vector(muxout);
END rtl;