class tx_agent extends uvm_agent;
    `uvm_component_utils(tx_agent)

    tx_driver driver;
    tx_monitor monitor;
    tx_sequencer sequencer;
    tx_coverage tx_coverage_collecter;

    function new (string name = "tx_agent", uvm_component parent);
        super.new(name, parent);
    endfunction: new

    function void build_phase (uvm_phase phase);
        driver = tx_driver::type_id::create("driver", this);
        monitor = tx_monitor::type_id::create("monitor", this);
        sequencer = tx_sequencer::type_id::create("sequencer", this);
        tx_coverage_collecter = tx_coverage::type_id::create("tx_coverage_collecter", this);
        super.build_phase(phase);
        `uvm_info(get_type_name(), "BUILD PHASE RUNNING...", UVM_LOW);
    endfunction: build_phase

    function void connect_phase(uvm_phase phase);
        driver.seq_item_port.connect(sequencer.seq_item_export);
        driver.coverage_collect.connect(tx_coverage_collecter.analysis_export);
    endfunction: connect_phase

endclass: tx_agent