	component PLL is
		port (
			clk_clk                      : in  std_logic := 'X'; -- clk
			fifo_clk_pll_0_outclk1_clk   : out std_logic;        -- clk
			reset_reset_n                : in  std_logic := 'X'; -- reset_n
			system_clk_pll_0_outclk0_clk : out std_logic         -- clk
		);
	end component PLL;

	u0 : component PLL
		port map (
			clk_clk                      => CONNECTED_TO_clk_clk,                      --                      clk.clk
			fifo_clk_pll_0_outclk1_clk   => CONNECTED_TO_fifo_clk_pll_0_outclk1_clk,   --   fifo_clk_pll_0_outclk1.clk
			reset_reset_n                => CONNECTED_TO_reset_reset_n,                --                    reset.reset_n
			system_clk_pll_0_outclk0_clk => CONNECTED_TO_system_clk_pll_0_outclk0_clk  -- system_clk_pll_0_outclk0.clk
		);

