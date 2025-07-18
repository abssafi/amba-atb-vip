class tx_monitor extends uvm_monitor;
    `uvm_component_utils(tx_monitor)

    function new (string name = "tx_monitor", uvm_component parent);
        super.new(name, parent);
    endfunction:new

    function void build_phase (uvm_phase phase);
        super.build_phase(phase);
        `uvm_info(get_type_name(), "BUILD PHASE RUNNING...", UVM_LOW);
    endfunction: build_phase

endclass: tx_monitor