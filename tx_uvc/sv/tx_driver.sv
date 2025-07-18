class tx_driver extends uvm_driver #(tx_packet);
    `uvm_component_utils(tx_driver)

    function new (string name = "tx_driver", uvm_component parent);
        super.new(name, parent);
    endfunction:new 

    virtual atb_if vif;
    int count;

    function void build_phase(uvm_phase phase);
        super.build_phase (phase);
        `uvm_info(get_type_name(), "BUILD PHASE RUNNING...", UVM_LOW);
    endfunction: build_phase

    task run_phase (uvm_phase phase);

        if (vif == null)
            `uvm_fatal(get_type_name(), "Driver VIF is NULL in run_phase")

        wait(vif.atresetn == 0);
        `uvm_info(get_type_name(), "Reset Deasserted!", UVM_LOW);
        forever begin
            @(negedge vif.atclk);
            seq_item_port.get_next_item(req);
            send_to_dut(req);
            count++;
            seq_item_port.item_done(req);
        end

    endtask: run_phase

    function void report_phase (uvm_phase phase);
        `uvm_info(get_type_name(), $sformatf("TX DRIVER Sent Packets: %0d ", count), UVM_LOW);
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
        vif.atvalid = req.atvalid;
        vif.afready = req.afready;
        //vif.syncreq = req.syncreq;
        vif.atwakeup = req.atwakeup;
        `uvm_info(get_type_name(), $sformatf("Transaction # %0d - Packet SENT: \n%s", count+1, req.sprint()), UVM_LOW)   
    endtask: send_to_dut


endclass: tx_driver