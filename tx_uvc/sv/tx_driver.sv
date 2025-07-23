class tx_driver extends uvm_driver #(tx_packet);
    `uvm_component_utils(tx_driver)

    uvm_analysis_port #(tx_packet) tx_coverage_collect;

    function new (string name = "tx_driver", uvm_component parent);
        super.new(name, parent);
    endfunction:new 

    virtual atb_if vif;
    int count;
    int sent_packets;
    tx_packet tx_q[$];
    int trace_q[$:3];
    tx_packet send_p;
    int atvalid_n;
    int byte_n;
    int bte;
    int flush_packets;

    function void build_phase(uvm_phase phase);
        super.build_phase (phase);
        `uvm_info(get_type_name(), "BUILD PHASE RUNNING...", UVM_LOW);
        tx_coverage_collect = new("tx_coverage_collect", this);
    endfunction: build_phase

    task run_phase (uvm_phase phase);
        if (vif == null)
            `uvm_fatal(get_type_name(), "Driver VIF is NULL in run_phase")

        if (vif.atresetn == 0)
            reset_signals();

        wait(vif.atresetn == 1);
            `uvm_info(get_type_name(), "Reset Deactivated!", UVM_LOW);
          
        forever begin
            
            @(posedge vif.atclk);
            seq_item_port.get_next_item(req);
            trace_q.push_back(req.trace_data);
            req.atvalid = 0;
            vif.atvalid = 0;
            

            if(trace_q.size() == 4) begin
                req.atdata[7:0] = trace_q.pop_front();
                req.atdata[15:8] = trace_q.pop_front();
                req.atdata[23:16] = trace_q.pop_front();
                req.atdata[31:24] = trace_q.pop_front();
                req.atvalid = 1;
                vif.atvalid = 1;
                req.atbytes = 4;
                vif.atbytes = 4;
                
            end

            //flush logic, but incomplete, need to assert afreadt == 1 as well.
            if (vif.afvalid == 1 && trace_q.size() > 0) begin
                //req.atdata = 0;
                req.atbytes = 0;

                // for (int i = 0, i < 4, i++) begin 
                //     while (trace_q.size() != 0) begin
                //         if (i == 0)
                //             req.atdata[7:0] = trace_q.pop_front();
                //         if (i == 1)
                //             req.atdata[15:8] = trace_q.pop_front();
                //         if (i == 2)
                //             req.atdata[23:16] = trace_q.pop_front();
                //         if (i == 3)
                //             req.atdata[31:24] = trace_q.pop_front(); 
                //         byte_n++;
                //     end
                // end

                for (int i = 0; i < 4 && trace_q.size() > 0; i++) begin
                    bte = trace_q.pop_front();
                    $display("Popped and stored in bte : %h", bte);
                    case (i)
                        0: req.atdata[7:0] = bte;
                        1: req.atdata[15:8] = bte;
                        2: req.atdata[23:16] = bte;
                        3: req.atdata[31:24] = bte;
                    endcase
                    byte_n++;
                end
                vif.atbytes = byte_n;
                req.atbytes = byte_n;
                vif.atvalid = 1;
                req.atvalid = 1;
                //wait (vif.atready);
                send_to_dut(req);
                req.atvalid = 0;
                req.afready = 1;
                flush_packets++;
            end

            tx_coverage_collect.write(req);

            if(vif.atvalid) begin
                req.atbytes = 4;
                tx_q.push_back(req);
                atvalid_n++;
                //`uvm_info(get_type_name(), $sformatf("TX Packet Stored (atvalid high): \n%s", req.sprint()), UVM_LOW)   
            end

            if (vif.atready && vif.atvalid) begin
                $display("sending to bus (from tx)");
                send_p = tx_q.pop_front();
                send_to_dut(send_p);
                sent_packets++;
            end
            
            count++;
            
            seq_item_port.item_done(req);
        end

    endtask: run_phase

    function void report_phase (uvm_phase phase);
        `uvm_info(get_type_name(), $sformatf("TX DRIVER Packets Sent: %0d ", count), UVM_LOW);
        `uvm_info(get_type_name(), $sformatf("TX DRIVER (Full DATA Packets): %0d ", sent_packets), UVM_LOW);
        `uvm_info(get_type_name(), $sformatf("TX DRIVER (Packets Flushed): %0d ", flush_packets), UVM_LOW);
        //`uvm_info(get_type_name(), $sformatf("TX DRIVER ATDATA Packets SENT (atvalid && afvalid): %0d ", sent_packets), UVM_LOW);
        //`uvm_info(get_type_name(), $sformatf("TX DRIVER Packets with atvalid high : %0d ", atvalid_n), UVM_LOW);
        //`uvm_info(get_type_name(), $sformatf("Packets Remaining in Queue: %0d ", tx_q.size()), UVM_LOW);
    endfunction: report_phase

    function void connect_phase (uvm_phase phase);
        if (!uvm_config_db#(virtual atb_if)::get(this, "", "vif", vif))
        `uvm_fatal("NOVIF", "VIF in DRIVER is NOT SET")
    endfunction: connect_phase

//------------------------------------------------------
//                  Driver Methods
//------------------------------------------------------

    task send_to_dut(tx_packet req);
        `uvm_info(get_type_name(), "send_to_dut() CALLED", UVM_LOW)
        vif.atdata = req.atdata;
        //vif.atbytes = req.atbytes;
        vif.atid = req.atid;
        //vif.atvalid = req.atvalid;
        //vif.afready = req.afready;
        //vif.syncreq = req.syncreq;
        //vif.atwakeup = req.atwakeup;
        //`uvm_info(get_type_name(), $sformatf("Transaction # %0d - Packet SENT: \n%s", count+1, req.sprint()), UVM_LOW)   
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