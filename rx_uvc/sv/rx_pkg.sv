package rx_pkg;
    import uvm_pkg::*;
    //typedef uvm_config_db#(virtual tx_if) rx_vif_config;

    `include "uvm_macros.svh"
    
    `include "rx_packet.sv"
    `include "rx_monitor.sv"
    `include "rx_sequencer.sv"
    `include "rx_sequence.sv"
    `include "rx_coverage.sv"
    `include "rx_driver.sv"
    `include "rx_agent.sv"
    `include "rx_env.sv"

endpackage : rx_pkg