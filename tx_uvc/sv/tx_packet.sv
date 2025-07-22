typedef enum {core, memory, dma} source_t;

class tx_packet extends uvm_sequence_item;
    
    randc source_t atb_source;
    rand bit [7:0] trace_data;

    bit atclken;
    bit [1:0] atbytes;
    bit [6:0] atid;
    bit [31:0] atdata;
    bit atvalid;          
    bit afready;        
    bit atwakeup;        

    `uvm_object_utils_begin(tx_packet)
        `uvm_field_int(trace_data, UVM_ALL_ON)
        `uvm_field_int(atdata, UVM_ALL_ON)
        `uvm_field_enum(source_t, atb_source, UVM_ALL_ON)
        `uvm_field_int(atbytes, UVM_ALL_ON)
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