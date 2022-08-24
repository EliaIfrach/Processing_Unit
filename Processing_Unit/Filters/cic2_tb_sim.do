onbreak resume
onerror resume
vsim -voptargs=+acc work.cic2_tb
add wave sim:/cic2_tb/u_cic2/clk
add wave sim:/cic2_tb/u_cic2/clk_enable
add wave sim:/cic2_tb/u_cic2/reset
add wave sim:/cic2_tb/u_cic2/filter_in
add wave sim:/cic2_tb/u_cic2/filter_out
add wave sim:/cic2_tb/filter_out_ref
add wave sim:/cic2_tb/u_cic2/ce_out
run -all
