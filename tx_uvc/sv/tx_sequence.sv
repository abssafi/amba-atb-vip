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
//////////////////////////                         First Sequence                                   //////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class tx_test extends tx_sequence;
     `uvm_object_utils(tx_test)
    
    function new (string name = "tx_test");
        super.new(name);
    endfunction

    task body();
    bit ok;
    set_response_queue_depth(-1);

    repeat(771) begin
        `uvm_create(req)
        start_item(req);
        ok = req.randomize();
            assert (ok) else `uvm_fatal("TX_DRIVER", "RANDOMIZATION FAILED");
        finish_item(req);
    end
<<<<<<< HEAD

    endtask
=======
    
endtask
>>>>>>> b7794b8b48d3a3157adc9ab2e4ed4a2b1f7c3284

endclass   