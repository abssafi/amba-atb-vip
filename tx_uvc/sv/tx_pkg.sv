package tx_pkg;
    import uvm_pkg::*;
    typedef uvm_config_db#(virtual tx_if) tx_vif_config;

    `include "uvm_macros.svh"
    
    `include "tx_packet.sv"
    `include "tx_monitor.sv"
    `include "tx_sequencer.sv"
    `include "tx_sequence.sv"
    `include "tx_driver.sv"
    `include "tx_agent.sv"
    `include "tx_env.sv"

endpackage : tx_pkg