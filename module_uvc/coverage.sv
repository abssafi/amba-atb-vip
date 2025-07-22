class total_coverage extends uvm_component;
    `uvm_component_utils(total_coverage)

    `uvm_analysis_imp_decl(_txcoverg)
    `uvm_analysis_imp_decl(_rxcoverg)

    uvm_analysis_imp_txcoverg #(tx_packet, total_coverage) tx_cg;
    uvm_analysis_imp_rxcoverg #(rx_packet, total_coverage) rx_cg;

    int pkt_tx_count, pkt_rx_count;

    tx_packet pkt_tx;
    rx_packet pkt_rx;   

    function new (string name = "total_coverage", uvm_component parent);
        super.new(name, parent);
    endfunction: new

    covergroup atb;
        coverpoint pkt_tx;
        coverpoint pkt_rx;

        cross_txrx: cross pkt_tx, pkt_rx;
    endgroup

    function void write_txcoverg (tx_packet t);
        pkt_tx = t;
        atb.sample();
        pkt_tx_count++;
        coverage = $get_coverage(); 
        `uvm_info("TX COVERAGE", $sformatf("%0d Packets Sampled, Coverage = %0d", pkt_tx_count, coverage), UVM_LOW)
    endfunction: write

    function void write_rxcoverg (rx_packet r);
        pkt_rx = r;
        atb.sample();
        pkt_rx_count++;
        coverage = $get_coverage(); 
        `uvm_info("TX COVERAGE", $sformatf("%0d Packets Sampled, Coverage = %0d", pkt_rx_count, coverage), UVM_LOW)
    endfunction: write

endclass: total_coverage