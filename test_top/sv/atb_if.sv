interface atb_if (input bit atclk, input bit atresetn, input bit atclken);

    //logic atclken;

    logic [31:0] atdata;
    logic [2:0] atbytes;
    logic [6:0] atid;

    logic atvalid;
    logic atready;
    
    logic afready;
    logic afvalid;

    logic syncreq;
    logic atwakeup;

a1: assert property (atdata_not_zero) else $fatal("assertion a1 failed");
a2: assert property (afvalid_low_after_atvalid_atready) else $fatal("assertion a3 failed"); 
a3: assert property (atid_reserved_value) else $fatal("assertion a4 failed"); 

property atdata_not_zero;
    (@(posedge atclk) (atvalid && atready |-> (atdata !== '0)));
endproperty

property afvalid_low_after_atvalid_atready;
    @(posedge atclk) (afvalid && afready |=> !afvalid) ;
endproperty

property atid_reserved_value;
@(posedge atclk) (atvalid && atready) |->
      !(((atid >= 7'h70) && (atid <= 7'h7C)) || (atid == 7'h7E) || (atid == 7'h7F));
endproperty

endinterface : atb_if