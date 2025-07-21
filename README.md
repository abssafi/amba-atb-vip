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