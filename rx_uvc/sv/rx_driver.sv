class rx_driver extends uvm_driver #(rx_packet);
    `uvm_component_utils(rx_driver)

    uvm_analysis_port #(rx_packet) rx_coverage_collect;

    function new (string name = "rx_driver", uvm_component parent);
        super.new(name, parent);
    endfunction:new 

    virtual atb_if vif;
    int count;
    int atready_n;

    function void build_phase(uvm_phase phase);
        super.build_phase (phase);
        `uvm_info(get_type_name(), "BUILD PHASE RUNNING...", UVM_LOW);
        rx_coverage_collect = new("rx_coverage_collect", this);
    endfunction: build_phase

    task run_phase (uvm_phase phase);

        if (vif == null)
            `uvm_fatal(get_type_name(), "Driver VIF is NULL in run_phase")

        if (vif.atresetn == 0)
            reset_signals();

        wait(vif.atresetn == 1);
            `uvm_info(get_type_name(), "Reset Deasserted!", UVM_LOW);
            
        @(posedge vif.atclk);
        forever begin
            // if (vif.atresetn == 0)
            //     reset_signals();
            @(negedge vif.atclk);
            
            seq_item_port.get_next_item(req);

            rx_coverage_collect.write(req);
            send_to_dut(req);
            count++;
            seq_item_port.item_done(req);
            
        end

    endtask: run_phase

    function void report_phase (uvm_phase phase);
        `uvm_info(get_type_name(), $sformatf("RX DRIVER Packets SENT: %0d", count), UVM_LOW);
        //`uvm_info(get_type_name(), $sformatf("TX DRIVER Packets with atready_n high : %0d ", atready_n), UVM_LOW);
    endfunction: report_phase

    function void connect_phase (uvm_phase phase);
        if (!uvm_config_db#(virtual atb_if)::get(this, "", "vif", vif))
        `uvm_fatal("NOVIF", "VIF in DRIVER is NOT SET")
    endfunction: connect_phase


//------------------------------------------------------
//                  Driver Methods
//------------------------------------------------------

    task send_to_dut(rx_packet req);
        vif.atready = req.atready;
        vif.afvalid = req.atready;
        vif.syncreq = req.atready;
        `uvm_info(get_type_name(), $sformatf("Transaction # %0d - Packet SENT: \n%s", count+1, req.sprint()), UVM_LOW)
    endtask: send_to_dut

    task reset_signals();
        vif.atready = 0;
        vif.afvalid = 0;
        vif.syncreq = 0;
    endtask : reset_signals


endclass: rx_driver