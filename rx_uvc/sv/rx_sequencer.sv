class rx_sequencer extends uvm_sequencer #(rx_packet);
    `uvm_component_utils(rx_sequencer)

    function new(string name = "rx_sequencer", uvm_component parent);
        super.new(name,parent);
        `uvm_info(get_type_name(), "BUILD PHASE RUNNING...", UVM_LOW);
    endfunction: new

    function void build_phase (uvm_phase phase);
        `uvm_info(get_type_name(), "BUILD PHASE RUNNING ...", UVM_LOW)
    endfunction: build_phase
    
endclass