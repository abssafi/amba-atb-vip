class atb_scoreboard extends uvm_scoreboard;
    `uvm_component_utils(atb_scoreboard)

    `uvm_analysis_imp_decl(_transmitter)
    `uvm_analysis_imp_decl(_receiver)

    uvm_analysis_imp_transmitter #(tx_packet, atb_scoreboard) tx;
    uvm_analysis_imp_receiver #(rx_packet, atb_scoreboard) rx;

    function new (string name = "atb_scoreboard", uvm_component parent);
        super.new(name,parent);
        tx = new("tx", this);
        rx = new("rx", this);
    endfunction

    tx_packet tx_q[$];
    rx_packet rx_q[$];

    int received = 0;
    int matched = 0;
    int error = 0;

////////////////////////////////////////////////////////////////////////
//                        write_transmitter
////////////////////////////////////////////////////////////////////////

    function void write_transmitter(input tx_packet t_pkt);
        tx_packet t_pkt_copy;
        $cast(t_pkt_copy, t_pkt.clone());
        tx_q.push_back(t_pkt_copy);
        `uvm_info(get_type_name, $sformatf("Added to TX Queue - Data: %0h", t_pkt_copy.atdata), UVM_LOW)
        //compare();
    endfunction

////////////////////////////////////////////////////////////////////////
//                        write_receiver
////////////////////////////////////////////////////////////////////////

    function void write_receiver(input rx_packet r_pkt);
        //rx_packet r_pkt_copy;
        //$cast(r_pkt_copy, r_pkt.clone());
        rx_q.push_back(r_pkt);
        `uvm_info(get_type_name, $sformatf("Added to RX Queue - Data: %0h", r_pkt.atdata), UVM_LOW)
        compare();
    endfunction

////////////////////////////////////////////////////////////////////////
//                        compare()
////////////////////////////////////////////////////////////////////////

    function void compare();
        tx_packet t_pkt;
        rx_packet r_pkt;

        if(tx_q.size() > 0 && rx_q.size() > 0) begin
            t_pkt = tx_q.pop_front();
            r_pkt = rx_q.pop_front();
            received++;

        if(t_pkt.atdata == r_pkt.atdata) begin
            `uvm_info(get_type_name(),$sformatf("Packet Matched. TX_Data = %0h| RX_DATA = %0h",t_pkt.atdata, r_pkt.atdata), UVM_LOW)
            matched++;
        end

        else begin
            `uvm_info(get_type_name(),$sformatf("Packet Not Matched. TX_Data = %0h| RX_DATA = %0h",t_pkt.atdata, r_pkt.atdata), UVM_LOW)
            error++;
        end
        end
    endfunction : compare

    function void report_phase(uvm_phase phase);
        $display("===============================================================================================================================================");
        $display("                                                      SCOREBOARD REPORT                                                                        ");
        $display("===============================================================================================================================================");
        `uvm_info("", $sformatf("Total Packets Received : %0d", received), UVM_LOW)
        `uvm_info("", $sformatf("Total Packets Matched : %0d", matched), UVM_LOW)
        `uvm_info("", $sformatf("Total Packets Mismatched : %0d", error), UVM_LOW)
    endfunction


endclass