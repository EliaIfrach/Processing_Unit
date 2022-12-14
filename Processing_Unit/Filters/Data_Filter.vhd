-- -------------------------------------------------------------
--
-- Module: Data_Filter
-- Generated by MATLAB(R) 9.10 and Filter Design HDL Coder 3.1.9.
-- Generated on: 2022-08-06 17:52:30
-- -------------------------------------------------------------

-- -------------------------------------------------------------
-- HDL Code Generation Options:
--
-- TargetLanguage: VHDL
-- TargetDirectory: C:\Users\Elia Yfrach\Desktop\Project\FM\Filters
-- Name: Data_Filter
-- TestBenchName: Data_Filter_tb
-- TestBenchStimulus: impulse step ramp chirp noise 
-- GenerateHDLTestBench: off

-- Filter Specifications:
--
-- Sample Rate     : 367.6471 kHz
-- Response        : Lowpass
-- Specification   : Fp,Fst,Ap,Ast
-- Passband Edge   : 10 kHz
-- Stopband Atten. : 40 dB
-- Stopband Edge   : 100 kHz
-- Passband Ripple : 1 dB
-- -------------------------------------------------------------

-- -------------------------------------------------------------
-- HDL Implementation    : Fully parallel
-- Folding Factor        : 1
-- -------------------------------------------------------------
-- Filter Settings:
--
-- Discrete-Time FIR Filter (real)
-- -------------------------------
-- Filter Structure  : Direct-Form FIR
-- Filter Length     : 7
-- Stable            : Yes
-- Linear Phase      : Yes (Type 1)
-- Arithmetic        : fixed
-- Numerator         : s16,16 -> [-5.000000e-01 5.000000e-01)
-- Input             : s17,0 -> [-65536 65536)
-- Filter Internals  : Full Precision
--   Output          : s33,16 -> [-65536 65536)  (auto determined)
--   Product         : s32,16 -> [-32768 32768)  (auto determined)
--   Accumulator     : s33,16 -> [-65536 65536)  (auto determined)
--   Round Mode      : No rounding
--   Overflow Mode   : No overflow
-- -------------------------------------------------------------



LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.numeric_std.ALL;

ENTITY Data_Filter IS
   PORT( clk                             :   IN    std_logic; 
         clk_enable                      :   IN    std_logic; 
         reset                           :   IN    std_logic; 
         filter_in                       :   IN    std_logic_vector(16 DOWNTO 0); -- sfix17
         filter_out                      :   OUT   std_logic_vector(32 DOWNTO 0)  -- sfix33_En16
         );

END Data_Filter;


----------------------------------------------------------------
--Module Architecture: Data_Filter
----------------------------------------------------------------
ARCHITECTURE rtl OF Data_Filter IS
  -- Local Functions
  -- Type Definitions
  TYPE delay_pipeline_type IS ARRAY (NATURAL range <>) OF signed(16 DOWNTO 0); -- sfix17
  -- Constants
  CONSTANT coeff1                         : signed(15 DOWNTO 0) := to_signed(2242, 16); -- sfix16_En16
  CONSTANT coeff2                         : signed(15 DOWNTO 0) := to_signed(7656, 16); -- sfix16_En16
  CONSTANT coeff3                         : signed(15 DOWNTO 0) := to_signed(14187, 16); -- sfix16_En16
  CONSTANT coeff4                         : signed(15 DOWNTO 0) := to_signed(17190, 16); -- sfix16_En16
  CONSTANT coeff5                         : signed(15 DOWNTO 0) := to_signed(14187, 16); -- sfix16_En16
  CONSTANT coeff6                         : signed(15 DOWNTO 0) := to_signed(7656, 16); -- sfix16_En16
  CONSTANT coeff7                         : signed(15 DOWNTO 0) := to_signed(2242, 16); -- sfix16_En16

  -- Signals
  SIGNAL delay_pipeline                   : delay_pipeline_type(0 TO 6); -- sfix17
  SIGNAL product7                         : signed(31 DOWNTO 0); -- sfix32_En16
  SIGNAL mul_temp                         : signed(32 DOWNTO 0); -- sfix33_En16
  SIGNAL product6                         : signed(31 DOWNTO 0); -- sfix32_En16
  SIGNAL mul_temp_1                       : signed(32 DOWNTO 0); -- sfix33_En16
  SIGNAL product5                         : signed(31 DOWNTO 0); -- sfix32_En16
  SIGNAL mul_temp_2                       : signed(32 DOWNTO 0); -- sfix33_En16
  SIGNAL product4                         : signed(31 DOWNTO 0); -- sfix32_En16
  SIGNAL mul_temp_3                       : signed(32 DOWNTO 0); -- sfix33_En16
  SIGNAL product3                         : signed(31 DOWNTO 0); -- sfix32_En16
  SIGNAL mul_temp_4                       : signed(32 DOWNTO 0); -- sfix33_En16
  SIGNAL product2                         : signed(31 DOWNTO 0); -- sfix32_En16
  SIGNAL mul_temp_5                       : signed(32 DOWNTO 0); -- sfix33_En16
  SIGNAL product1_cast                    : signed(32 DOWNTO 0); -- sfix33_En16
  SIGNAL product1                         : signed(31 DOWNTO 0); -- sfix32_En16
  SIGNAL mul_temp_6                       : signed(32 DOWNTO 0); -- sfix33_En16
  SIGNAL sum1                             : signed(32 DOWNTO 0); -- sfix33_En16
  SIGNAL add_temp                         : signed(33 DOWNTO 0); -- sfix34_En16
  SIGNAL sum2                             : signed(32 DOWNTO 0); -- sfix33_En16
  SIGNAL add_temp_1                       : signed(33 DOWNTO 0); -- sfix34_En16
  SIGNAL sum3                             : signed(32 DOWNTO 0); -- sfix33_En16
  SIGNAL add_temp_2                       : signed(33 DOWNTO 0); -- sfix34_En16
  SIGNAL sum4                             : signed(32 DOWNTO 0); -- sfix33_En16
  SIGNAL add_temp_3                       : signed(33 DOWNTO 0); -- sfix34_En16
  SIGNAL sum5                             : signed(32 DOWNTO 0); -- sfix33_En16
  SIGNAL add_temp_4                       : signed(33 DOWNTO 0); -- sfix34_En16
  SIGNAL sum6                             : signed(32 DOWNTO 0); -- sfix33_En16
  SIGNAL add_temp_5                       : signed(33 DOWNTO 0); -- sfix34_En16
  SIGNAL output_typeconvert               : signed(32 DOWNTO 0); -- sfix33_En16
  SIGNAL output_register                  : signed(32 DOWNTO 0); -- sfix33_En16


BEGIN

  -- Block Statements
  Delay_Pipeline_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      delay_pipeline(0 TO 6) <= (OTHERS => (OTHERS => '0'));
    ELSIF clk'event AND clk = '1' THEN
      IF clk_enable = '1' THEN
        delay_pipeline(0) <= signed(filter_in);
        delay_pipeline(1 TO 6) <= delay_pipeline(0 TO 5);
      END IF;
    END IF; 
  END PROCESS Delay_Pipeline_process;

  mul_temp <= delay_pipeline(6) * coeff7;
  product7 <= mul_temp(31 DOWNTO 0);

  mul_temp_1 <= delay_pipeline(5) * coeff6;
  product6 <= mul_temp_1(31 DOWNTO 0);

  mul_temp_2 <= delay_pipeline(4) * coeff5;
  product5 <= mul_temp_2(31 DOWNTO 0);

  mul_temp_3 <= delay_pipeline(3) * coeff4;
  product4 <= mul_temp_3(31 DOWNTO 0);

  mul_temp_4 <= delay_pipeline(2) * coeff3;
  product3 <= mul_temp_4(31 DOWNTO 0);

  mul_temp_5 <= delay_pipeline(1) * coeff2;
  product2 <= mul_temp_5(31 DOWNTO 0);

  product1_cast <= resize(product1, 33);

  mul_temp_6 <= delay_pipeline(0) * coeff1;
  product1 <= mul_temp_6(31 DOWNTO 0);

  add_temp <= resize(product1_cast, 34) + resize(product2, 34);
  sum1 <= add_temp(32 DOWNTO 0);

  add_temp_1 <= resize(sum1, 34) + resize(product3, 34);
  sum2 <= add_temp_1(32 DOWNTO 0);

  add_temp_2 <= resize(sum2, 34) + resize(product4, 34);
  sum3 <= add_temp_2(32 DOWNTO 0);

  add_temp_3 <= resize(sum3, 34) + resize(product5, 34);
  sum4 <= add_temp_3(32 DOWNTO 0);

  add_temp_4 <= resize(sum4, 34) + resize(product6, 34);
  sum5 <= add_temp_4(32 DOWNTO 0);

  add_temp_5 <= resize(sum5, 34) + resize(product7, 34);
  sum6 <= add_temp_5(32 DOWNTO 0);

  output_typeconvert <= sum6;

  Output_Register_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      output_register <= (OTHERS => '0');
    ELSIF clk'event AND clk = '1' THEN
      IF clk_enable = '1' THEN
        output_register <= output_typeconvert;
      END IF;
    END IF; 
  END PROCESS Output_Register_process;

  -- Assignment Statements
  filter_out <= std_logic_vector(output_register);
END rtl;
