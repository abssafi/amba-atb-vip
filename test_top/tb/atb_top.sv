module atb_top;

    import uvm_pkg::*;
    `include "uvm_macros.svh"
    import tx_pkg::*;
    import rx_pkg::*;
    `include "../sv/mcsequencer.sv"
    `include "../sv/mcsequence.sv"
    `include "atb_scoreboard.sv"
    `include "total_coverage.sv"
    `include "atb_top_env.sv"
    `include "atb_test.sv"

    bit atclk, atresetn;

    atb_if t_if (.atclk, .atresetn);

    initial begin
        uvm_config_db#(virtual atb_if)::set(null, "*.top_env.tx_uvc.agent.*", "vif", t_if);
        uvm_config_db#(virtual atb_if)::set(null, "*.top_env.rx_uvc.agent.*", "vif", t_if);
        run_test("running_mcseq");
    end

    initial begin 
        atclk = 0;
        atresetn = 0;
        #10 atresetn = 1;
    end

    always #5 atclk = ~atclk;

endmodule: atb_top 