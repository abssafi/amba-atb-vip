class rx_top_env extends uvm_env;
    `uvm_component_utils(rx_top_env)

    rx_env rx_uvc;

    function new (string name = "rx_top_env", uvm_component parent);
        super.new(name, parent);
    endfunction: new

    function void build_phase (uvm_phase phase);
        rx_uvc = rx_env::type_id::create("rx_uvc", this);
        super.build_phase(phase);
        `uvm_info(get_type_name, "BUILD PHASE RUNNING...", UVM_LOW)
    endfunction: build_phase

endclass: rx_top_env