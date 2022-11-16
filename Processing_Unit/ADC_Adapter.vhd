library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity ADC_Adapter is
    port (
        clk               : in std_logic;
        rst             : in std_logic;
        SW              : in std_logic_vector (1 downto 0);
        AD_SCLK            : out std_logic;
        AD_SDIO          : out std_logic;
        ADA_D            : in std_logic_vector(13 downto 0);
        ADA_DCO          : in std_logic;
        ADA_OE           : out std_logic;
        ADA_OR           : out std_logic;
        ADA_SPI_CS       : out std_logic;

        DA              :out std_logic_vector(13 downto 0);
        FPGA_CLK_A_N :out std_logic;
        FPGA_CLK_A_P : out std_logic

    );
end entity ADC_Adapter;
architecture rtl of ADC_Adapter is
    signal per_a2da_d : std_logic_vector(13 downto 0);
    signal a2da_data : std_logic_vector(13 downto 0);
begin

    process(clk,rst)
    begin
        FPGA_CLK_A_P <= clk;
        FPGA_CLK_A_N <= not(clk);
        AD_SCLK <= SW(0);
        AD_SDIO <= SW(1);
        ADA_OE <= '0';
        ADA_SPI_CS <= '1';

        if(rst = '0') then
            per_a2da_d	<= (others => '0');
            a2da_data	<= (others => '0');
        end if;
        if(rising_edge(ADA_DCO)) then
                per_a2da_d	<= ADA_D;
        end if;
        if(rising_edge(clk)) then
               a2da_data	<= per_a2da_d;
            end if;

    end process;
end architecture rtl;

