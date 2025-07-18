interface tx_if (input bit atclk, input bit atresetn);
    /*Global Signals*/
    logic atclken;

    /*Data Signals*/
    logic [31:0] atdata; // Trace data
    logic [1:0] atbytes; // The number of bytes on ATDATA to be captured, minus 1.
    logic [6:0] atid;    // An ID that uniquely identifies the source of the trace

    logic atvalid;       // A transfer is valid during this cycle
    logic atready;       // The Receiver is ready to accept data
    
    logic afready;       // Flush signal ready
    logic afvalid;       // Flush signal valid

    logic syncreq;       // Synchronization request signal
    logic atwakeup;      // Wake-up Signal

endinterface : tx_if