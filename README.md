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