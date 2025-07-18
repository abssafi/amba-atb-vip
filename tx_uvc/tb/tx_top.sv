module tx_top;

    import uvm_pkg::*;
    `include "uvm_macros.svh"
    import tx_pkg::*;
    `include "tx_top_env.sv"
    `include "tx_test.sv"

    initial begin
        tx_vif_config::set(null, "*.top_env.tx_uvc.agent.*", "vif", vif);
        run_test("tx_test");
    end

endmodule: tx_top 