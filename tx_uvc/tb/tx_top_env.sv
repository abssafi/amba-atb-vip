class tx_top_env extends uvm_env;
    `uvm_component_utils(tx_top_env)

    tx_env tx_uvc;

    function new (string name = "tx_top_env", uvm_component parent);
        super.new(name, parent);
    endfunction: new

    function void build_phase (uvm_phase phase);
        tx_uvc = tx_env::type_id::create("tx_uvc", this);
        super.build_phase(phase);
        `uvm_info(get_type_name, "BUILD PHASE RUNNING...", UVM_LOW)
    endfunction: build_phase

endclass: tx_top_env