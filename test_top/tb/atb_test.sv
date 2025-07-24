class base_test extends uvm_test;
    `uvm_component_utils(base_test)

    atb_test_env top_env;

    function new (string name = "base_test", uvm_component parent);
        super.new(name, parent);
    endfunction: new

    function void build_phase (uvm_phase phase);
        uvm_config_int::set( this, "*", "recording_detail", 1); 
        // uvm_config_wrapper::set(this, "top_env.tx_uvc.agent.sequencer.run_phase", "default_sequence", data_sequence_testing::get_type());
        // uvm_config_wrapper::set(this, "top_env.rx_uvc.agent.sequencer.run_phase", "default_sequence", nested_seq_testing::get_type());

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
        obj.set_drain_time(this, 15);
    endtask: run_phase

endclass: base_test

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////                          running_mcseq                                     //////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class running_mcseq extends base_test;
    `uvm_component_utils(running_mcseq)

    function new (string name = "running_mcseq", uvm_component parent);
        super.new(name, parent);
    endfunction: new

    function void build_phase (uvm_phase phase);

        uvm_config_wrapper::set(this, "top_env.mcseq.run_phase", "default_sequence", flag_mcseq::get_type());

        `uvm_info(get_type_name, "BUILD PHASE RUNNING...", UVM_LOW)
        super.build_phase(phase);
    endfunction: build_phase

endclass: running_mcseq

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////                          clk_en_test                                       //////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class clk_en_test extends base_test;
    `uvm_component_utils(clk_en_test)

    function new (string name = "clk_en_test", uvm_component parent);
        super.new(name, parent);
    endfunction: new

    function void build_phase (uvm_phase phase);

        uvm_config_wrapper::set(this, "top_env.mcseq.run_phase", "default_sequence", flag_mcseq::get_type());

        `uvm_info(get_type_name, "BUILD PHASE RUNNING...", UVM_LOW)
        super.build_phase(phase);
    endfunction: build_phase

endclass: clk_en_test

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////                          flush_seq_test                                    //////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class flush_seq_test extends base_test;
    `uvm_component_utils(flush_seq_test)

    function new (string name = "flush_seq_test", uvm_component parent);
        super.new(name, parent);
    endfunction: new

    function void build_phase (uvm_phase phase);
        uvm_config_int::set( this, "*", "recording_detail", 1); 
        uvm_config_wrapper::set(this, "top_env.tx_uvc.agent.sequencer.run_phase", "default_sequence", tx_flush_test_seq::get_type());
        uvm_config_wrapper::set(this, "top_env.rx_uvc.agent.sequencer.run_phase", "default_sequence", rx_flush_test_seq::get_type());

        `uvm_info(get_type_name, "BUILD PHASE RUNNING...", UVM_LOW)
        super.build_phase(phase);
    endfunction: build_phase

endclass: flush_seq_test


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////                          ready_flag_test                                   //////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class ready_flag_test extends base_test;
    `uvm_component_utils(ready_flag_test)

    function new (string name = "ready_flag_test", uvm_component parent);
        super.new(name, parent);
    endfunction: new

    function void build_phase (uvm_phase phase);
        uvm_config_int::set( this, "*", "recording_detail", 1); 
        uvm_config_wrapper::set(this, "top_env.tx_uvc.agent.sequencer.run_phase", "default_sequence", tx_ready_flag_seq::get_type());
        uvm_config_wrapper::set(this, "top_env.rx_uvc.agent.sequencer.run_phase", "default_sequence", rx_ready_flag_seq::get_type());

        `uvm_info(get_type_name, "BUILD PHASE RUNNING...", UVM_LOW)
        super.build_phase(phase);
    endfunction: build_phase

endclass: ready_flag_test


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////                          coherence_test                                   //////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class coherence_test extends base_test;
    `uvm_component_utils(coherence_test)

    function new (string name = "coherence_test", uvm_component parent);
        super.new(name, parent);
    endfunction: new

    function void build_phase (uvm_phase phase);
        uvm_config_int::set( this, "*", "recording_detail", 1); 
        uvm_config_wrapper::set(this, "top_env.tx_uvc.agent.sequencer.run_phase", "default_sequence", tx_coherence_seq::get_type());
        uvm_config_wrapper::set(this, "top_env.rx_uvc.agent.sequencer.run_phase", "default_sequence", rx_coherence_seq::get_type());

        `uvm_info(get_type_name, "BUILD PHASE RUNNING...", UVM_LOW)
        super.build_phase(phase);
    endfunction: build_phase

endclass: coherence_test


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////                          Byte_order_test                                   //////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class Byte_order_test extends base_test;
    `uvm_component_utils(Byte_order_test)

    function new (string name = "Byte_order_test", uvm_component parent);
        super.new(name, parent);
    endfunction: new

    function void build_phase (uvm_phase phase);
        uvm_config_int::set( this, "*", "recording_detail", 1); 
        uvm_config_wrapper::set(this, "top_env.tx_uvc.agent.sequencer.run_phase", "default_sequence", tx_coherence_seq::get_type());
        uvm_config_wrapper::set(this, "top_env.rx_uvc.agent.sequencer.run_phase", "default_sequence", rx_coherence_seq::get_type());

        `uvm_info(get_type_name, "BUILD PHASE RUNNING...", UVM_LOW)
        super.build_phase(phase);
    endfunction: build_phase

endclass: Byte_order_test



////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////                          valid_data_test                                   //////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class valid_data_test extends base_test;
    `uvm_component_utils(valid_data_test)

    function new (string name = "valid_data_test", uvm_component parent);
        super.new(name, parent);
    endfunction: new

    function void build_phase (uvm_phase phase);
        uvm_config_int::set( this, "*", "recording_detail", 1); 
        uvm_config_wrapper::set(this, "top_env.tx_uvc.agent.sequencer.run_phase", "default_sequence", tx_valid_data_seq::get_type());
        uvm_config_wrapper::set(this, "top_env.rx_uvc.agent.sequencer.run_phase", "default_sequence", rx_valid_data_seq::get_type());

        `uvm_info(get_type_name, "BUILD PHASE RUNNING...", UVM_LOW)
        super.build_phase(phase);
    endfunction: build_phase

endclass: valid_data_test