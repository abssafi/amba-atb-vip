class rx_sequence extends uvm_sequence#(rx_packet);
    `uvm_object_utils(rx_sequence)

    function new (string name = "rx_sequence");
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
        bit ok;
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

endclass: rx_sequence

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////                          all_low                                          //////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class all_low extends rx_sequence;
     `uvm_object_utils(all_low)

    function new (string name = "all_low");
        super.new(name);
    endfunction

    task body();
        `uvm_info(get_type_name(), "Running all_low...", UVM_LOW)
        `uvm_do_with(req, {
            req.atready == 0;
            req.afvalid == 0;
            req.syncreq == 0;
            })
    endtask

endclass: all_low

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////                      at_ready_high_only                                     //////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class at_ready_high_only extends rx_sequence;
     `uvm_object_utils(at_ready_high_only)

    function new (string name = "at_ready_high_only");
        super.new(name);
    endfunction

    task body();
        `uvm_info(get_type_name(), "Running at_ready_high_only...", UVM_LOW)
        `uvm_do_with(req, {
            req.atready == 1;
            req.afvalid == 0;
            req.syncreq == 0;
            })
    endtask

endclass: at_ready_high_only

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////                          afvalid_high_only                                  //////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class afvalid_high_only extends rx_sequence;
     `uvm_object_utils(afvalid_high_only)

    function new (string name = "afvalid_high_only");
        super.new(name);
    endfunction

    task body();
        `uvm_info(get_type_name(), "Running afvalid_high_only...", UVM_LOW)
        `uvm_do_with(req, {
            req.atready == 0;
            req.afvalid == 1;
            req.syncreq == 0;
            })
    endtask

endclass: afvalid_high_only

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////                          syncreq_high_only                                 //////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class syncreq_high_only extends rx_sequence;
     `uvm_object_utils(afvalid_high_only)

    function new (string name = "syncreq_high_only");
        super.new(name);
    endfunction

    task body();
        `uvm_info(get_type_name(), "Running syncreq_high_only...", UVM_LOW)
        `uvm_do_with(req, {
            req.atready == 0;
            req.afvalid == 0;
            req.syncreq == 1;
            })
    endtask

endclass: syncreq_high_only

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////                           rx_flush_test_seq                                //////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class rx_flush_test_seq extends rx_sequence;
     `uvm_object_utils(rx_flush_test_seq)

    all_low low_seq;
    at_ready_high_only ready_seq;
    afvalid_high_only valid_seq;

    function new (string name = "rx_flush_test_seq");
        super.new(name);
    endfunction

    task body();
        `uvm_info(get_type_name(), "Running rx_flush_test_seq...", UVM_LOW)

        //simple packet test, should received 20
        repeat(60)
            `uvm_do(ready_seq)

        //flush test, should receive 1.
            `uvm_do(low_seq)
            `uvm_do(valid_seq)
            `uvm_do(ready_seq)

    endtask

endclass: rx_flush_test_seq