class total_coverage extends uvm_component;
    `uvm_component_utils(total_coverage)

    function new (string name = "total_coverage", uvm_component parent);
        super.new(name, parent);
    endfunction: new

    covergroup atb;

    endgroup

endclass: coverage