# Clock-to-Seven-Segment-Baysis3-FPGA

Introduction:

Clock is on of the simple electronic things we know from chilidhood.
Its facinating to know the way this small things works.

Goal:

Design a full functioining clock (seconds,minutes,hours) and implement it on
Seven Segment on Baysis3 FPGA and PmodSSD.


Solution:

Only from above explaination:
Design a "time base counter" to give pulse every 1 sec (from 100Mhz internal clock)
prepere 3 counters for seconds,minutes and hours.

Design the Seven Segment block (binary to Seven Segment decoding)

Design the logic ontroling the refresh rate of the Seven Segment Display of Baysis3 and PmodSSD*

Create XDC file.

Create Bitstream file from Vivado®

Load the Bitstream to the Baysis3 Board and see the results!

*note: Taken into account the diffrance in connection of the anodes/cathods in Baysis3 and PmodSSD


Demonstration link:

https://drive.google.com/file/d/1RgnPbKxKWN5u0VA8GTULi9j0Era9Uwqj/view?usp=sharing


