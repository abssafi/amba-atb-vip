class atb_scoreboard extends uvm_scoreboard;
    `uvm_component_utils(atb_scoreboard)

    `uvm_analysis_imp_dec1(_transmitter)
    `uvm_analysis_imp_dec1(_receiver)

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

    function void write_tx(tx_packet t_pkt);
        tx_packet t_pkt_copy;
        $cast(t_pkt_copy, t_pkt.clone());
        tx_q.push_back(t_pkt_copy);
    endfunction

    function void write_rx(rx_packet r_pkt);
        rx_packet r_pkt_copy;
        $cast(r_pkt_copy, r_pkt.clone());
        rx_q.push_back(r_pkt_copy);
        compare();
    endfunction

    function void compare();
        tx_packet t_pkt;
        rx_packet r_pkt;

        t_pkt = tx_q.pop_front();
        r_pkt = rx_q.pop_front();

        received++;
        if(t_pkt.atdata == r_pkt.atdata)
        begin
            `uvm_info(get_type_name(),"Packet Matched", UVM_LOW)
            matched++;
        end
        else
        begin
            `uvm_info(get_type_name(),"Packet Not Matched", UVM_LOW)
            error++;
        end
    endfunction

endclass