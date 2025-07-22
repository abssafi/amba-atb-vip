class rx_coverage extends uvm_subscriber#(rx_packet);
    `uvm_component_utils(rx_coverage)

    rx_packet pkt;
    int pkt_count;
    int coverage;
  
    covergroup rcg;
        coverpoint pkt.atready;
        coverpoint pkt.afvalid;
        coverpoint pkt.syncreq;
    endgroup: rcg

    function new (string name = "rx_coverage", uvm_component parent);
        super.new(name, parent);
        rcg = new();
    endfunction: new

    function void write (rx_packet t);
        pkt = t;
        rcg.sample();
        pkt_count++;
        coverage = $get_coverage(); 
        `uvm_info("RX COVERAGE", $sformatf("%0d Packets Sampled, Coverage = %0d", pkt_count, coverage), UVM_LOW)
    endfunction: write

endclass: tx_coverage