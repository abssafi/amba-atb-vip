interface atb_if (input bit atclk, input bit atresetn);

    logic atclken;

    logic [31:0] atdata;
    logic [1:0] atbytes;
    logic [6:0] atid;

    logic atvalid;
    logic atready;
    
    logic afready;
    logic afvalid;

    logic syncreq;
    logic atwakeup;

endinterface : atb_if