class atb_test_env extends uvm_env;
    `uvm_component_utils(atb_test_env)

    tx_env tx_uvc;
    rx_env rx_uvc;

    atb_scoreboard atb_sb;
    total_coverage coverage_collecter;

    function new (string name = "atb_test_env", uvm_component parent);
        super.new(name, parent);
    endfunction: new

    function void build_phase (uvm_phase phase);
        tx_uvc = tx_env::type_id::create("tx_uvc", this);
        rx_uvc = rx_env::type_id::create("rx_uvc", this);
        atb_sb = atb_scoreboard::type_id::create("atb_sb", this);
        coverage_collecter = total_coverage::type_id::create("coverage_collecter", this);
        super.build_phase(phase);
        `uvm_info(get_type_name, "BUILD PHASE RUNNING...", UVM_LOW)
    endfunction: build_phase

    function void connect_phase (uvm_phase phase);
        tx_uvc.agent.monitor.tx_collected_port.connect(atb_sb.tx);
        rx_uvc.agent.monitor.rx_collected_port.connect(atb_sb.rx);

        tx_uvc.agent.driver.tx_coverage_collect.connect(coverage_collecter.tx_cg);
        rx_uvc.agent.driver.rx_coverage_collect.connect(coverage_collecter.rx_cg);

    endfunction

endclass: atb_test_env