# UVM based VIP for AMBA ATB Protocol

We are a team of three members.

- Ayesha
- Muhammad Qasim
- Abdur Rafay

In this Protocol, we are using UVM to cover all funcational coverage of `AMBA ATB Protocol`.


First we made two UVCs, one for transmitter and other one for receiver. In transmitter, we wrote the sequences, sent them through driver and monitor it in tx_monitor. 
then in rx_monitor, checked the condition, and if condition satisfy, it generates the required packet if condition fulfilled.

one top environment, that instantiate two UVCs. In top env, we made the interface signals. then set the virtual interface for both transmitter and recevier. Through this, we communicated with both UVCs. 

A simple test is run at this time on top environment, and we are getting the expected results. 

challenge: error when used '@', error resolved when used 'if' condition. 
            only use @ for reset, enable, clk


challenge: there was some conflict error / timing issue in scoreboard between tx transmitter and rx transmitter, write methods. so we added a delay before calling rx_monitor.  

challeng: response fifo in sequence default depth is 8. so when we send 8 or more randomized sequence packets, it gave response fifo overflow error. 
fix: using the set_response_queue_depth(value), which is a method declared in base uvm_sequence class. So calling the method and passing int value (setting depth of fifo), we changed the depth to 2000 (as per our packets numbers), error resolved. or setting -1 value which takes dynamic value according to our randomized packets. 

challenge: trace data has to come byte by byte, so we first made a 32 bits atdata, and send byte by byte into it. so after 4 clock cycle we would have a complete word. but there was problem in race conditions.
fix: so we used the blocking statement in tx_driver, as both were simulating on negedge, and tx_driver logic was dependent on atready, and rx_driver was also dependent on atvalid. so we just changed the operating edge of both. now one operating on rising edge and other operating on negedge. 

(22- 23 july)
challenge: now we have to implement atbytes in our condition, like if full packet is pushed, atbytes should be 4, and if flush condition is asserted, then atbytes would be the amount of valid bytes pushed by driver. e.g if we send 7 packets from our sequence, after pushing 4, atbytes would be 3(7-4 = 3). the main challenge was how to incorporate the afvalid signal in our logic. and how the correct atbytes should be checked.

fix:  as incomming bytes (trace_data) are pushed one by one into trace_q on each posedge. when qsize == 4, word is formed. and packed in req.atdata. if less than 4 bytes remain in trace_q and afvalid is 1, then remaing bytes are flushed. 
a loop is inserted to count the pop data. and the amount is first inserted in byte_n, and trace_q size decreases as loop continues. so if there are three remaining bytes, the loop will end in 3 cycles, and byte_n would be 3. 
To tackle the race conditions, tx_driver drives the values on posedge atclk and rx_driver works on negedge.

23-july

challenge: during flushing, if rx_sequence gave atready 1, the packet doesn't go to queue. but if afvalid and atready both high on first flushing cycle, the result comes correct. 