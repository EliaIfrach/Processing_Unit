	component NCO_TEST is
		port (
			clk_clk          : in  std_logic                     := 'X';             -- clk
			nco_iq_in_valid  : in  std_logic                     := 'X';             -- valid
			nco_iq_in_data   : in  std_logic_vector(12 downto 0) := (others => 'X'); -- data
			nco_iq_out_data  : out std_logic_vector(9 downto 0);                     -- data
			nco_iq_out_valid : out std_logic;                                        -- valid
			reset_reset_n    : in  std_logic                     := 'X'              -- reset_n
		);
	end component NCO_TEST;

	u0 : component NCO_TEST
		port map (
			clk_clk          => CONNECTED_TO_clk_clk,          --        clk.clk
			nco_iq_in_valid  => CONNECTED_TO_nco_iq_in_valid,  --  nco_iq_in.valid
			nco_iq_in_data   => CONNECTED_TO_nco_iq_in_data,   --           .data
			nco_iq_out_data  => CONNECTED_TO_nco_iq_out_data,  -- nco_iq_out.data
			nco_iq_out_valid => CONNECTED_TO_nco_iq_out_valid, --           .valid
			reset_reset_n    => CONNECTED_TO_reset_reset_n     --      reset.reset_n
		);

