	component NCO_150 is
		port (
			clk_clk           : in  std_logic                     := 'X';             -- clk
			nco_150_in_valid  : in  std_logic                     := 'X';             -- valid
			nco_150_in_data   : in  std_logic_vector(12 downto 0) := (others => 'X'); -- data
			nco_150_out_data  : out std_logic_vector(9 downto 0);                     -- data
			nco_150_out_valid : out std_logic;                                        -- valid
			reset_reset_n     : in  std_logic                     := 'X'              -- reset_n
		);
	end component NCO_150;

	u0 : component NCO_150
		port map (
			clk_clk           => CONNECTED_TO_clk_clk,           --         clk.clk
			nco_150_in_valid  => CONNECTED_TO_nco_150_in_valid,  --  nco_150_in.valid
			nco_150_in_data   => CONNECTED_TO_nco_150_in_data,   --            .data
			nco_150_out_data  => CONNECTED_TO_nco_150_out_data,  -- nco_150_out.data
			nco_150_out_valid => CONNECTED_TO_nco_150_out_valid, --            .valid
			reset_reset_n     => CONNECTED_TO_reset_reset_n      --       reset.reset_n
		);

