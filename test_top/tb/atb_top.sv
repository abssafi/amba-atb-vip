module atb_top;

    import uvm_pkg::*;
    `include "uvm_macros.svh"
    import tx_pkg::*;
    import rx_pkg::*;
    `include "atb_scoreboard.sv"
    `include "atb_top_env.sv"
    `include "atb_test.sv"


    bit atclk, atresetn;

    atb_if t_if (.atclk, .atresetn);

    initial begin
        //tx_vif_config::set(null, "*.top_env.tx_uvc.agent.*", "vif", t_if);
        uvm_config_db#(virtual atb_if)::set(null, "*.top_env.tx_uvc.agent.*", "vif", t_if);
        uvm_config_db#(virtual atb_if)::set(null, "*.top_env.rx_uvc.agent.*", "vif", t_if);
        run_test("base_test");
    end

    initial begin 
        atclk = 0;
        atresetn = 0;
        #10 atresetn = 1;
        #100 atresetn = 0;

    end

    always
        #5 atclk = ~atclk;

endmodule: atb_top 