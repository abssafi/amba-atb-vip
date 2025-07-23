class rx_packet extends uvm_sequence_item;


    bit atclken;

    bit [31:0] atdata;

    rand bit atready;
    rand bit afvalid; 
    rand bit syncreq;
    bit [2:0] atbytes;

    `uvm_object_utils_begin(rx_packet)
        `uvm_field_int(atdata, UVM_ALL_ON)
        `uvm_field_int(atbytes, UVM_ALL_ON)
        `uvm_field_int(atready, UVM_ALL_ON)
        `uvm_field_int(afvalid, UVM_ALL_ON)
        //`uvm_field_int(syncreq, UVM_ALL_ON)
    `uvm_object_utils_end

    function new(string name = "rx_packet");
        super.new(name);
    endfunction : new

endclass : rx_packet