class rx_env extends uvm_env;
    `uvm_component_utils(rx_env)

    function new (string name = "rx_env", uvm_component parent);
        super.new(name, parent);
    endfunction

    rx_agent agent;

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        agent = rx_agent::type_id::create("agent", this);
        `uvm_info(get_type_name(), "BUILD PHASE RUNNING...", UVM_LOW);
    endfunction: build_phase

endclass: rx_env