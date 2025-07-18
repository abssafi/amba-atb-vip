class tx_env extends uvm_env;
    `uvm_component_utils(tx_env)

    function new (string name = "tx_env", uvm_component parent);
        super.new(name, parent);
    endfunction

    tx_agent agent;

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        agent = tx_agent::type_id::create("agent", this);
    endfunction: Build_phase

    function void start_of_simulation_phase(uvm_phase phase);
        `uvm_info(get_type_name(), "Running Tx env Simulation ...", UVM_LOW);
    endfunction: start_of_simulation_phase
endclass: tx_env