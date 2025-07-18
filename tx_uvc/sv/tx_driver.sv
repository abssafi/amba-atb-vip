class tx_driver extends uvm_driver #(tx_packet);
    `uvm_component_utils(tx_driver)

    function new (string name = "tx_driver", uvm_component parent);
        super.new(name, parent);
    endfunction:new 

    function void build_phase(uvm_phase phase);
        super.build_phase (phase);
        `uvm_info(get_type_name(), "BUILD PHASE RUNNING...", UVM_LOW);
    endfunction: build_phase

    task run_phase (uvm_phase phase);

        forever begin
            seq_item_port.get_next_item(req);
            `uvm_info(get_type_name(), $sformatf("Packet RECEIVED: \n%s", req.sprint()), UVM_LOW)
            seq_item_port.item_done(req);
        end

    endtask: run_phase

    // function void connect_phase (uvm_phase phase);
    //     if (!uvm_config_db#(virtual tx_if)::get(this, "", "vif", vif))
    //     `uvm_fatal("NOVIF", "VIF in DRIVER is NOT SET")
    // endfunction: connect_phase

endclass: tx_driver