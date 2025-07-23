interface atb_if (input bit atclk, input bit atresetn);

    logic atclken;

    logic [31:0] atdata;
    logic [2:0] atbytes;
    logic [6:0] atid;

    logic atvalid;
    logic atready;
    
    logic afready;
    logic afvalid;

    logic syncreq;
    logic atwakeup;

// a4: assert property (fourth) else $fatal("fourth asserion failed"); 
// a1: assert property (first) else $fatal("first asserion failed"); 
// a2: assert property (second) else $fatal("second asserion failed"); 
// a3: assert property (third) else $fatal("third asserion failed"); 
a5: assert property (fifth) else $fatal("fifth assertion failed");





property first; 
(@(posedge atclk) (atvalid |-> (atbytes==4)));
endproperty


// property second;
// (@(posedge atclk) (atvalid |-> atready));
// endproperty

// property third;
// (@(posedge atclk) (!atvalid |-> !atready));
// endproperty

// property fourth;
// (@(posedge atclk) (atvalid && atready |-> (atdata !== '0)));
// endproperty

//data should be zero when atvalid is 0. 

property fifth;
(@(posedge atclk) (atvalid == 0 |-> atdata == 0));

endproperty

endinterface : atb_if
