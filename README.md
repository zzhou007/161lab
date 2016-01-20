#README
###Leader
Zihang Zhou

###Group
Mark Asfour //
Kenneth Chan

###Remarks
We used a temporary signal to store the result of the operations.
The temporary signal was one bit longer than A, B to calculate overflow and/or carryout.
The reason why we used a temporary signal is because you cannot read from result since it is an output port.
Division by 2 is unsigned.

###Bugs
We tested and nothing was wrong ;^)
