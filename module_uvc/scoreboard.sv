class scoreboard extends uvm_scoreboard;
    `uvm_component_utils(scoreboard)

    `uvm_analysis_imp_dec1(_transmitter)
    `uvm_analysis_imp_dec1(_receiver)

endclass