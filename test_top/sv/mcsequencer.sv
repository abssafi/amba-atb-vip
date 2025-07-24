class mcsequencer extends uvm_sequencer;
    `uvm_component_utils(mcsequencer)

tx_sequencer tx_seqr;
rx_sequencer rx_seqr;

function new (string name = "mcsequencer", uvm_component parent);
    super.new(name, parent);
endfunction

function void start_of_simulation_phase(uvm_phase phase);
    `uvm_info(get_type_name(), "Running Simulation ...", UVM_LOW);
endfunction: start_of_simulation_phase

endclass: mcsequencer