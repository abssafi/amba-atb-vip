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
//////////////////////////                         First Sequence                                     //////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class rx_test extends rx_sequence;
     `uvm_object_utils(rx_test)

    function new (string name = "rx_test");
        super.new(name);
    endfunction

    task body();

        // repeat(3) begin
        // `uvm_create(req)
        // req.atready = 0;
        // `uvm_send(req)
        // end

        // repeat(3) begin
        // `uvm_create(req)
        // req.atready = 1;
        // `uvm_send(req)
        // end

    repeat(1711)
        `uvm_do(req)

    endtask

endclass