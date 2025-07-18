-timescale 1ns/100ps

-incdir ../sv
-incdir ../tb

../sv/tx_pkg.sv
../sv/tx_if.sv

tx_top.sv

// +UVM_TESTNAME=tx_test
+UVM_VERBOSITY=UVM_HIGH