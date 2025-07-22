class total_coverage extends uvm_component;
    `uvm_component_utils(total_coverage)

    `uvm_analysis_imp_decl(_txcoverg)
    `uvm_analysis_imp_decl(_rxcoverg)

    uvm_analysis_imp_txcoverg #(tx_packet, total_coverage) tx_cg;
    uvm_analysis_imp_rxcoverg #(rx_packet, total_coverage) rx_cg;

    int pkt_tx_count, pkt_rx_count;

    tx_packet pkt_tx;
    rx_packet pkt_rx;  

    bit [7:0] trace_data;
    bit [31:0] atdata;
    bit [1:0] atbytes;
    bit [6:0] atid;  
    bit atvalid;          
    bit afready;        
    bit atwakeup;    

    bit atready;
    bit afvalid; 
    bit syncreq;

    covergroup atb;

        c1: coverpoint trace_data;
        c2: coverpoint atdata;
        c3: coverpoint atbytes;
        c4: coverpoint atid;  
        c5: coverpoint atvalid;          
        c6: coverpoint afready;        
        c7: coverpoint atwakeup;    

        c8: coverpoint afvalid;
        c9: coverpoint atready;
        c10: coverpoint syncreq;

        cross_txrx: cross c1, c2, c3, c4, c4, c6, c7, c8, c9, c10;

    endgroup

    function new (string name = "total_coverage", uvm_component parent);
        super.new(name, parent);
        tx_cg = new ("tx_cg", this);
        rx_cg = new("rx_cg", this);
        atb = new();
    endfunction: new


    function void write_txcoverg (tx_packet t);
        trace_data = t.trace_data;
        atdata = t.atdata;
        atbytes = t.atbytes;
        atid = t.atid;
        atvalid = t.atvalid;        
        afready = t.afready;   
        atwakeup = t.atwakeup;

        atb.sample();
        pkt_tx_count++;
        `uvm_info("TOTAL COVERAGE (TX PACKETS)", $sformatf("%0d Packets Sampled", pkt_tx_count), UVM_LOW)
    endfunction: write

    function void write_rxcoverg (rx_packet r);
        atready = r.atready;
        afvalid = r.afvalid;
        syncreq = r.syncreq;

        atb.sample();
        pkt_rx_count++;
        `uvm_info("TOTAL COVERAGE (rX PACKETS)", $sformatf("%0d Packets Sampled", pkt_rx_count), UVM_LOW)
    endfunction: write

endclass: total_coverage