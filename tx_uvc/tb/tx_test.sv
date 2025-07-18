class tx_test extends uvm_test;
    `uvm_component_utils(tx_test)

    tx_top_env top_env;

    function new (string name = "tx_test", uvm_component parent);
        super.new(name, parent);
    endfunction: new

    function void build_phase (uvm_phase phase);
        top_env = tx_top_env::type_id::create("top_env", this);
        uvm_config_wrapper::set(this, "tx_uvc.agent.sequencer.run_phase", "default_sequence", simple_test::get_type());
        `uvm_info(get_type_name, "BUILD PHASE RUNNING...", UVM_LOW)
        super.build_phase(phase);
    endfunction: build_phase

    function void end_of_elaboration_phase(uvm_phase phase);
        uvm_top.print_topology();
    endfunction: end_of_elaboration_phase

endclass: tx_test