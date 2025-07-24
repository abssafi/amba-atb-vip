class mcsequence extends uvm_sequence;
    `uvm_object_utils(mcsequence)

    function new (string name = "mcsequence");
        super.new(name);
    endfunction

    task pre_body();
        uvm_phase phase;
        `ifdef UVM_VERSION_1_2
            phase = get_starting_phase();
        `else
            phase = starting_phase;
        `endif
        if (phase != null) begin
            phase.raise_objection(this, get_type_name());
            `uvm_info(get_type_name(), "raise objection", UVM_MEDIUM)
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
            `uvm_info(get_type_name(), "drop objection", UVM_MEDIUM)
        end
    endtask : post_body

endclass: mcsequence


//=========================================================================================
//                                       flag_mcseq
//=========================================================================================

class flag_mcseq extends mcsequence;
    `uvm_object_utils(flag_mcseq)
    `uvm_declare_p_sequencer(mcsequencer)

tx_ready_flag_seq tx_flag_test;
rx_ready_flag_seq rx_flag_test;

function new (string name = "flag_mcseq");
    super.new(name);
endfunction

task body();
    `uvm_info(get_type_name(), "Executing the test sequence", UVM_LOW)

    fork
        `uvm_do_on(tx_flag_test, p_sequencer.tx_seqr);
        `uvm_do_on(rx_flag_test,p_sequencer.rx_seqr);
    join

endtask

endclass: flag_mcseq
