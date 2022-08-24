	component fifo_decimation_3 is
		port (
			clk_clk                             : in  std_logic                     := 'X';             -- clk
			reset_reset_n                       : in  std_logic                     := 'X';             -- reset_n
			fifo_decimation_3_clk_out_clk       : in  std_logic                     := 'X';             -- clk
			fifo_decimation_3_out_readdata      : out std_logic_vector(31 downto 0);                    -- readdata
			fifo_decimation_3_out_read          : in  std_logic                     := 'X';             -- read
			fifo_decimation_3_out_waitrequest   : out std_logic;                                        -- waitrequest
			fifo_decimation_3_in_writedata      : in  std_logic_vector(31 downto 0) := (others => 'X'); -- writedata
			fifo_decimation_3_in_write          : in  std_logic                     := 'X';             -- write
			fifo_decimation_3_in_waitrequest    : out std_logic;                                        -- waitrequest
			fifo_decimation_3_reset_out_reset_n : in  std_logic                     := 'X'              -- reset_n
		);
	end component fifo_decimation_3;

	u0 : component fifo_decimation_3
		port map (
			clk_clk                             => CONNECTED_TO_clk_clk,                             --                         clk.clk
			reset_reset_n                       => CONNECTED_TO_reset_reset_n,                       --                       reset.reset_n
			fifo_decimation_3_clk_out_clk       => CONNECTED_TO_fifo_decimation_3_clk_out_clk,       --   fifo_decimation_3_clk_out.clk
			fifo_decimation_3_out_readdata      => CONNECTED_TO_fifo_decimation_3_out_readdata,      --       fifo_decimation_3_out.readdata
			fifo_decimation_3_out_read          => CONNECTED_TO_fifo_decimation_3_out_read,          --                            .read
			fifo_decimation_3_out_waitrequest   => CONNECTED_TO_fifo_decimation_3_out_waitrequest,   --                            .waitrequest
			fifo_decimation_3_in_writedata      => CONNECTED_TO_fifo_decimation_3_in_writedata,      --        fifo_decimation_3_in.writedata
			fifo_decimation_3_in_write          => CONNECTED_TO_fifo_decimation_3_in_write,          --                            .write
			fifo_decimation_3_in_waitrequest    => CONNECTED_TO_fifo_decimation_3_in_waitrequest,    --                            .waitrequest
			fifo_decimation_3_reset_out_reset_n => CONNECTED_TO_fifo_decimation_3_reset_out_reset_n  -- fifo_decimation_3_reset_out.reset_n
		);

