vsim -gui work.tb_top \
  +UVM_TESTNAME=axi4_lite_test \
  -voptargs="+acc"

add wave -position insertpoint sim:/tb_top/*
add wave -position insertpoint sim:/tb_top/dut/*
run -all