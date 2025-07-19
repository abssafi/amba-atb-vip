class tx_monitor extends uvm_monitor;
    `uvm_component_utils(tx_monitor)

    virtual atb_if vif;
    int mon_pkt_col;
    tx_packet pkt;

    function new (string name = "tx_monitor", uvm_component parent);
        super.new(name, parent);
    endfunction:new

    function void build_phase (uvm_phase phase);
        super.build_phase(phase);
        `uvm_info(get_type_name(), "BUILD PHASE RUNNING...", UVM_LOW);
    endfunction: build_phase

    function void connect_phase(uvm_phase phase);
        if (!uvm_config_db#(virtual atb_if)::get(this,"","vif", vif))
            `uvm_error("NOVIF","vif not set")
    endfunction: connect_phase

    task run_phase(uvm_phase phase);
        if(vif == null)
            `uvm_fatal(get_type_name(), "TX INTERFACE not accessible!")
    
        `uvm_info(get_type_name(), $sformatf("Executing Monitor Run Phase!"), UVM_HIGH)
        
        @(posedge vif.atclk);
        
        wait(vif.atresetn == 0);
        `uvm_info(get_type_name(), "Reset Deasserted!", UVM_LOW);

        forever begin           
            @(posedge vif.atclk);
            if (vif.atvalid)   begin
                `uvm_info(get_type_name(), "Transaction Detected in Monitor", UVM_HIGH)
                pkt = tx_packet::type_id::create("pkt", this);
                collect_packet(pkt);
                mon_pkt_col++;
            end
                    
        end
    endtask: run_phase

    function void report_phase(uvm_phase phase);
        `uvm_info(get_type_name(), $sformatf("TX MONITOR Received Packets: %0d ", mon_pkt_col), UVM_HIGH)
    endfunction: report_phase

//------------------------------------------------------
//                  Driver Methods
//------------------------------------------------------

    task collect_packet(input tx_packet pkt);
        pkt.atclken = vif.atclken;
        pkt.atdata = vif.atdata;
        pkt.atbytes = vif.atbytes;
        pkt.atid = vif.atid;
        pkt.atvalid  = vif.atvalid;
        pkt.afready = vif.afready;
        pkt.atwakeup = vif.atwakeup;
        `uvm_info(get_type_name(), $sformatf("Transaction # %0d - Packet is \n%s", mon_pkt_col+1, pkt.sprint()), UVM_HIGH)  
    endtask : collect_packet

endclass: tx_monitor