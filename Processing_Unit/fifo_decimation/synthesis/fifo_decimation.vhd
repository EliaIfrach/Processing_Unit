-- fifo_decimation.vhd

-- Generated using ACDS version 17.0 595

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity fifo_decimation is
	port (
		clk_clk                           : in  std_logic                     := '0';             --                       clk.clk
		fifo_0_clk_out_clk                : in  std_logic                     := '0';             --            fifo_0_clk_out.clk
		fifo_0_in_writedata               : in  std_logic_vector(31 downto 0) := (others => '0'); --                 fifo_0_in.writedata
		fifo_0_in_write                   : in  std_logic                     := '0';             --                          .write
		fifo_0_in_waitrequest             : out std_logic;                                        --                          .waitrequest
		fifo_0_out_readdata               : out std_logic_vector(31 downto 0);                    --                fifo_0_out.readdata
		fifo_0_out_read                   : in  std_logic                     := '0';             --                          .read
		fifo_0_out_waitrequest            : out std_logic;                                        --                          .waitrequest
		fifo_decimation_reset_out_reset_n : in  std_logic                     := '0';             -- fifo_decimation_reset_out.reset_n
		reset_reset_n                     : in  std_logic                     := '0'              --                     reset.reset_n
	);
end entity fifo_decimation;

architecture rtl of fifo_decimation is
	component fifo_decimation_fifo_decimation is
		port (
			wrclock                          : in  std_logic                     := 'X';             -- clk
			wrreset_n                        : in  std_logic                     := 'X';             -- reset_n
			rdclock                          : in  std_logic                     := 'X';             -- clk
			rdreset_n                        : in  std_logic                     := 'X';             -- reset_n
			avalonmm_write_slave_writedata   : in  std_logic_vector(31 downto 0) := (others => 'X'); -- writedata
			avalonmm_write_slave_write       : in  std_logic                     := 'X';             -- write
			avalonmm_write_slave_waitrequest : out std_logic;                                        -- waitrequest
			avalonmm_read_slave_readdata     : out std_logic_vector(31 downto 0);                    -- readdata
			avalonmm_read_slave_read         : in  std_logic                     := 'X';             -- read
			avalonmm_read_slave_waitrequest  : out std_logic                                         -- waitrequest
		);
	end component fifo_decimation_fifo_decimation;

	component altera_reset_controller is
		generic (
			NUM_RESET_INPUTS          : integer := 6;
			OUTPUT_RESET_SYNC_EDGES   : string  := "deassert";
			SYNC_DEPTH                : integer := 2;
			RESET_REQUEST_PRESENT     : integer := 0;
			RESET_REQ_WAIT_TIME       : integer := 1;
			MIN_RST_ASSERTION_TIME    : integer := 3;
			RESET_REQ_EARLY_DSRT_TIME : integer := 1;
			USE_RESET_REQUEST_IN0     : integer := 0;
			USE_RESET_REQUEST_IN1     : integer := 0;
			USE_RESET_REQUEST_IN2     : integer := 0;
			USE_RESET_REQUEST_IN3     : integer := 0;
			USE_RESET_REQUEST_IN4     : integer := 0;
			USE_RESET_REQUEST_IN5     : integer := 0;
			USE_RESET_REQUEST_IN6     : integer := 0;
			USE_RESET_REQUEST_IN7     : integer := 0;
			USE_RESET_REQUEST_IN8     : integer := 0;
			USE_RESET_REQUEST_IN9     : integer := 0;
			USE_RESET_REQUEST_IN10    : integer := 0;
			USE_RESET_REQUEST_IN11    : integer := 0;
			USE_RESET_REQUEST_IN12    : integer := 0;
			USE_RESET_REQUEST_IN13    : integer := 0;
			USE_RESET_REQUEST_IN14    : integer := 0;
			USE_RESET_REQUEST_IN15    : integer := 0;
			ADAPT_RESET_REQUEST       : integer := 0
		);
		port (
			reset_in0      : in  std_logic := 'X'; -- reset
			clk            : in  std_logic := 'X'; -- clk
			reset_out      : out std_logic;        -- reset
			reset_req      : out std_logic;        -- reset_req
			reset_req_in0  : in  std_logic := 'X'; -- reset_req
			reset_in1      : in  std_logic := 'X'; -- reset
			reset_req_in1  : in  std_logic := 'X'; -- reset_req
			reset_in2      : in  std_logic := 'X'; -- reset
			reset_req_in2  : in  std_logic := 'X'; -- reset_req
			reset_in3      : in  std_logic := 'X'; -- reset
			reset_req_in3  : in  std_logic := 'X'; -- reset_req
			reset_in4      : in  std_logic := 'X'; -- reset
			reset_req_in4  : in  std_logic := 'X'; -- reset_req
			reset_in5      : in  std_logic := 'X'; -- reset
			reset_req_in5  : in  std_logic := 'X'; -- reset_req
			reset_in6      : in  std_logic := 'X'; -- reset
			reset_req_in6  : in  std_logic := 'X'; -- reset_req
			reset_in7      : in  std_logic := 'X'; -- reset
			reset_req_in7  : in  std_logic := 'X'; -- reset_req
			reset_in8      : in  std_logic := 'X'; -- reset
			reset_req_in8  : in  std_logic := 'X'; -- reset_req
			reset_in9      : in  std_logic := 'X'; -- reset
			reset_req_in9  : in  std_logic := 'X'; -- reset_req
			reset_in10     : in  std_logic := 'X'; -- reset
			reset_req_in10 : in  std_logic := 'X'; -- reset_req
			reset_in11     : in  std_logic := 'X'; -- reset
			reset_req_in11 : in  std_logic := 'X'; -- reset_req
			reset_in12     : in  std_logic := 'X'; -- reset
			reset_req_in12 : in  std_logic := 'X'; -- reset_req
			reset_in13     : in  std_logic := 'X'; -- reset
			reset_req_in13 : in  std_logic := 'X'; -- reset_req
			reset_in14     : in  std_logic := 'X'; -- reset
			reset_req_in14 : in  std_logic := 'X'; -- reset_req
			reset_in15     : in  std_logic := 'X'; -- reset
			reset_req_in15 : in  std_logic := 'X'  -- reset_req
		);
	end component altera_reset_controller;

	signal rst_controller_reset_out_reset           : std_logic; -- rst_controller:reset_out -> rst_controller_reset_out_reset:in
	signal reset_reset_n_ports_inv                  : std_logic; -- reset_reset_n:inv -> rst_controller:reset_in0
	signal rst_controller_reset_out_reset_ports_inv : std_logic; -- rst_controller_reset_out_reset:inv -> fifo_decimation:wrreset_n

begin

	fifo_decimation : component fifo_decimation_fifo_decimation
		port map (
			wrclock                          => clk_clk,                                  --    clk_in.clk
			wrreset_n                        => rst_controller_reset_out_reset_ports_inv, --  reset_in.reset_n
			rdclock                          => fifo_0_clk_out_clk,                       --   clk_out.clk
			rdreset_n                        => fifo_decimation_reset_out_reset_n,        -- reset_out.reset_n
			avalonmm_write_slave_writedata   => fifo_0_in_writedata,                      --        in.writedata
			avalonmm_write_slave_write       => fifo_0_in_write,                          --          .write
			avalonmm_write_slave_waitrequest => fifo_0_in_waitrequest,                    --          .waitrequest
			avalonmm_read_slave_readdata     => fifo_0_out_readdata,                      --       out.readdata
			avalonmm_read_slave_read         => fifo_0_out_read,                          --          .read
			avalonmm_read_slave_waitrequest  => fifo_0_out_waitrequest                    --          .waitrequest
		);

	rst_controller : component altera_reset_controller
		generic map (
			NUM_RESET_INPUTS          => 1,
			OUTPUT_RESET_SYNC_EDGES   => "deassert",
			SYNC_DEPTH                => 2,
			RESET_REQUEST_PRESENT     => 0,
			RESET_REQ_WAIT_TIME       => 1,
			MIN_RST_ASSERTION_TIME    => 3,
			RESET_REQ_EARLY_DSRT_TIME => 1,
			USE_RESET_REQUEST_IN0     => 0,
			USE_RESET_REQUEST_IN1     => 0,
			USE_RESET_REQUEST_IN2     => 0,
			USE_RESET_REQUEST_IN3     => 0,
			USE_RESET_REQUEST_IN4     => 0,
			USE_RESET_REQUEST_IN5     => 0,
			USE_RESET_REQUEST_IN6     => 0,
			USE_RESET_REQUEST_IN7     => 0,
			USE_RESET_REQUEST_IN8     => 0,
			USE_RESET_REQUEST_IN9     => 0,
			USE_RESET_REQUEST_IN10    => 0,
			USE_RESET_REQUEST_IN11    => 0,
			USE_RESET_REQUEST_IN12    => 0,
			USE_RESET_REQUEST_IN13    => 0,
			USE_RESET_REQUEST_IN14    => 0,
			USE_RESET_REQUEST_IN15    => 0,
			ADAPT_RESET_REQUEST       => 0
		)
		port map (
			reset_in0      => reset_reset_n_ports_inv,        -- reset_in0.reset
			clk            => clk_clk,                        --       clk.clk
			reset_out      => rst_controller_reset_out_reset, -- reset_out.reset
			reset_req      => open,                           -- (terminated)
			reset_req_in0  => '0',                            -- (terminated)
			reset_in1      => '0',                            -- (terminated)
			reset_req_in1  => '0',                            -- (terminated)
			reset_in2      => '0',                            -- (terminated)
			reset_req_in2  => '0',                            -- (terminated)
			reset_in3      => '0',                            -- (terminated)
			reset_req_in3  => '0',                            -- (terminated)
			reset_in4      => '0',                            -- (terminated)
			reset_req_in4  => '0',                            -- (terminated)
			reset_in5      => '0',                            -- (terminated)
			reset_req_in5  => '0',                            -- (terminated)
			reset_in6      => '0',                            -- (terminated)
			reset_req_in6  => '0',                            -- (terminated)
			reset_in7      => '0',                            -- (terminated)
			reset_req_in7  => '0',                            -- (terminated)
			reset_in8      => '0',                            -- (terminated)
			reset_req_in8  => '0',                            -- (terminated)
			reset_in9      => '0',                            -- (terminated)
			reset_req_in9  => '0',                            -- (terminated)
			reset_in10     => '0',                            -- (terminated)
			reset_req_in10 => '0',                            -- (terminated)
			reset_in11     => '0',                            -- (terminated)
			reset_req_in11 => '0',                            -- (terminated)
			reset_in12     => '0',                            -- (terminated)
			reset_req_in12 => '0',                            -- (terminated)
			reset_in13     => '0',                            -- (terminated)
			reset_req_in13 => '0',                            -- (terminated)
			reset_in14     => '0',                            -- (terminated)
			reset_req_in14 => '0',                            -- (terminated)
			reset_in15     => '0',                            -- (terminated)
			reset_req_in15 => '0'                             -- (terminated)
		);

	reset_reset_n_ports_inv <= not reset_reset_n;

	rst_controller_reset_out_reset_ports_inv <= not rst_controller_reset_out_reset;

end architecture rtl; -- of fifo_decimation
