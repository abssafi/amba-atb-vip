class atb_test_env extends uvm_env;
    `uvm_component_utils(atb_test_env)

    tx_env tx_uvc;
    rx_env rx_uvc;

    function new (string name = "atb_test_env", uvm_component parent);
        super.new(name, parent);
    endfunction: new

    function void build_phase (uvm_phase phase);
        tx_uvc = tx_env::type_id::create("tx_uvc", this);
        rx_uvc = rx_env::type_id::create("rx_uvc", this);
        super.build_phase(phase);
        `uvm_info(get_type_name, "BUILD PHASE RUNNING...", UVM_LOW)
    endfunction: build_phase

    function void connect_phase (uvm_phase phase);
        tx_uvc.agent.monitor.tx_collected_port.connect();
        rx_uvc.agent.monitor.rx_collected_port.connect();
    endfunction

endclass: atb_test_env