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
        repeat(5) begin
        `uvm_do(req)
        end
    endtask


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

        `uvm_create(req)
            req.atdata = 32'h1234FFFF;
            req.atbytes = 2'b10;
            req.atvalid = 0;
        `uvm_send(req)

        `uvm_create(req)
            req.atdata = 32'h1234FFFF;
            req.atbytes = 2'b10;
            req.atvalid = 1;
        `uvm_send(req)

        `uvm_create(req)
            req.atdata = 32'hABCDFFFF;
            req.atbytes = 2'b11;
            req.atvalid = 1;
        `uvm_send(req)

    endtask

endclass   