	component FM_FFT is
		port (
			clk_clk                       : in  std_logic                     := 'X';             -- clk
			reset_reset_n                 : in  std_logic                     := 'X';             -- reset_n
			fft_ii_0_sink_valid           : in  std_logic                     := 'X';             -- valid
			fft_ii_0_sink_ready           : out std_logic;                                        -- ready
			fft_ii_0_sink_error           : in  std_logic_vector(1 downto 0)  := (others => 'X'); -- error
			fft_ii_0_sink_startofpacket   : in  std_logic                     := 'X';             -- startofpacket
			fft_ii_0_sink_endofpacket     : in  std_logic                     := 'X';             -- endofpacket
			fft_ii_0_sink_data            : in  std_logic_vector(43 downto 0) := (others => 'X'); -- data
			fft_ii_0_source_valid         : out std_logic;                                        -- valid
			fft_ii_0_source_ready         : in  std_logic                     := 'X';             -- ready
			fft_ii_0_source_error         : out std_logic_vector(1 downto 0);                     -- error
			fft_ii_0_source_startofpacket : out std_logic;                                        -- startofpacket
			fft_ii_0_source_endofpacket   : out std_logic;                                        -- endofpacket
			fft_ii_0_source_data          : out std_logic_vector(72 downto 0)                     -- data
		);
	end component FM_FFT;

	u0 : component FM_FFT
		port map (
			clk_clk                       => CONNECTED_TO_clk_clk,                       --             clk.clk
			reset_reset_n                 => CONNECTED_TO_reset_reset_n,                 --           reset.reset_n
			fft_ii_0_sink_valid           => CONNECTED_TO_fft_ii_0_sink_valid,           --   fft_ii_0_sink.valid
			fft_ii_0_sink_ready           => CONNECTED_TO_fft_ii_0_sink_ready,           --                .ready
			fft_ii_0_sink_error           => CONNECTED_TO_fft_ii_0_sink_error,           --                .error
			fft_ii_0_sink_startofpacket   => CONNECTED_TO_fft_ii_0_sink_startofpacket,   --                .startofpacket
			fft_ii_0_sink_endofpacket     => CONNECTED_TO_fft_ii_0_sink_endofpacket,     --                .endofpacket
			fft_ii_0_sink_data            => CONNECTED_TO_fft_ii_0_sink_data,            --                .data
			fft_ii_0_source_valid         => CONNECTED_TO_fft_ii_0_source_valid,         -- fft_ii_0_source.valid
			fft_ii_0_source_ready         => CONNECTED_TO_fft_ii_0_source_ready,         --                .ready
			fft_ii_0_source_error         => CONNECTED_TO_fft_ii_0_source_error,         --                .error
			fft_ii_0_source_startofpacket => CONNECTED_TO_fft_ii_0_source_startofpacket, --                .startofpacket
			fft_ii_0_source_endofpacket   => CONNECTED_TO_fft_ii_0_source_endofpacket,   --                .endofpacket
			fft_ii_0_source_data          => CONNECTED_TO_fft_ii_0_source_data           --                .data
		);

