class tx_sequencer extends uvm_sequencer #(tx_packet);
    `uvm_component_utils(tx_sequencer)

    function new(string name = "tx_sequencer", uvm_component parent);
        super.new(name,parent);
        `uvm_info(get_type_name(), "BUILD PHASE RUNNING...", UVM_LOW);
    endfunction: new

    
endclass