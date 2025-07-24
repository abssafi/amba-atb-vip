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
        //`uvm_info(get_type_name(), "Running data_sequence...", UVM_LOW)
        `uvm_create(req)
        start_item(req);
        ok = req.randomize();
        assert (ok) else `uvm_fatal("TX_DRIVER", "RANDOMIZATION FAILED");
        finish_item(req);

    endtask: body

endclass: data_sequence 

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////                        tx_data_retention_seq                               //////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class tx_data_retention_seq extends tx_sequence;
     `uvm_object_utils(tx_data_retention_seq)

     data_sequence d_seq;
    
    function new (string name = "tx_data_retention_seq");
        super.new(name);
    endfunction

    task body();
        `uvm_info(get_type_name(), "Running tx_data_retention_seq...", UVM_LOW)

        //simple packet test, should sent 20 packets, so 20/4 = 5 full atdata packets.
        repeat(20)
            `uvm_do (d_seq)
        
    endtask

endclass: tx_data_retention_seq

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////                         tx_flush_test_seq                                  //////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class tx_flush_test_seq extends tx_sequence;
     `uvm_object_utils(tx_flush_test_seq)

     data_sequence d_seq;
    
    function new (string name = "tx_flush_test_seq");
        super.new(name);
    endfunction

    task body();
        `uvm_info(get_type_name(), "Running tx_flush_test_seq...", UVM_LOW)

        //simple packet test, should sent 15 full packets
        repeat(60)
            `uvm_do (d_seq)

        //flush test, should send with atbytes  = 3 
        repeat(3)
            `uvm_do (d_seq)
        
    endtask

endclass: tx_flush_test_seq

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////                         tx_ready_flag_seq                                  //////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


class tx_ready_flag_seq extends tx_sequence;
     `uvm_object_utils(tx_ready_flag_seq)

     data_sequence d_seq;
    
    function new (string name = "tx_ready_flag_seq");
        super.new(name);
    endfunction

    task body();
        `uvm_info(get_type_name(), "Running tx_ready_flag_seq...", UVM_LOW)
        // here atvalid is 1
        repeat(3)
            `uvm_do (d_seq)
        
    endtask

endclass: tx_ready_flag_seq


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////                         tx_coherence_seq                                  //////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


class tx_coherence_seq extends tx_sequence;
     `uvm_object_utils(tx_coherence_seq)

     data_sequence d_seq;
    
    function new (string name = "tx_coherence_seq");
        super.new(name);
    endfunction

    task body();
        `uvm_info(get_type_name(), "Running tx_coherence_seq...", UVM_LOW)

        repeat(32)
           // `uvm_do_with(d_seq, {req.atid == 2;}
            `uvm_do (d_seq)
        
    endtask

endclass: tx_coherence_seq


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////                         tx_byte_order_seq                                  //////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


class tx_byte_order_seq extends tx_sequence;
     `uvm_object_utils(tx_byte_order_seq)

     data_sequence d_seq;
    
    function new (string name = "tx_byte_order_seq");
        super.new(name);
    endfunction

    task body();
        `uvm_info(get_type_name(), "Running tx_byte_order_seq...", UVM_LOW)

        repeat(40)
           // `uvm_do_with(d_seq, {req.atid == 2;}
            `uvm_do (d_seq)
        
    endtask

endclass: tx_byte_order_seq


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////                         tx_valid_data_seq                                  //////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class tx_valid_data_seq extends tx_sequence;
     `uvm_object_utils(tx_valid_data_seq)

     data_sequence d_seq;
    
    function new (string name = "tx_valid_data_seq");
        super.new(name);
    endfunction

    task body();
        `uvm_info(get_type_name(), "Running tx_valid_data_seq...", UVM_LOW)

         //simple packet test, should sent 4
        repeat(16) 
            `uvm_do (d_seq)

        //flush test, atbytes value should be 2
        // repeat(2)
        //     `uvm_do (d_seq)
        
    endtask

endclass: tx_valid_data_seq

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////                         tx_at_bytes_seq                                       //////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class tx_at_bytes_seq extends tx_sequence;
     `uvm_object_utils(tx_at_bytes_seq)

     data_sequence d_seq;
    
    function new (string name = "tx_at_bytes_seq");
        super.new(name);
    endfunction

    task body();
        `uvm_info(get_type_name(), "Running tx_at_bytes_seq...", UVM_LOW)

        //atbytes should be 3
        repeat(25) 
            `uvm_do (d_seq)

         //atbytes should be 2
        // repeat(2) 
        //     `uvm_do (d_seq)

        // //atbytes should be 1
        // repeat(1) 
        //     `uvm_do (d_seq)
        
    endtask

endclass: tx_at_bytes_seq

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////                         tx_exhaustive_seq                                  //////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class tx_exhaustive_seq extends tx_sequence;
     `uvm_object_utils(tx_exhaustive_seq)

     data_sequence d_seq;
    
    function new (string name = "tx_exhaustive_seq");
        super.new(name);
    endfunction

    task body();
        `uvm_info(get_type_name(), "Running tx_exhaustive_seq...", UVM_LOW)

         //simple packet test, should sent 250
        repeat(1000) 
            `uvm_do (d_seq)
        
        repeat(200) 
            `uvm_do (d_seq)

        repeat (80)
            `uvm_do (d_seq)

        repeat (3)
            `uvm_do (d_seq)
        
    endtask

endclass: tx_exhaustive_seq
