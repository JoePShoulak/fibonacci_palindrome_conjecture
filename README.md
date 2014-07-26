# The question

The program generates Fibonacci numbers, takes them mod M until they repeat (proven to always do so by D. D. Wall, 1960). They are then arranged in an array like this:

1 3

2 4

The bottom seems to always be a palindrome, and the top can be split on two zeroes (one is the first indice of the series, which starts with 0, 1, and the second which is halfay through the width of the array). After splitting on these zeroes, the two resulting strings are sometimes palindromes. This program tests that. 

# p\_test\_lib.rb
This file contains all the functions needed to run the tests.

# p\_test\_custom.rb
This accepts either one number or two as CL args. If there is one number, it tests for that one number, and offers to show you the array if you want to (verbosity opportunity via STDIN). If there are two numbers, it tests every number in the range, gives you success data along the way, and again offers more details at the end, but this time not the arrays, but some overall statistics of the data run. 

# p\_test\_continuous.rb
This program reads the last line of the data file to find out what the largest run number is, and starts there, running numbers until it receives a keyboard interrupt, all the while giving the same partial data as in p\_test\_custom. Again, you get a chance to see statistics. When you are finished, the data is saved in p\_data.txt_

# p\_analyze.rb

This program gives you the same analysis at the end of a run of either of the p\_test programs, but for all of the data within p\_data.txt.