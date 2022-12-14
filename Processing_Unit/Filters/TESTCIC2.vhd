-- -------------------------------------------------------------
--
-- Module: TESTCIC2
-- Generated by MATLAB(R) 9.10 and Filter Design HDL Coder 3.1.9.
-- Generated on: 2022-09-14 12:34:21
-- -------------------------------------------------------------

-- -------------------------------------------------------------
-- HDL Code Generation Options:
--
-- TargetLanguage: VHDL
-- TargetDirectory: C:\Users\Elia Yfrach\Desktop\Project\Processing_Unit\Filters
-- Name: TESTCIC2
-- TestBenchName: TESTCIC2_tb
-- TestBenchStimulus: step ramp chirp noise 

-- Filter Specifications:
--
-- Sample Rate        : 45.955 kHz
-- Response           : CIC Compensator
-- Specification      : Fp,Fst,Ap,Ast
-- Decimation Factor  : 10
-- Multirate Type     : Decimator
-- Number of Sections : 2
-- Stopband Edge      : 2.3 kHz
-- Differential Delay : 1
-- Stopband Atten.    : 10 dB
-- Passband Ripple    : 1 dB
-- Passband Edge      : 150 Hz
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
-- Decimation Factor  : 10
-- Polyphase Length   : 2
-- Filter Length      : 13
-- Stable             : Yes
-- Linear Phase       : Yes (Type 1)
--
-- Arithmetic         : fixed
-- Numerator          : s18,19 -> [-2.500000e-01 2.500000e-01)
-- -------------------------------------------------------------



LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.numeric_std.ALL;

ENTITY TESTCIC2 IS
   PORT( clk                             :   IN    std_logic; 
         clk_enable                      :   IN    std_logic; 
         reset                           :   IN    std_logic; 
         filter_in                       :   IN    std_logic_vector(17 DOWNTO 0); -- sfix18
         filter_out                      :   OUT   std_logic_vector(36 DOWNTO 0); -- sfix37_En19
         ce_out                          :   OUT   std_logic  
         );

END TESTCIC2;


----------------------------------------------------------------
--Module Architecture: TESTCIC2
----------------------------------------------------------------
ARCHITECTURE rtl OF TESTCIC2 IS
  -- Local Functions
  -- Type Definitions
  TYPE input_pipeline_type IS ARRAY (NATURAL range <>) OF signed(17 DOWNTO 0); -- sfix18
  -- Constants
  CONSTANT coeffphase1_1                  : signed(17 DOWNTO 0) := to_signed(85273, 18); -- sfix18_En19
  CONSTANT coeffphase1_2                  : signed(17 DOWNTO 0) := to_signed(27852, 18); -- sfix18_En19
  CONSTANT coeffphase2_1                  : signed(17 DOWNTO 0) := to_signed(25077, 18); -- sfix18_En19
  CONSTANT coeffphase2_2                  : signed(17 DOWNTO 0) := to_signed(25077, 18); -- sfix18_En19
  CONSTANT coeffphase3_1                  : signed(17 DOWNTO 0) := to_signed(27852, 18); -- sfix18_En19
  CONSTANT coeffphase3_2                  : signed(17 DOWNTO 0) := to_signed(85273, 18); -- sfix18_En19
  CONSTANT coeffphase4_1                  : signed(17 DOWNTO 0) := to_signed(30126, 18); -- sfix18_En19
  CONSTANT coeffphase4_2                  : signed(17 DOWNTO 0) := to_signed(0, 18); -- sfix18_En19
  CONSTANT coeffphase5_1                  : signed(17 DOWNTO 0) := to_signed(31834, 18); -- sfix18_En19
  CONSTANT coeffphase5_2                  : signed(17 DOWNTO 0) := to_signed(0, 18); -- sfix18_En19
  CONSTANT coeffphase6_1                  : signed(17 DOWNTO 0) := to_signed(32954, 18); -- sfix18_En19
  CONSTANT coeffphase6_2                  : signed(17 DOWNTO 0) := to_signed(0, 18); -- sfix18_En19
  CONSTANT coeffphase7_1                  : signed(17 DOWNTO 0) := to_signed(33285, 18); -- sfix18_En19
  CONSTANT coeffphase7_2                  : signed(17 DOWNTO 0) := to_signed(0, 18); -- sfix18_En19
  CONSTANT coeffphase8_1                  : signed(17 DOWNTO 0) := to_signed(32954, 18); -- sfix18_En19
  CONSTANT coeffphase8_2                  : signed(17 DOWNTO 0) := to_signed(0, 18); -- sfix18_En19
  CONSTANT coeffphase9_1                  : signed(17 DOWNTO 0) := to_signed(31834, 18); -- sfix18_En19
  CONSTANT coeffphase9_2                  : signed(17 DOWNTO 0) := to_signed(0, 18); -- sfix18_En19
  CONSTANT coeffphase10_1                 : signed(17 DOWNTO 0) := to_signed(30126, 18); -- sfix18_En19
  CONSTANT coeffphase10_2                 : signed(17 DOWNTO 0) := to_signed(0, 18); -- sfix18_En19

  -- Signals
  SIGNAL ring_count                       : unsigned(9 DOWNTO 0); -- ufix10
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
  SIGNAL ce_out_reg                       : std_logic; -- boolean
  SIGNAL input_register                   : signed(17 DOWNTO 0); -- sfix18
  SIGNAL input_pipeline_phase0            : signed(17 DOWNTO 0); -- sfix18
  SIGNAL input_pipeline_phase1            : input_pipeline_type(0 TO 1); -- sfix18
  SIGNAL input_pipeline_phase2            : input_pipeline_type(0 TO 1); -- sfix18
  SIGNAL input_pipeline_phase3            : signed(17 DOWNTO 0); -- sfix18
  SIGNAL input_pipeline_phase4            : signed(17 DOWNTO 0); -- sfix18
  SIGNAL input_pipeline_phase5            : signed(17 DOWNTO 0); -- sfix18
  SIGNAL input_pipeline_phase6            : signed(17 DOWNTO 0); -- sfix18
  SIGNAL input_pipeline_phase7            : signed(17 DOWNTO 0); -- sfix18
  SIGNAL input_pipeline_phase8            : signed(17 DOWNTO 0); -- sfix18
  SIGNAL input_pipeline_phase9            : signed(17 DOWNTO 0); -- sfix18
  SIGNAL product_phase0_1                 : signed(35 DOWNTO 0); -- sfix36_En19
  SIGNAL product_phase0_2                 : signed(35 DOWNTO 0); -- sfix36_En19
  SIGNAL product_phase1_1                 : signed(35 DOWNTO 0); -- sfix36_En19
  SIGNAL product_phase1_2                 : signed(35 DOWNTO 0); -- sfix36_En19
  SIGNAL product_phase2_1                 : signed(35 DOWNTO 0); -- sfix36_En19
  SIGNAL product_phase2_2                 : signed(35 DOWNTO 0); -- sfix36_En19
  SIGNAL product_phase3_1                 : signed(35 DOWNTO 0); -- sfix36_En19
  SIGNAL product_phase4_1                 : signed(35 DOWNTO 0); -- sfix36_En19
  SIGNAL product_phase5_1                 : signed(35 DOWNTO 0); -- sfix36_En19
  SIGNAL product_phase6_1                 : signed(35 DOWNTO 0); -- sfix36_En19
  SIGNAL product_phase7_1                 : signed(35 DOWNTO 0); -- sfix36_En19
  SIGNAL product_phase8_1                 : signed(35 DOWNTO 0); -- sfix36_En19
  SIGNAL product_phase9_1                 : signed(35 DOWNTO 0); -- sfix36_En19
  SIGNAL quantized_sum                    : signed(36 DOWNTO 0); -- sfix37_En19
  SIGNAL sum1                             : signed(36 DOWNTO 0); -- sfix37_En19
  SIGNAL add_temp                         : signed(37 DOWNTO 0); -- sfix38_En19
  SIGNAL sum2                             : signed(36 DOWNTO 0); -- sfix37_En19
  SIGNAL add_temp_1                       : signed(37 DOWNTO 0); -- sfix38_En19
  SIGNAL sum3                             : signed(36 DOWNTO 0); -- sfix37_En19
  SIGNAL add_temp_2                       : signed(37 DOWNTO 0); -- sfix38_En19
  SIGNAL sum4                             : signed(36 DOWNTO 0); -- sfix37_En19
  SIGNAL add_temp_3                       : signed(37 DOWNTO 0); -- sfix38_En19
  SIGNAL sum5                             : signed(36 DOWNTO 0); -- sfix37_En19
  SIGNAL add_temp_4                       : signed(37 DOWNTO 0); -- sfix38_En19
  SIGNAL sum6                             : signed(36 DOWNTO 0); -- sfix37_En19
  SIGNAL add_temp_5                       : signed(37 DOWNTO 0); -- sfix38_En19
  SIGNAL sum7                             : signed(36 DOWNTO 0); -- sfix37_En19
  SIGNAL add_temp_6                       : signed(37 DOWNTO 0); -- sfix38_En19
  SIGNAL sum8                             : signed(36 DOWNTO 0); -- sfix37_En19
  SIGNAL add_temp_7                       : signed(37 DOWNTO 0); -- sfix38_En19
  SIGNAL sum9                             : signed(36 DOWNTO 0); -- sfix37_En19
  SIGNAL add_temp_8                       : signed(37 DOWNTO 0); -- sfix38_En19
  SIGNAL sum10                            : signed(36 DOWNTO 0); -- sfix37_En19
  SIGNAL add_temp_9                       : signed(37 DOWNTO 0); -- sfix38_En19
  SIGNAL sum11                            : signed(36 DOWNTO 0); -- sfix37_En19
  SIGNAL add_temp_10                      : signed(37 DOWNTO 0); -- sfix38_En19
  SIGNAL sum12                            : signed(36 DOWNTO 0); -- sfix37_En19
  SIGNAL add_temp_11                      : signed(37 DOWNTO 0); -- sfix38_En19
  SIGNAL output_typeconvert               : signed(36 DOWNTO 0); -- sfix37_En19
  SIGNAL output_register                  : signed(36 DOWNTO 0); -- sfix37_En19


BEGIN

  -- Block Statements
  ce_output : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      ring_count <= to_unsigned(1, 10);
    ELSIF clk'event AND clk = '1' THEN
      IF clk_enable = '1' THEN
        ring_count <= ring_count(0) & ring_count(9 DOWNTO 1);
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

  --   ------------------ CE Output Register ------------------

  ce_output_register : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      ce_out_reg <= '0';
    ELSIF clk'event AND clk = '1' THEN
      ce_out_reg <= phase_9;
      
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
      IF phase_9 = '1' THEN
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
      input_pipeline_phase3 <= (OTHERS => '0');
    ELSIF clk'event AND clk = '1' THEN
      IF phase_2 = '1' THEN
        input_pipeline_phase3 <= input_register;
      END IF;
    END IF; 
  END PROCESS Delay_Pipeline_Phase3_process;

  Delay_Pipeline_Phase4_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      input_pipeline_phase4 <= (OTHERS => '0');
    ELSIF clk'event AND clk = '1' THEN
      IF phase_3 = '1' THEN
        input_pipeline_phase4 <= input_register;
      END IF;
    END IF; 
  END PROCESS Delay_Pipeline_Phase4_process;

  Delay_Pipeline_Phase5_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      input_pipeline_phase5 <= (OTHERS => '0');
    ELSIF clk'event AND clk = '1' THEN
      IF phase_4 = '1' THEN
        input_pipeline_phase5 <= input_register;
      END IF;
    END IF; 
  END PROCESS Delay_Pipeline_Phase5_process;

  Delay_Pipeline_Phase6_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      input_pipeline_phase6 <= (OTHERS => '0');
    ELSIF clk'event AND clk = '1' THEN
      IF phase_5 = '1' THEN
        input_pipeline_phase6 <= input_register;
      END IF;
    END IF; 
  END PROCESS Delay_Pipeline_Phase6_process;

  Delay_Pipeline_Phase7_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      input_pipeline_phase7 <= (OTHERS => '0');
    ELSIF clk'event AND clk = '1' THEN
      IF phase_6 = '1' THEN
        input_pipeline_phase7 <= input_register;
      END IF;
    END IF; 
  END PROCESS Delay_Pipeline_Phase7_process;

  Delay_Pipeline_Phase8_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      input_pipeline_phase8 <= (OTHERS => '0');
    ELSIF clk'event AND clk = '1' THEN
      IF phase_7 = '1' THEN
        input_pipeline_phase8 <= input_register;
      END IF;
    END IF; 
  END PROCESS Delay_Pipeline_Phase8_process;

  Delay_Pipeline_Phase9_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      input_pipeline_phase9 <= (OTHERS => '0');
    ELSIF clk'event AND clk = '1' THEN
      IF phase_8 = '1' THEN
        input_pipeline_phase9 <= input_register;
      END IF;
    END IF; 
  END PROCESS Delay_Pipeline_Phase9_process;

  product_phase0_1 <= input_register * coeffphase1_1;

  product_phase0_2 <= input_pipeline_phase0 * coeffphase1_2;

  product_phase1_1 <= input_pipeline_phase1(0) * coeffphase2_1;

  product_phase1_2 <= input_pipeline_phase1(1) * coeffphase2_2;

  product_phase2_1 <= input_pipeline_phase2(0) * coeffphase3_1;

  product_phase2_2 <= input_pipeline_phase2(1) * coeffphase3_2;

  product_phase3_1 <= input_pipeline_phase3 * coeffphase4_1;

  product_phase4_1 <= input_pipeline_phase4 * coeffphase5_1;

  product_phase5_1 <= input_pipeline_phase5 * coeffphase6_1;

  product_phase6_1 <= input_pipeline_phase6 * coeffphase7_1;

  product_phase7_1 <= input_pipeline_phase7 * coeffphase8_1;

  product_phase8_1 <= input_pipeline_phase8 * coeffphase9_1;

  product_phase9_1 <= input_pipeline_phase9 * coeffphase10_1;

  quantized_sum <= resize(product_phase9_1, 37);

  add_temp <= resize(quantized_sum, 38) + resize(product_phase8_1, 38);
  sum1 <= add_temp(36 DOWNTO 0);

  add_temp_1 <= resize(sum1, 38) + resize(product_phase7_1, 38);
  sum2 <= add_temp_1(36 DOWNTO 0);

  add_temp_2 <= resize(sum2, 38) + resize(product_phase6_1, 38);
  sum3 <= add_temp_2(36 DOWNTO 0);

  add_temp_3 <= resize(sum3, 38) + resize(product_phase5_1, 38);
  sum4 <= add_temp_3(36 DOWNTO 0);

  add_temp_4 <= resize(sum4, 38) + resize(product_phase4_1, 38);
  sum5 <= add_temp_4(36 DOWNTO 0);

  add_temp_5 <= resize(sum5, 38) + resize(product_phase3_1, 38);
  sum6 <= add_temp_5(36 DOWNTO 0);

  add_temp_6 <= resize(sum6, 38) + resize(product_phase2_1, 38);
  sum7 <= add_temp_6(36 DOWNTO 0);

  add_temp_7 <= resize(sum7, 38) + resize(product_phase2_2, 38);
  sum8 <= add_temp_7(36 DOWNTO 0);

  add_temp_8 <= resize(sum8, 38) + resize(product_phase1_1, 38);
  sum9 <= add_temp_8(36 DOWNTO 0);

  add_temp_9 <= resize(sum9, 38) + resize(product_phase1_2, 38);
  sum10 <= add_temp_9(36 DOWNTO 0);

  add_temp_10 <= resize(sum10, 38) + resize(product_phase0_1, 38);
  sum11 <= add_temp_10(36 DOWNTO 0);

  add_temp_11 <= resize(sum11, 38) + resize(product_phase0_2, 38);
  sum12 <= add_temp_11(36 DOWNTO 0);

  output_typeconvert <= sum12;

  output_register_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      output_register <= (OTHERS => '0');
    ELSIF clk'event AND clk = '1' THEN
      IF phase_9 = '1' THEN
        output_register <= output_typeconvert;
      END IF;
    END IF; 
  END PROCESS output_register_process;

  -- Assignment Statements
  ce_out <= ce_out_reg;
  filter_out <= std_logic_vector(output_register);
END rtl;
