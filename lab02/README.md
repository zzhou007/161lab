#README
###Leader
#####Mark Asfour

###Group
Zihang Zhou

Kenneth Chan

###Remarks
We used a temporary signal to store the result of the operations.
The temporary signal was one bit longer than A, B to calculate overflow and/or carryout.
The reason why we used a temporary signal is because you cannot read from result since it is an output port.
Division by 2 is unsigned.

We added modules called bcd_bin and bin_bcd converting to and from bin to bcd and connected it to the binary alu created in Lab 1.


###Bugs
We are not aware of any bugs

















( ͡° ͜ʖ ͡°)
