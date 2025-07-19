class base_test extends uvm_test;
    `uvm_component_utils(base_test)

    atb_test_env top_env;

    function new (string name = "base_test", uvm_component parent);
        super.new(name, parent);
    endfunction: new

    function void build_phase (uvm_phase phase);
        uvm_config_int::set( this, "*", "recording_detail", 1); 
        uvm_config_wrapper::set(this, "top_env.tx_uvc.agent.sequencer.run_phase", "default_sequence", tx_test::get_type());
        uvm_config_wrapper::set(this, "top_env.rx_uvc.agent.sequencer.run_phase", "default_sequence", rx_test::get_type());

        top_env = atb_test_env::type_id::create("top_env", this);
        `uvm_info(get_type_name, "BUILD PHASE RUNNING...", UVM_LOW)
        super.build_phase(phase);
    endfunction: build_phase

    function void end_of_elaboration_phase(uvm_phase phase);
        uvm_top.print_topology();
    endfunction: end_of_elaboration_phase

    task run_phase (uvm_phase phase);
        uvm_objection obj;
        obj = phase.get_objection();
        obj.set_drain_time(this, 5);
    endtask: run_phase

endclass: base_test