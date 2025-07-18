class tx_sequencer extends uvm_sequencer #(tx_packet);
    `uvm_component_utils(tx_sequencer)

    function new(string name = "tx_sequencer", uvm_component parent);
        super.new(name,parent);
    endfunction: new

    function void start_of_simulation_phase(uvm_phase phase);
        `uvm_info(get_type_name(), "Running Tx Simulation ...", UVM_LOW);
    endfunction: start_of_simulation_phase
endclass