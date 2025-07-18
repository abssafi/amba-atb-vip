class tx_test extends uvm_test;
    `uvm_component_utils(tx_test)

    tx_top_env tx_top_env;

    function new (string name = "tx_test", this);
        super.new(name, this);
    endfunction: new

    function void build_phase (uvm_phase phase);
        tx_top_env = tx_top_env::type_id::create("tx_top_env");
        super.build_phase(phase);
        `uvm_info(get_type_name, "BUILD PHASE RUNNING...", this)
    endfunction: build_phase

    function void end_of_elaboration_phase(uvm_phase phase);
        uvm_top.print_topology();
    endfunction: end_of_elaboration_phase

endclass: tx_test