-timescale 1ns/100ps

-incdir ../../rx_uvc/sv
-incdir ../../tx_uvc/sv
-incdir ../../test_top

../../tx_uvc/sv/tx_pkg.sv
../../rx_uvc/sv/rx_pkg.sv

../sv/atb_if.sv

atb_top.sv

// +UVM_TESTNAME=tx_test
+UVM_VERBOSITY=UVM_HIGH