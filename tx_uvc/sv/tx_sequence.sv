class tx_sequence extends uvm_sequence#(tx_packet);
    `uvm_object_utils(tx_sequence)

    function new (string name = "tx_sequence");
    super.new(name);
    endfunction: new

    task pre_body();
        uvm_phase phase;
        `ifdef UVM_VERSION_1_2
            phase = get_starting_phase();
        `else
            phase = starting_phase;
        `endif
        if (phase != null) begin
            phase.raise_objection(this, get_type_name());
            `uvm_info(get_type_name(), "OBJECTION RAISED", UVM_MEDIUM)
        end

    endtask : pre_body

    task body();
        set_response_queue_depth(-1);
    endtask: body

    task post_body();
        uvm_phase phase;
        `ifdef UVM_VERSION_1_2
            phase = get_starting_phase();
        `else
            phase = starting_phase;
        `endif
        if (phase != null) begin
            phase.drop_objection(this, get_type_name());
            `uvm_info(get_type_name(), "OBJECTION DROPPED", UVM_MEDIUM)
        end
    endtask : post_body

endclass: tx_sequence

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////                            data_sequence                                   //////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class data_sequence extends tx_sequence;
     `uvm_object_utils(data_sequence)
    
    function new (string name = "data_sequence");
        super.new(name);
    endfunction

    task body();
        bit ok;
        `uvm_info(get_type_name(), "Running data_sequence...", UVM_LOW)
        `uvm_create(req)
        start_item(req);
        ok = req.randomize();
        assert (ok) else `uvm_fatal("TX_DRIVER", "RANDOMIZATION FAILED");
        finish_item(req);

    endtask: body

endclass: data_sequence 

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////                         data_sequence_testing                               //////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class data_sequence_testing extends tx_sequence;
     `uvm_object_utils(data_sequence_testing)

     data_sequence d_seq;
    
    function new (string name = "data_sequence");
        super.new(name);
    endfunction

    task body();
        `uvm_info(get_type_name(), "Running data_sequence_testing...", UVM_LOW)

        //simple packet test, should sent 7
        repeat(7)
            `uvm_do (d_seq)

        //flush test
        // repeat(3)
        //     `uvm_do (d_seq)

    endtask

endclass: data_sequence_testing