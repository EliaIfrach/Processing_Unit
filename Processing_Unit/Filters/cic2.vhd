-- -------------------------------------------------------------
--
-- Module: CIC2
-- Generated by MATLAB(R) 9.10 and Filter Design HDL Coder 3.1.9.
-- Generated on: 2022-09-07 15:59:13
-- -------------------------------------------------------------

-- -------------------------------------------------------------
-- HDL Code Generation Options:
--
-- TargetLanguage: VHDL
-- FIRAdderStyle: tree
-- OptimizeForHDL: on
-- TargetDirectory: C:\Users\Elia Yfrach\Desktop\Project\Processing_Unit\Filters
-- Name: CIC2
-- TestBenchName: CIC2_tb
-- TestBenchStimulus: step ramp chirp noise 

-- Filter Specifications:
--
-- Sample Rate        : 45.955 kHz
-- Response           : CIC Compensator
-- Specification      : Fp,Fst,Ap,Ast
-- Decimation Factor  : 25
-- Multirate Type     : Decimator
-- Stopband Atten.    : 10 dB
-- Differential Delay : 1
-- Number of Sections : 4
-- Stopband Edge      : 800 Hz
-- Passband Ripple    : 1 dB
-- Passband Edge      : 200 Hz
-- -------------------------------------------------------------

-- -------------------------------------------------------------
-- HDL Implementation    : Fully parallel
-- Folding Factor        : 1
-- -------------------------------------------------------------
-- Filter Settings:
--
-- Discrete-Time FIR Multirate Filter (real)
-- -----------------------------------------
-- Filter Structure   : Direct-Form FIR Polyphase Decimator
-- Decimation Factor  : 25
-- Polyphase Length   : 2
-- Filter Length      : 35
-- Stable             : Yes
-- Linear Phase       : Yes (Type 1)
--
-- Arithmetic         : fixed
-- Numerator          : s16,17 -> [-2.500000e-01 2.500000e-01)
-- -------------------------------------------------------------



LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.numeric_std.ALL;

ENTITY CIC2 IS
   PORT( clk                             :   IN    std_logic; 
         clk_enable                      :   IN    std_logic; 
         reset                           :   IN    std_logic; 
         filter_in                       :   IN    std_logic_vector(17 DOWNTO 0); -- sfix18
         filter_out                      :   OUT   std_logic_vector(34 DOWNTO 0); -- sfix35_En17
         ce_out                          :   OUT   std_logic  
         );

END CIC2;


----------------------------------------------------------------
--Module Architecture: CIC2
----------------------------------------------------------------
ARCHITECTURE rtl OF CIC2 IS
  -- Local Functions
  -- Type Definitions
  TYPE input_pipeline_type IS ARRAY (NATURAL range <>) OF signed(17 DOWNTO 0); -- sfix18
  -- Constants
  CONSTANT coeffphase1_1                  : signed(15 DOWNTO 0) := to_signed(20958, 16); -- sfix16_En17
  CONSTANT coeffphase1_2                  : signed(15 DOWNTO 0) := to_signed(2793, 16); -- sfix16_En17
  CONSTANT coeffphase2_1                  : signed(15 DOWNTO 0) := to_signed(2124, 16); -- sfix16_En17
  CONSTANT coeffphase2_2                  : signed(15 DOWNTO 0) := to_signed(2712, 16); -- sfix16_En17
  CONSTANT coeffphase3_1                  : signed(15 DOWNTO 0) := to_signed(2217, 16); -- sfix16_En17
  CONSTANT coeffphase3_2                  : signed(15 DOWNTO 0) := to_signed(2652, 16); -- sfix16_En17
  CONSTANT coeffphase4_1                  : signed(15 DOWNTO 0) := to_signed(2321, 16); -- sfix16_En17
  CONSTANT coeffphase4_2                  : signed(15 DOWNTO 0) := to_signed(2575, 16); -- sfix16_En17
  CONSTANT coeffphase5_1                  : signed(15 DOWNTO 0) := to_signed(2410, 16); -- sfix16_En17
  CONSTANT coeffphase5_2                  : signed(15 DOWNTO 0) := to_signed(2506, 16); -- sfix16_En17
  CONSTANT coeffphase6_1                  : signed(15 DOWNTO 0) := to_signed(2506, 16); -- sfix16_En17
  CONSTANT coeffphase6_2                  : signed(15 DOWNTO 0) := to_signed(2410, 16); -- sfix16_En17
  CONSTANT coeffphase7_1                  : signed(15 DOWNTO 0) := to_signed(2575, 16); -- sfix16_En17
  CONSTANT coeffphase7_2                  : signed(15 DOWNTO 0) := to_signed(2321, 16); -- sfix16_En17
  CONSTANT coeffphase8_1                  : signed(15 DOWNTO 0) := to_signed(2652, 16); -- sfix16_En17
  CONSTANT coeffphase8_2                  : signed(15 DOWNTO 0) := to_signed(2217, 16); -- sfix16_En17
  CONSTANT coeffphase9_1                  : signed(15 DOWNTO 0) := to_signed(2712, 16); -- sfix16_En17
  CONSTANT coeffphase9_2                  : signed(15 DOWNTO 0) := to_signed(2124, 16); -- sfix16_En17
  CONSTANT coeffphase10_1                 : signed(15 DOWNTO 0) := to_signed(2793, 16); -- sfix16_En17
  CONSTANT coeffphase10_2                 : signed(15 DOWNTO 0) := to_signed(20958, 16); -- sfix16_En17
  CONSTANT coeffphase11_1                 : signed(15 DOWNTO 0) := to_signed(2865, 16); -- sfix16_En17
  CONSTANT coeffphase11_2                 : signed(15 DOWNTO 0) := to_signed(0, 16); -- sfix16_En17
  CONSTANT coeffphase12_1                 : signed(15 DOWNTO 0) := to_signed(2887, 16); -- sfix16_En17
  CONSTANT coeffphase12_2                 : signed(15 DOWNTO 0) := to_signed(0, 16); -- sfix16_En17
  CONSTANT coeffphase13_1                 : signed(15 DOWNTO 0) := to_signed(2936, 16); -- sfix16_En17
  CONSTANT coeffphase13_2                 : signed(15 DOWNTO 0) := to_signed(0, 16); -- sfix16_En17
  CONSTANT coeffphase14_1                 : signed(15 DOWNTO 0) := to_signed(2973, 16); -- sfix16_En17
  CONSTANT coeffphase14_2                 : signed(15 DOWNTO 0) := to_signed(0, 16); -- sfix16_En17
  CONSTANT coeffphase15_1                 : signed(15 DOWNTO 0) := to_signed(3001, 16); -- sfix16_En17
  CONSTANT coeffphase15_2                 : signed(15 DOWNTO 0) := to_signed(0, 16); -- sfix16_En17
  CONSTANT coeffphase16_1                 : signed(15 DOWNTO 0) := to_signed(3027, 16); -- sfix16_En17
  CONSTANT coeffphase16_2                 : signed(15 DOWNTO 0) := to_signed(0, 16); -- sfix16_En17
  CONSTANT coeffphase17_1                 : signed(15 DOWNTO 0) := to_signed(3026, 16); -- sfix16_En17
  CONSTANT coeffphase17_2                 : signed(15 DOWNTO 0) := to_signed(0, 16); -- sfix16_En17
  CONSTANT coeffphase18_1                 : signed(15 DOWNTO 0) := to_signed(3036, 16); -- sfix16_En17
  CONSTANT coeffphase18_2                 : signed(15 DOWNTO 0) := to_signed(0, 16); -- sfix16_En17
  CONSTANT coeffphase19_1                 : signed(15 DOWNTO 0) := to_signed(3026, 16); -- sfix16_En17
  CONSTANT coeffphase19_2                 : signed(15 DOWNTO 0) := to_signed(0, 16); -- sfix16_En17
  CONSTANT coeffphase20_1                 : signed(15 DOWNTO 0) := to_signed(3027, 16); -- sfix16_En17
  CONSTANT coeffphase20_2                 : signed(15 DOWNTO 0) := to_signed(0, 16); -- sfix16_En17
  CONSTANT coeffphase21_1                 : signed(15 DOWNTO 0) := to_signed(3001, 16); -- sfix16_En17
  CONSTANT coeffphase21_2                 : signed(15 DOWNTO 0) := to_signed(0, 16); -- sfix16_En17
  CONSTANT coeffphase22_1                 : signed(15 DOWNTO 0) := to_signed(2973, 16); -- sfix16_En17
  CONSTANT coeffphase22_2                 : signed(15 DOWNTO 0) := to_signed(0, 16); -- sfix16_En17
  CONSTANT coeffphase23_1                 : signed(15 DOWNTO 0) := to_signed(2936, 16); -- sfix16_En17
  CONSTANT coeffphase23_2                 : signed(15 DOWNTO 0) := to_signed(0, 16); -- sfix16_En17
  CONSTANT coeffphase24_1                 : signed(15 DOWNTO 0) := to_signed(2887, 16); -- sfix16_En17
  CONSTANT coeffphase24_2                 : signed(15 DOWNTO 0) := to_signed(0, 16); -- sfix16_En17
  CONSTANT coeffphase25_1                 : signed(15 DOWNTO 0) := to_signed(2865, 16); -- sfix16_En17
  CONSTANT coeffphase25_2                 : signed(15 DOWNTO 0) := to_signed(0, 16); -- sfix16_En17

  -- Signals
  SIGNAL ring_count                       : unsigned(24 DOWNTO 0); -- ufix25
  SIGNAL phase_0                          : std_logic; -- boolean
  SIGNAL phase_1                          : std_logic; -- boolean
  SIGNAL phase_2                          : std_logic; -- boolean
  SIGNAL phase_3                          : std_logic; -- boolean
  SIGNAL phase_4                          : std_logic; -- boolean
  SIGNAL phase_5                          : std_logic; -- boolean
  SIGNAL phase_6                          : std_logic; -- boolean
  SIGNAL phase_7                          : std_logic; -- boolean
  SIGNAL phase_8                          : std_logic; -- boolean
  SIGNAL phase_9                          : std_logic; -- boolean
  SIGNAL phase_10                         : std_logic; -- boolean
  SIGNAL phase_11                         : std_logic; -- boolean
  SIGNAL phase_12                         : std_logic; -- boolean
  SIGNAL phase_13                         : std_logic; -- boolean
  SIGNAL phase_14                         : std_logic; -- boolean
  SIGNAL phase_15                         : std_logic; -- boolean
  SIGNAL phase_16                         : std_logic; -- boolean
  SIGNAL phase_17                         : std_logic; -- boolean
  SIGNAL phase_18                         : std_logic; -- boolean
  SIGNAL phase_19                         : std_logic; -- boolean
  SIGNAL phase_20                         : std_logic; -- boolean
  SIGNAL phase_21                         : std_logic; -- boolean
  SIGNAL phase_22                         : std_logic; -- boolean
  SIGNAL phase_23                         : std_logic; -- boolean
  SIGNAL phase_24                         : std_logic; -- boolean
  SIGNAL ce_out_reg                       : std_logic; -- boolean
  SIGNAL input_register                   : signed(17 DOWNTO 0); -- sfix18
  SIGNAL input_pipeline_phase0            : signed(17 DOWNTO 0); -- sfix18
  SIGNAL input_pipeline_phase1            : input_pipeline_type(0 TO 1); -- sfix18
  SIGNAL input_pipeline_phase2            : input_pipeline_type(0 TO 1); -- sfix18
  SIGNAL input_pipeline_phase3            : input_pipeline_type(0 TO 1); -- sfix18
  SIGNAL input_pipeline_phase4            : input_pipeline_type(0 TO 1); -- sfix18
  SIGNAL input_pipeline_phase5            : input_pipeline_type(0 TO 1); -- sfix18
  SIGNAL input_pipeline_phase6            : input_pipeline_type(0 TO 1); -- sfix18
  SIGNAL input_pipeline_phase7            : input_pipeline_type(0 TO 1); -- sfix18
  SIGNAL input_pipeline_phase8            : input_pipeline_type(0 TO 1); -- sfix18
  SIGNAL input_pipeline_phase9            : input_pipeline_type(0 TO 1); -- sfix18
  SIGNAL input_pipeline_phase10           : signed(17 DOWNTO 0); -- sfix18
  SIGNAL input_pipeline_phase11           : signed(17 DOWNTO 0); -- sfix18
  SIGNAL input_pipeline_phase12           : signed(17 DOWNTO 0); -- sfix18
  SIGNAL input_pipeline_phase13           : signed(17 DOWNTO 0); -- sfix18
  SIGNAL input_pipeline_phase14           : signed(17 DOWNTO 0); -- sfix18
  SIGNAL input_pipeline_phase15           : signed(17 DOWNTO 0); -- sfix18
  SIGNAL input_pipeline_phase16           : signed(17 DOWNTO 0); -- sfix18
  SIGNAL input_pipeline_phase17           : signed(17 DOWNTO 0); -- sfix18
  SIGNAL input_pipeline_phase18           : signed(17 DOWNTO 0); -- sfix18
  SIGNAL input_pipeline_phase19           : signed(17 DOWNTO 0); -- sfix18
  SIGNAL input_pipeline_phase20           : signed(17 DOWNTO 0); -- sfix18
  SIGNAL input_pipeline_phase21           : signed(17 DOWNTO 0); -- sfix18
  SIGNAL input_pipeline_phase22           : signed(17 DOWNTO 0); -- sfix18
  SIGNAL input_pipeline_phase23           : signed(17 DOWNTO 0); -- sfix18
  SIGNAL input_pipeline_phase24           : signed(17 DOWNTO 0); -- sfix18
  SIGNAL product_phase0_1                 : signed(33 DOWNTO 0); -- sfix34_En17
  SIGNAL product_phase0_2                 : signed(33 DOWNTO 0); -- sfix34_En17
  SIGNAL product_phase1_1                 : signed(33 DOWNTO 0); -- sfix34_En17
  SIGNAL product_phase1_2                 : signed(33 DOWNTO 0); -- sfix34_En17
  SIGNAL product_phase2_1                 : signed(33 DOWNTO 0); -- sfix34_En17
  SIGNAL product_phase2_2                 : signed(33 DOWNTO 0); -- sfix34_En17
  SIGNAL product_phase3_1                 : signed(33 DOWNTO 0); -- sfix34_En17
  SIGNAL product_phase3_2                 : signed(33 DOWNTO 0); -- sfix34_En17
  SIGNAL product_phase4_1                 : signed(33 DOWNTO 0); -- sfix34_En17
  SIGNAL product_phase4_2                 : signed(33 DOWNTO 0); -- sfix34_En17
  SIGNAL product_phase5_1                 : signed(33 DOWNTO 0); -- sfix34_En17
  SIGNAL product_phase5_2                 : signed(33 DOWNTO 0); -- sfix34_En17
  SIGNAL product_phase6_1                 : signed(33 DOWNTO 0); -- sfix34_En17
  SIGNAL product_phase6_2                 : signed(33 DOWNTO 0); -- sfix34_En17
  SIGNAL product_phase7_1                 : signed(33 DOWNTO 0); -- sfix34_En17
  SIGNAL product_phase7_2                 : signed(33 DOWNTO 0); -- sfix34_En17
  SIGNAL product_phase8_1                 : signed(33 DOWNTO 0); -- sfix34_En17
  SIGNAL product_phase8_2                 : signed(33 DOWNTO 0); -- sfix34_En17
  SIGNAL product_phase9_1                 : signed(33 DOWNTO 0); -- sfix34_En17
  SIGNAL product_phase9_2                 : signed(33 DOWNTO 0); -- sfix34_En17
  SIGNAL product_phase10_1                : signed(33 DOWNTO 0); -- sfix34_En17
  SIGNAL product_phase11_1                : signed(33 DOWNTO 0); -- sfix34_En17
  SIGNAL product_phase12_1                : signed(33 DOWNTO 0); -- sfix34_En17
  SIGNAL product_phase13_1                : signed(33 DOWNTO 0); -- sfix34_En17
  SIGNAL product_phase14_1                : signed(33 DOWNTO 0); -- sfix34_En17
  SIGNAL product_phase15_1                : signed(33 DOWNTO 0); -- sfix34_En17
  SIGNAL product_phase16_1                : signed(33 DOWNTO 0); -- sfix34_En17
  SIGNAL product_phase17_1                : signed(33 DOWNTO 0); -- sfix34_En17
  SIGNAL product_phase18_1                : signed(33 DOWNTO 0); -- sfix34_En17
  SIGNAL product_phase19_1                : signed(33 DOWNTO 0); -- sfix34_En17
  SIGNAL product_phase20_1                : signed(33 DOWNTO 0); -- sfix34_En17
  SIGNAL product_phase21_1                : signed(33 DOWNTO 0); -- sfix34_En17
  SIGNAL product_phase22_1                : signed(33 DOWNTO 0); -- sfix34_En17
  SIGNAL product_phase23_1                : signed(33 DOWNTO 0); -- sfix34_En17
  SIGNAL product_phase24_1                : signed(33 DOWNTO 0); -- sfix34_En17
  SIGNAL sum1_1                           : signed(34 DOWNTO 0); -- sfix35_En17
  SIGNAL sum1_2                           : signed(34 DOWNTO 0); -- sfix35_En17
  SIGNAL sum1_3                           : signed(34 DOWNTO 0); -- sfix35_En17
  SIGNAL sum1_4                           : signed(34 DOWNTO 0); -- sfix35_En17
  SIGNAL sum1_5                           : signed(34 DOWNTO 0); -- sfix35_En17
  SIGNAL sum1_6                           : signed(34 DOWNTO 0); -- sfix35_En17
  SIGNAL sum1_7                           : signed(34 DOWNTO 0); -- sfix35_En17
  SIGNAL sum1_8                           : signed(34 DOWNTO 0); -- sfix35_En17
  SIGNAL sum1_9                           : signed(34 DOWNTO 0); -- sfix35_En17
  SIGNAL sum1_10                          : signed(34 DOWNTO 0); -- sfix35_En17
  SIGNAL sum1_11                          : signed(34 DOWNTO 0); -- sfix35_En17
  SIGNAL sum1_12                          : signed(34 DOWNTO 0); -- sfix35_En17
  SIGNAL sum1_13                          : signed(34 DOWNTO 0); -- sfix35_En17
  SIGNAL sum1_14                          : signed(34 DOWNTO 0); -- sfix35_En17
  SIGNAL sum1_15                          : signed(34 DOWNTO 0); -- sfix35_En17
  SIGNAL sum1_16                          : signed(34 DOWNTO 0); -- sfix35_En17
  SIGNAL sum1_17                          : signed(34 DOWNTO 0); -- sfix35_En17
  SIGNAL sum2_1                           : signed(34 DOWNTO 0); -- sfix35_En17
  SIGNAL add_temp                         : signed(35 DOWNTO 0); -- sfix36_En17
  SIGNAL sum2_2                           : signed(34 DOWNTO 0); -- sfix35_En17
  SIGNAL add_temp_1                       : signed(35 DOWNTO 0); -- sfix36_En17
  SIGNAL sum2_3                           : signed(34 DOWNTO 0); -- sfix35_En17
  SIGNAL add_temp_2                       : signed(35 DOWNTO 0); -- sfix36_En17
  SIGNAL sum2_4                           : signed(34 DOWNTO 0); -- sfix35_En17
  SIGNAL add_temp_3                       : signed(35 DOWNTO 0); -- sfix36_En17
  SIGNAL sum2_5                           : signed(34 DOWNTO 0); -- sfix35_En17
  SIGNAL add_temp_4                       : signed(35 DOWNTO 0); -- sfix36_En17
  SIGNAL sum2_6                           : signed(34 DOWNTO 0); -- sfix35_En17
  SIGNAL add_temp_5                       : signed(35 DOWNTO 0); -- sfix36_En17
  SIGNAL sum2_7                           : signed(34 DOWNTO 0); -- sfix35_En17
  SIGNAL add_temp_6                       : signed(35 DOWNTO 0); -- sfix36_En17
  SIGNAL sum2_8                           : signed(34 DOWNTO 0); -- sfix35_En17
  SIGNAL add_temp_7                       : signed(35 DOWNTO 0); -- sfix36_En17
  SIGNAL sum2_9                           : signed(34 DOWNTO 0); -- sfix35_En17
  SIGNAL add_temp_8                       : signed(35 DOWNTO 0); -- sfix36_En17
  SIGNAL sum3_1                           : signed(34 DOWNTO 0); -- sfix35_En17
  SIGNAL add_temp_9                       : signed(35 DOWNTO 0); -- sfix36_En17
  SIGNAL sum3_2                           : signed(34 DOWNTO 0); -- sfix35_En17
  SIGNAL add_temp_10                      : signed(35 DOWNTO 0); -- sfix36_En17
  SIGNAL sum3_3                           : signed(34 DOWNTO 0); -- sfix35_En17
  SIGNAL add_temp_11                      : signed(35 DOWNTO 0); -- sfix36_En17
  SIGNAL sum3_4                           : signed(34 DOWNTO 0); -- sfix35_En17
  SIGNAL add_temp_12                      : signed(35 DOWNTO 0); -- sfix36_En17
  SIGNAL sum4_1                           : signed(34 DOWNTO 0); -- sfix35_En17
  SIGNAL add_temp_13                      : signed(35 DOWNTO 0); -- sfix36_En17
  SIGNAL sum4_2                           : signed(34 DOWNTO 0); -- sfix35_En17
  SIGNAL add_temp_14                      : signed(35 DOWNTO 0); -- sfix36_En17
  SIGNAL sum5_1                           : signed(34 DOWNTO 0); -- sfix35_En17
  SIGNAL add_temp_15                      : signed(35 DOWNTO 0); -- sfix36_En17
  SIGNAL sum6_1                           : signed(34 DOWNTO 0); -- sfix35_En17
  SIGNAL add_temp_16                      : signed(35 DOWNTO 0); -- sfix36_En17
  SIGNAL output_typeconvert               : signed(34 DOWNTO 0); -- sfix35_En17
  SIGNAL output_register                  : signed(34 DOWNTO 0); -- sfix35_En17


BEGIN

  -- Block Statements
  ce_output : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      ring_count <= to_unsigned(1, 25);
    ELSIF clk'event AND clk = '1' THEN
      IF clk_enable = '1' THEN
        ring_count <= ring_count(0) & ring_count(24 DOWNTO 1);
      END IF;
    END IF; 
  END PROCESS ce_output;

  phase_0 <= ring_count(0)  AND clk_enable;

  phase_1 <= ring_count(1)  AND clk_enable;

  phase_2 <= ring_count(2)  AND clk_enable;

  phase_3 <= ring_count(3)  AND clk_enable;

  phase_4 <= ring_count(4)  AND clk_enable;

  phase_5 <= ring_count(5)  AND clk_enable;

  phase_6 <= ring_count(6)  AND clk_enable;

  phase_7 <= ring_count(7)  AND clk_enable;

  phase_8 <= ring_count(8)  AND clk_enable;

  phase_9 <= ring_count(9)  AND clk_enable;

  phase_10 <= ring_count(10)  AND clk_enable;

  phase_11 <= ring_count(11)  AND clk_enable;

  phase_12 <= ring_count(12)  AND clk_enable;

  phase_13 <= ring_count(13)  AND clk_enable;

  phase_14 <= ring_count(14)  AND clk_enable;

  phase_15 <= ring_count(15)  AND clk_enable;

  phase_16 <= ring_count(16)  AND clk_enable;

  phase_17 <= ring_count(17)  AND clk_enable;

  phase_18 <= ring_count(18)  AND clk_enable;

  phase_19 <= ring_count(19)  AND clk_enable;

  phase_20 <= ring_count(20)  AND clk_enable;

  phase_21 <= ring_count(21)  AND clk_enable;

  phase_22 <= ring_count(22)  AND clk_enable;

  phase_23 <= ring_count(23)  AND clk_enable;

  phase_24 <= ring_count(24)  AND clk_enable;

  --   ------------------ CE Output Register ------------------

  ce_output_register : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      ce_out_reg <= '0';
    ELSIF clk'event AND clk = '1' THEN
      ce_out_reg <= phase_24;
      
    END IF; 
  END PROCESS ce_output_register;

  input_reg_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      input_register <= (OTHERS => '0');
    ELSIF clk'event AND clk = '1' THEN
      IF clk_enable = '1' THEN
        input_register <= signed(filter_in);
      END IF;
    END IF; 
  END PROCESS input_reg_process;

  Delay_Pipeline_Phase0_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      input_pipeline_phase0 <= (OTHERS => '0');
    ELSIF clk'event AND clk = '1' THEN
      IF phase_24 = '1' THEN
        input_pipeline_phase0 <= input_register;
      END IF;
    END IF; 
  END PROCESS Delay_Pipeline_Phase0_process;

  Delay_Pipeline_Phase1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      input_pipeline_phase1(0 TO 1) <= (OTHERS => (OTHERS => '0'));
    ELSIF clk'event AND clk = '1' THEN
      IF phase_0 = '1' THEN
        input_pipeline_phase1(0) <= input_register;
        input_pipeline_phase1(1) <= input_pipeline_phase1(0);
      END IF;
    END IF; 
  END PROCESS Delay_Pipeline_Phase1_process;

  Delay_Pipeline_Phase2_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      input_pipeline_phase2(0 TO 1) <= (OTHERS => (OTHERS => '0'));
    ELSIF clk'event AND clk = '1' THEN
      IF phase_1 = '1' THEN
        input_pipeline_phase2(0) <= input_register;
        input_pipeline_phase2(1) <= input_pipeline_phase2(0);
      END IF;
    END IF; 
  END PROCESS Delay_Pipeline_Phase2_process;

  Delay_Pipeline_Phase3_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      input_pipeline_phase3(0 TO 1) <= (OTHERS => (OTHERS => '0'));
    ELSIF clk'event AND clk = '1' THEN
      IF phase_2 = '1' THEN
        input_pipeline_phase3(0) <= input_register;
        input_pipeline_phase3(1) <= input_pipeline_phase3(0);
      END IF;
    END IF; 
  END PROCESS Delay_Pipeline_Phase3_process;

  Delay_Pipeline_Phase4_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      input_pipeline_phase4(0 TO 1) <= (OTHERS => (OTHERS => '0'));
    ELSIF clk'event AND clk = '1' THEN
      IF phase_3 = '1' THEN
        input_pipeline_phase4(0) <= input_register;
        input_pipeline_phase4(1) <= input_pipeline_phase4(0);
      END IF;
    END IF; 
  END PROCESS Delay_Pipeline_Phase4_process;

  Delay_Pipeline_Phase5_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      input_pipeline_phase5(0 TO 1) <= (OTHERS => (OTHERS => '0'));
    ELSIF clk'event AND clk = '1' THEN
      IF phase_4 = '1' THEN
        input_pipeline_phase5(0) <= input_register;
        input_pipeline_phase5(1) <= input_pipeline_phase5(0);
      END IF;
    END IF; 
  END PROCESS Delay_Pipeline_Phase5_process;

  Delay_Pipeline_Phase6_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      input_pipeline_phase6(0 TO 1) <= (OTHERS => (OTHERS => '0'));
    ELSIF clk'event AND clk = '1' THEN
      IF phase_5 = '1' THEN
        input_pipeline_phase6(0) <= input_register;
        input_pipeline_phase6(1) <= input_pipeline_phase6(0);
      END IF;
    END IF; 
  END PROCESS Delay_Pipeline_Phase6_process;

  Delay_Pipeline_Phase7_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      input_pipeline_phase7(0 TO 1) <= (OTHERS => (OTHERS => '0'));
    ELSIF clk'event AND clk = '1' THEN
      IF phase_6 = '1' THEN
        input_pipeline_phase7(0) <= input_register;
        input_pipeline_phase7(1) <= input_pipeline_phase7(0);
      END IF;
    END IF; 
  END PROCESS Delay_Pipeline_Phase7_process;

  Delay_Pipeline_Phase8_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      input_pipeline_phase8(0 TO 1) <= (OTHERS => (OTHERS => '0'));
    ELSIF clk'event AND clk = '1' THEN
      IF phase_7 = '1' THEN
        input_pipeline_phase8(0) <= input_register;
        input_pipeline_phase8(1) <= input_pipeline_phase8(0);
      END IF;
    END IF; 
  END PROCESS Delay_Pipeline_Phase8_process;

  Delay_Pipeline_Phase9_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      input_pipeline_phase9(0 TO 1) <= (OTHERS => (OTHERS => '0'));
    ELSIF clk'event AND clk = '1' THEN
      IF phase_8 = '1' THEN
        input_pipeline_phase9(0) <= input_register;
        input_pipeline_phase9(1) <= input_pipeline_phase9(0);
      END IF;
    END IF; 
  END PROCESS Delay_Pipeline_Phase9_process;

  Delay_Pipeline_Phase10_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      input_pipeline_phase10 <= (OTHERS => '0');
    ELSIF clk'event AND clk = '1' THEN
      IF phase_9 = '1' THEN
        input_pipeline_phase10 <= input_register;
      END IF;
    END IF; 
  END PROCESS Delay_Pipeline_Phase10_process;

  Delay_Pipeline_Phase11_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      input_pipeline_phase11 <= (OTHERS => '0');
    ELSIF clk'event AND clk = '1' THEN
      IF phase_10 = '1' THEN
        input_pipeline_phase11 <= input_register;
      END IF;
    END IF; 
  END PROCESS Delay_Pipeline_Phase11_process;

  Delay_Pipeline_Phase12_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      input_pipeline_phase12 <= (OTHERS => '0');
    ELSIF clk'event AND clk = '1' THEN
      IF phase_11 = '1' THEN
        input_pipeline_phase12 <= input_register;
      END IF;
    END IF; 
  END PROCESS Delay_Pipeline_Phase12_process;

  Delay_Pipeline_Phase13_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      input_pipeline_phase13 <= (OTHERS => '0');
    ELSIF clk'event AND clk = '1' THEN
      IF phase_12 = '1' THEN
        input_pipeline_phase13 <= input_register;
      END IF;
    END IF; 
  END PROCESS Delay_Pipeline_Phase13_process;

  Delay_Pipeline_Phase14_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      input_pipeline_phase14 <= (OTHERS => '0');
    ELSIF clk'event AND clk = '1' THEN
      IF phase_13 = '1' THEN
        input_pipeline_phase14 <= input_register;
      END IF;
    END IF; 
  END PROCESS Delay_Pipeline_Phase14_process;

  Delay_Pipeline_Phase15_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      input_pipeline_phase15 <= (OTHERS => '0');
    ELSIF clk'event AND clk = '1' THEN
      IF phase_14 = '1' THEN
        input_pipeline_phase15 <= input_register;
      END IF;
    END IF; 
  END PROCESS Delay_Pipeline_Phase15_process;

  Delay_Pipeline_Phase16_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      input_pipeline_phase16 <= (OTHERS => '0');
    ELSIF clk'event AND clk = '1' THEN
      IF phase_15 = '1' THEN
        input_pipeline_phase16 <= input_register;
      END IF;
    END IF; 
  END PROCESS Delay_Pipeline_Phase16_process;

  Delay_Pipeline_Phase17_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      input_pipeline_phase17 <= (OTHERS => '0');
    ELSIF clk'event AND clk = '1' THEN
      IF phase_16 = '1' THEN
        input_pipeline_phase17 <= input_register;
      END IF;
    END IF; 
  END PROCESS Delay_Pipeline_Phase17_process;

  Delay_Pipeline_Phase18_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      input_pipeline_phase18 <= (OTHERS => '0');
    ELSIF clk'event AND clk = '1' THEN
      IF phase_17 = '1' THEN
        input_pipeline_phase18 <= input_register;
      END IF;
    END IF; 
  END PROCESS Delay_Pipeline_Phase18_process;

  Delay_Pipeline_Phase19_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      input_pipeline_phase19 <= (OTHERS => '0');
    ELSIF clk'event AND clk = '1' THEN
      IF phase_18 = '1' THEN
        input_pipeline_phase19 <= input_register;
      END IF;
    END IF; 
  END PROCESS Delay_Pipeline_Phase19_process;

  Delay_Pipeline_Phase20_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      input_pipeline_phase20 <= (OTHERS => '0');
    ELSIF clk'event AND clk = '1' THEN
      IF phase_19 = '1' THEN
        input_pipeline_phase20 <= input_register;
      END IF;
    END IF; 
  END PROCESS Delay_Pipeline_Phase20_process;

  Delay_Pipeline_Phase21_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      input_pipeline_phase21 <= (OTHERS => '0');
    ELSIF clk'event AND clk = '1' THEN
      IF phase_20 = '1' THEN
        input_pipeline_phase21 <= input_register;
      END IF;
    END IF; 
  END PROCESS Delay_Pipeline_Phase21_process;

  Delay_Pipeline_Phase22_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      input_pipeline_phase22 <= (OTHERS => '0');
    ELSIF clk'event AND clk = '1' THEN
      IF phase_21 = '1' THEN
        input_pipeline_phase22 <= input_register;
      END IF;
    END IF; 
  END PROCESS Delay_Pipeline_Phase22_process;

  Delay_Pipeline_Phase23_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      input_pipeline_phase23 <= (OTHERS => '0');
    ELSIF clk'event AND clk = '1' THEN
      IF phase_22 = '1' THEN
        input_pipeline_phase23 <= input_register;
      END IF;
    END IF; 
  END PROCESS Delay_Pipeline_Phase23_process;

  Delay_Pipeline_Phase24_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      input_pipeline_phase24 <= (OTHERS => '0');
    ELSIF clk'event AND clk = '1' THEN
      IF phase_23 = '1' THEN
        input_pipeline_phase24 <= input_register;
      END IF;
    END IF; 
  END PROCESS Delay_Pipeline_Phase24_process;

  product_phase0_1 <= input_register * coeffphase1_1;

  product_phase0_2 <= input_pipeline_phase0 * coeffphase1_2;

  product_phase1_1 <= input_pipeline_phase1(0) * coeffphase2_1;

  product_phase1_2 <= input_pipeline_phase1(1) * coeffphase2_2;

  product_phase2_1 <= input_pipeline_phase2(0) * coeffphase3_1;

  product_phase2_2 <= input_pipeline_phase2(1) * coeffphase3_2;

  product_phase3_1 <= input_pipeline_phase3(0) * coeffphase4_1;

  product_phase3_2 <= input_pipeline_phase3(1) * coeffphase4_2;

  product_phase4_1 <= input_pipeline_phase4(0) * coeffphase5_1;

  product_phase4_2 <= input_pipeline_phase4(1) * coeffphase5_2;

  product_phase5_1 <= input_pipeline_phase5(0) * coeffphase6_1;

  product_phase5_2 <= input_pipeline_phase5(1) * coeffphase6_2;

  product_phase6_1 <= input_pipeline_phase6(0) * coeffphase7_1;

  product_phase6_2 <= input_pipeline_phase6(1) * coeffphase7_2;

  product_phase7_1 <= input_pipeline_phase7(0) * coeffphase8_1;

  product_phase7_2 <= input_pipeline_phase7(1) * coeffphase8_2;

  product_phase8_1 <= input_pipeline_phase8(0) * coeffphase9_1;

  product_phase8_2 <= input_pipeline_phase8(1) * coeffphase9_2;

  product_phase9_1 <= input_pipeline_phase9(0) * coeffphase10_1;

  product_phase9_2 <= input_pipeline_phase9(1) * coeffphase10_2;

  product_phase10_1 <= input_pipeline_phase10 * coeffphase11_1;

  product_phase11_1 <= input_pipeline_phase11 * coeffphase12_1;

  product_phase12_1 <= input_pipeline_phase12 * coeffphase13_1;

  product_phase13_1 <= input_pipeline_phase13 * coeffphase14_1;

  product_phase14_1 <= input_pipeline_phase14 * coeffphase15_1;

  product_phase15_1 <= input_pipeline_phase15 * coeffphase16_1;

  product_phase16_1 <= input_pipeline_phase16 * coeffphase17_1;

  product_phase17_1 <= input_pipeline_phase17 * coeffphase18_1;

  product_phase18_1 <= input_pipeline_phase18 * coeffphase19_1;

  product_phase19_1 <= input_pipeline_phase19 * coeffphase20_1;

  product_phase20_1 <= input_pipeline_phase20 * coeffphase21_1;

  product_phase21_1 <= input_pipeline_phase21 * coeffphase22_1;

  product_phase22_1 <= input_pipeline_phase22 * coeffphase23_1;

  product_phase23_1 <= input_pipeline_phase23 * coeffphase24_1;

  product_phase24_1 <= input_pipeline_phase24 * coeffphase25_1;

  sum1_1 <= resize(product_phase24_1, 35) + resize(product_phase23_1, 35);

  sum1_2 <= resize(product_phase22_1, 35) + resize(product_phase21_1, 35);

  sum1_3 <= resize(product_phase20_1, 35) + resize(product_phase19_1, 35);

  sum1_4 <= resize(product_phase18_1, 35) + resize(product_phase17_1, 35);

  sum1_5 <= resize(product_phase16_1, 35) + resize(product_phase15_1, 35);

  sum1_6 <= resize(product_phase14_1, 35) + resize(product_phase13_1, 35);

  sum1_7 <= resize(product_phase12_1, 35) + resize(product_phase11_1, 35);

  sum1_8 <= resize(product_phase10_1, 35) + resize(product_phase9_1, 35);

  sum1_9 <= resize(product_phase9_2, 35) + resize(product_phase8_1, 35);

  sum1_10 <= resize(product_phase8_2, 35) + resize(product_phase7_1, 35);

  sum1_11 <= resize(product_phase7_2, 35) + resize(product_phase6_1, 35);

  sum1_12 <= resize(product_phase6_2, 35) + resize(product_phase5_1, 35);

  sum1_13 <= resize(product_phase5_2, 35) + resize(product_phase4_1, 35);

  sum1_14 <= resize(product_phase4_2, 35) + resize(product_phase3_1, 35);

  sum1_15 <= resize(product_phase3_2, 35) + resize(product_phase2_1, 35);

  sum1_16 <= resize(product_phase2_2, 35) + resize(product_phase1_1, 35);

  sum1_17 <= resize(product_phase1_2, 35) + resize(product_phase0_1, 35);

  add_temp <= resize(sum1_1, 36) + resize(sum1_2, 36);
  sum2_1 <= add_temp(34 DOWNTO 0);

  add_temp_1 <= resize(sum1_3, 36) + resize(sum1_4, 36);
  sum2_2 <= add_temp_1(34 DOWNTO 0);

  add_temp_2 <= resize(sum1_5, 36) + resize(sum1_6, 36);
  sum2_3 <= add_temp_2(34 DOWNTO 0);

  add_temp_3 <= resize(sum1_7, 36) + resize(sum1_8, 36);
  sum2_4 <= add_temp_3(34 DOWNTO 0);

  add_temp_4 <= resize(sum1_9, 36) + resize(sum1_10, 36);
  sum2_5 <= add_temp_4(34 DOWNTO 0);

  add_temp_5 <= resize(sum1_11, 36) + resize(sum1_12, 36);
  sum2_6 <= add_temp_5(34 DOWNTO 0);

  add_temp_6 <= resize(sum1_13, 36) + resize(sum1_14, 36);
  sum2_7 <= add_temp_6(34 DOWNTO 0);

  add_temp_7 <= resize(sum1_15, 36) + resize(sum1_16, 36);
  sum2_8 <= add_temp_7(34 DOWNTO 0);

  add_temp_8 <= resize(sum1_17, 36) + resize(product_phase0_2, 36);
  sum2_9 <= add_temp_8(34 DOWNTO 0);

  add_temp_9 <= resize(sum2_1, 36) + resize(sum2_2, 36);
  sum3_1 <= add_temp_9(34 DOWNTO 0);

  add_temp_10 <= resize(sum2_3, 36) + resize(sum2_4, 36);
  sum3_2 <= add_temp_10(34 DOWNTO 0);

  add_temp_11 <= resize(sum2_5, 36) + resize(sum2_6, 36);
  sum3_3 <= add_temp_11(34 DOWNTO 0);

  add_temp_12 <= resize(sum2_7, 36) + resize(sum2_8, 36);
  sum3_4 <= add_temp_12(34 DOWNTO 0);

  add_temp_13 <= resize(sum3_1, 36) + resize(sum3_2, 36);
  sum4_1 <= add_temp_13(34 DOWNTO 0);

  add_temp_14 <= resize(sum3_3, 36) + resize(sum3_4, 36);
  sum4_2 <= add_temp_14(34 DOWNTO 0);

  add_temp_15 <= resize(sum4_1, 36) + resize(sum4_2, 36);
  sum5_1 <= add_temp_15(34 DOWNTO 0);

  add_temp_16 <= resize(sum5_1, 36) + resize(sum2_9, 36);
  sum6_1 <= add_temp_16(34 DOWNTO 0);

  output_typeconvert <= sum6_1;

  output_register_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      output_register <= (OTHERS => '0');
    ELSIF clk'event AND clk = '1' THEN
      IF phase_24 = '1' THEN
        output_register <= output_typeconvert;
      END IF;
    END IF; 
  END PROCESS output_register_process;

  -- Assignment Statements
  ce_out <= ce_out_reg;
  filter_out <= std_logic_vector(output_register);
END rtl;
