class tx_driver extends uvm_driver #(tx_packet);
    `uvm_component_utils(tx_driver)

    function new (string name = "tx_driver", uvm_component parent);
        super.new(name, parent);
    endfunction:new 

    virtual atb_if vif;
    int count;
    int sent_packets;
    tx_packet tx_q[$];
    tx_packet send_p;

    function void build_phase(uvm_phase phase);
        super.build_phase (phase);
        `uvm_info(get_type_name(), "BUILD PHASE RUNNING...", UVM_LOW);
    endfunction: build_phase

    task run_phase (uvm_phase phase);

        if (vif == null)
            `uvm_fatal(get_type_name(), "Driver VIF is NULL in run_phase")

        if (vif.atresetn == 0)
            reset_signals();

        wait(vif.atresetn == 1);
            `uvm_info(get_type_name(), "Reset Deactivated!", UVM_LOW);

        forever begin
            
            @(negedge vif.atclk);
            seq_item_port.get_next_item(req);

            vif.atvalid = req.atvalid;
            
            req.trace_data = 8'hab;
            req.atdata[7:0] = req.trace_data;
            `uvm_info(get_type_name(), $sformatf("1st cycle: The packet is %0h: ", req.atdata), UVM_LOW)

            req.trace_data = 8'h12;
            req.atdata[15:8] = req.trace_data;
            `uvm_info(get_type_name(), $sformatf("2nd cycle: The packet is %0h: ", req.atdata), UVM_LOW)
            
            req.trace_data = 8'h34;
            req.atdata[23:16] = req.trace_data;
            `uvm_info(get_type_name(), $sformatf("3rd cycle: The packet is %0h: ", req.atdata), UVM_LOW)

            req.trace_data = 8'h56;
            req.atdata[31:24] = req.trace_data;
            `uvm_info(get_type_name(), $sformatf("4th cycle: The packet is %0h: ", req.atdata), UVM_LOW)

            tx_q.push_back(req);
            
            if (vif.atready && vif.atvalid) begin
                send_p = tx_q.pop_front();
                send_to_dut(send_p);
                sent_packets++;
                count++;
            end

            
            seq_item_port.item_done(req);
        end

    endtask: run_phase

    function void report_phase (uvm_phase phase);
        `uvm_info(get_type_name(), $sformatf("TX DRIVER Packets SENT: %0d ", count), UVM_LOW);
        `uvm_info(get_type_name(), $sformatf("TX DRIVER Packets SENT from QUEUE: %0d ", sent_packets), UVM_LOW);
        `uvm_info(get_type_name(), $sformatf("Packets Remaining in Queue: %0d ", tx_q.size()), UVM_LOW);
    endfunction: report_phase

    function void connect_phase (uvm_phase phase);
        if (!uvm_config_db#(virtual atb_if)::get(this, "", "vif", vif))
        `uvm_fatal("NOVIF", "VIF in DRIVER is NOT SET")
    endfunction: connect_phase


//------------------------------------------------------
//                  Driver Methods
//------------------------------------------------------

    task send_to_dut(tx_packet req);
        vif.atdata = req.atdata;
        vif.atbytes = req.atbytes;
        vif.atid = req.atid;
        //vif.atvalid = req.atvalid;
        vif.afready = req.afready;
        //vif.syncreq = req.syncreq;
        vif.atwakeup = req.atwakeup;
        `uvm_info(get_type_name(), $sformatf("Transaction # %0d - Packet SENT: \n%s", count+1, req.sprint()), UVM_LOW)   
    endtask: send_to_dut

    task reset_signals();
        vif.atdata = 0;
        vif.atbytes = 0;
        vif.atid = 0;
        vif.atvalid = 0;
        vif.afready = 0;
        vif.atwakeup = 0;
    endtask : reset_signals


endclass: tx_driver