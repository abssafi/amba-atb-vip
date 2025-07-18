module rx_top;

    import uvm_pkg::*;
    `include "uvm_macros.svh"
    import rx_pkg::*;
    `include "rx_top_env.sv"
    `include "rx_test.sv"

    bit atclk, atresetn;

    rx_if t_if (.atclk, .atresetn);

    initial begin
        rx_vif_config::set(null, "*.top_env.rx_uvc.agent.*", "vif", t_if);
        run_test("rx_test");
    end

    initial begin 
        atclk = 0;
        atresetn = 0;
        #10 atresetn = 1;

    end

    always
        #5 atclk = ~atclk;

endmodule: rx_top 