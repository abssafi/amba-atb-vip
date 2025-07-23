class tx_coverage extends uvm_subscriber#(tx_packet);
    `uvm_component_utils(tx_coverage)

    //uvm_analysis_imp #(tx_packet) analysis_export;
    //this is defined in base uvm_subscriber class.

    tx_packet pkt;
    int pkt_count;
    int coverage;
  
    covergroup tcg;
        coverpoint pkt.trace_data;
        coverpoint pkt.atdata;
        coverpoint pkt.atbytes;
        coverpoint pkt.atid;
        coverpoint pkt.atvalid;
    endgroup: tcg

    function new (string name = "tx_coverage", uvm_component parent);
        super.new(name, parent);
        tcg = new();
    endfunction: new

    function void write (tx_packet t);
        pkt = t;
        tcg.sample();
        pkt_count++;
        coverage = $get_coverage(); 
        //`uvm_info("TX COVERAGE", $sformatf("%0d Packets Sampled, Coverage = %0d", pkt_count, coverage), UVM_LOW)
    endfunction: write

endclass: tx_coverage