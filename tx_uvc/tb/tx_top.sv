module tx_top;

    import uvm_pkg::*;
    `include "uvm_macros.svh"
    import tx_pkg::*;
    `include "tx_top_env.sv"
    `include "tx_test.sv"

    bit atclk, atresetn;

    tx_if t_if (.atclk, .atresetn);

    initial begin
        tx_vif_config::set(null, "*.top_env.tx_uvc.agent.*", "vif", t_if);
        run_test("tx_test");
    end

    initial begin 
        atclk = 0;
        atresetn = 0;
        #10 atresetn = 1;

    end

    always
        #5 atclk = ~atclk;

endmodule: tx_top 