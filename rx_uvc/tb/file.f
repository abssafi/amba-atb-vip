-timescale 1ns/100ps

-incdir ../sv
-incdir ../tb

../sv/rx_pkg.sv
../sv/rx_if.sv

rx_top.sv

// +UVM_TESTNAME=rx_test
+UVM_VERBOSITY=UVM_HIGH