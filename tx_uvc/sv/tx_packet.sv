class tx_packet extends uvm_sequence_item;

    /*Global Signals*/
    bit atclken;

    /*Data Signals*/
    bit [7:0] trace_data;
    bit [31:0] atdata;
    rand bit [1:0] atbytes;
    rand bit [6:0] atid;  
    rand bit atvalid;          
    rand bit afready;        
    rand bit atwakeup;        

    `uvm_object_utils_begin(tx_packet)
        `uvm_field_int(atdata, UVM_ALL_ON)
        `uvm_field_int(atbytes, UVM_ALL_ON)
        `uvm_field_int(trace_data, UVM_ALL_ON)
        //`uvm_field_int(atid, UVM_ALL_ON)
        `uvm_field_int(atvalid, UVM_ALL_ON)
        //`uvm_field_int(afready, UVM_ALL_ON)
        //`uvm_field_int(atwakeup, UVM_ALL_ON)
    `uvm_object_utils_end

    /*Constructor*/
    function new(string name = "tx_packet");
        super.new(name);
    endfunction : new

endclass : tx_packet