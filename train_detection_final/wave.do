quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_top/*
add wave -noupdate /tb_top/dut/*
add wave -noupdate /tb_top/dut/u_clk_div/*
add dataflow -noupdate /tb_top/dut/*
add list /tb_top/dut/*
add memory /tb_top/dut/*
add watch /tb_top/dut/*
update
WaveRestoreZoom {0 ps} {1549120 ps}
