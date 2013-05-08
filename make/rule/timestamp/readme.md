dependencies are understood to be files

unless they are put under .PHONY

rules are only made if inputs have been changed
after the outputs

make determines this by comparing the time of last mofification
timestamp of inputs and outputs

to try this out:

	echo a > in
	make
	    #rule was called
	make
	    #rule not called
	    #input did not change after output
	echo b > in
	make
	    #rule called
	    #input changed after output
	echo b > in
	make
	    #rule called
	    #input changed after output
	    #even if content did not change
