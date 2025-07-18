class rx_packet extends uvm_sequence_item;

    /*Global Signals*/
    bit atclken;

    /*Data Signals*/
    rand bit afvalid;     // The flush signal to indicate that all buffers must be flushed because trace capture is about to stop
    rand bit atready;     // The Receiver is ready to accept data

    rand bit syncreq;     // Synchronization request signal
    
    /*Factory Registration*/
    `uvm_object_utils_begin(rx_packet)
        `uvm_field_int(atclken, UVM_ALL_ON)
        `uvm_field_int(afvalid, UVM_ALL_ON)
        `uvm_field_int(atready, UVM_ALL_ON)
        `uvm_field_int(syncreq, UVM_ALL_ON)
    `uvm_object_utils_end

    /*Constructor*/
    function new(string name = "rx_packet");
        super.new(name);
    endfunction : new

endclass : rx_packet