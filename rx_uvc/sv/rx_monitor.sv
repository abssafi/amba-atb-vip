class rx_monitor extends uvm_monitor;
    `uvm_component_utils(rx_monitor)

    virtual rx_if vif;
    int mon_pkt_col;
    rx_packet pkt;

    function new (string name = "rx_monitor", uvm_component parent);
        super.new(name, parent);
    endfunction:new

    function void build_phase (uvm_phase phase);
        super.build_phase(phase);
        `uvm_info(get_type_name(), "BUILD PHASE RUNNING...", UVM_LOW);
    endfunction: build_phase

    virtual function void connect_phase(uvm_phase phase);
        if (!rx_vif_config::get(this,"","vif", vif))
            `uvm_error("NOVIF","vif not set")
    endfunction

    virtual task run_phase(uvm_phase phase);
        if(vif == null)
            `uvm_fatal(get_type_name(), "rx INTERFACE not accessible!")
    
        `uvm_info(get_type_name(), $sformatf("Executing Monitor Run Phase!"), UVM_HIGH)
        
        @(posedge vif.atclk);
        
        wait(vif.atresetn == 0);
        `uvm_info(get_type_name(), "Reset Deasserted!", UVM_LOW);

        forever begin           
            @(posedge vif.atclk); 

            `uvm_info(get_type_name(), "Transaction Detected in Monitor", UVM_HIGH)

            pkt = rx_packet::type_id::create("pkt", this);
            collect_packet(pkt);
            mon_pkt_col++;
                    
        end
    
    
    endtask : run_phase

    task collect_packet(input rx_packet pkt);
        
        pkt.atclken = vif.atclken;
        pkt.atdata = vif.atdata;
        pkt.atbytes = vif.atbytes;
        pkt.atid = vif.atid;
        pkt.atvalid  = vif.atvalid;
        pkt.afready = vif.afready;

        `uvm_info(get_type_name(), $sformatf("Transaction # %0d - Packet is \n%s", mon_pkt_col+1, pkt.sprint()), UVM_HIGH)  

    endtask : collect_packet

    function void report_phase(uvm_phase phase);
        `uvm_info(get_type_name(), $sformatf("Report: Rx Monitor Collected %0d Packets", mon_pkt_col), UVM_HIGH)
    endfunction : report_phase

endclass: rx_monitor