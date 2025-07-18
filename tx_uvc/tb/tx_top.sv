module tx_top;

    import uvm_pkg::*;
    `include "uvm_macros.svh"
    import tx_pkg::*;

    initial begin
        run_test("tx_test");
    end

endmodule: tx_top 