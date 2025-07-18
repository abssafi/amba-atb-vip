class tx_driver extends uvm_driver #(tx_packet);
    `uvm_component_utils(tx_driver)

    function new (string name = "tx_driver", uvm_component parent);
        super.new(name, parent);
    endfunction:new 

    function void build_phase(uvm_phase phase);
        super.build_phase (phase);
        `uvm_info(get_type_name(), "BUILD PHASE RUNNING...", UVM_LOW);
    endfunction: build_phase

    // task run_phase (uvm_phase);

    // endtask: run_phase

endclass: tx_driver