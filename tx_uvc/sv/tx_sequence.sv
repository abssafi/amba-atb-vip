class tx_sequence extends uvm_sequence #(tx_packet);
    `uvm_object_utils(tx_sequence)
    
    function new(string name = "tx_sequence");
        super.new(name);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info(get_type_name(), "Executing simple sequence", UVM_LOW)
    endfunction
endclass

