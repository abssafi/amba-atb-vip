class tx_sequence extends uvm_sequence #(tx_packet);
    `uvm_object_utils(tx_sequence)
    
    function new(string name = "tx_sequence");
        super.new(name);
    endfunction

    // function void build_phase(uvm_phase phase);
    //     super.build_phase(phase);
    //     `uvm_info(get_type_name(), "Executing simple sequence", UVM_LOW)
    // endfunction
endclass

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////                         First Sequence                                   //////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



class simple_test extends tx_sequence;
    `uvm_object_utils(simple_test)

    function new (string name = "simple_test");
        super.new(name);
    endfunction

    task body();
        repeat(5) begin
            tx_packet pkt = tx_packet::type_id::create("pkt");
            start_item(pkt);
                pkt.randomize();
                `uvm_info("SEQ", $sformatf("Generate new item: %s", pkt.convert2str()), UVM_LOW)
      	    finish_item(pkt);
        end

    endtask
endclass   