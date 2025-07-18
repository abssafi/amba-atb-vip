class tx_packet extends uvm_sequence_item;

    /*Global Signals*/
    bit atclken;

    /*Data Signals*/

    rand bit [31:0] atdata; // Trace data
    rand bit [1:0] atbytes; // The number of bytes on ATDATA to be captured, minus 1.

    rand bit [6:0] atid;    // An ID that uniquely identifies the source of the trace

    bit atvalid;            // A transfer is valid during this cycle
    bit afready;            // Flush signal

    bit syncreq;            // Synchronization request signal
    bit atwakeup;           // Wake-up Signal


    /*Factory Registration*/
    `uvm_object_utils_begin(tx_packet)
        `uvm_field_int(atclken, UVM_ALL_ON)
        `uvm_field_int(atdata, UVM_ALL_ON)
        `uvm_field_int(atbytes, UVM_ALL_ON)
        `uvm_field_int(atid, UVM_ALL_ON)
        `uvm_field_int(atvalid, UVM_ALL_ON)
        `uvm_field_int(afready, UVM_ALL_ON)
        `uvm_field_int(syncreq, UVM_ALL_ON)
        `uvm_field_int(atwakeup, UVM_ALL_ON)
    `uvm_object_utils_end

    /*Constructor*/
    function new(string name = "tx_packet");
        super.new(name);
    endfunction : new

endclass : tx_packet