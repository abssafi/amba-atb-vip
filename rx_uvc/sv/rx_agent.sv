class rx_agent extends uvm_agent;
    `uvm_component_utils(rx_agent)

    rx_driver driver;
    rx_monitor monitor;
    rx_sequencer sequencer;

    function new (string name = "rx_agent", uvm_component parent);
        super.new(name, parent);
    endfunction: new

    function void build_phase (uvm_phase phase);
        driver = rx_driver::type_id::create("driver", this);
        monitor = rx_monitor::type_id::create("monitor", this);
        sequencer = rx_sequencer::type_id::create("sequencer", this);
        super.build_phase(phase);
        `uvm_info(get_type_name(), "BUILD PHASE RUNNING...", UVM_LOW);
    endfunction: build_phase

    function void connect_phase(uvm_phase phase);
        driver.seq_item_port.connect(sequencer.seq_item_export);
    endfunction: connect_phase

endclass: rx_agent