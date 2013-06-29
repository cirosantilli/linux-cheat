rules are only made if inputs have been changed
after the outputs

make determines this by comparing the time of last mofification
timestamp of inputs and outputs

# PHONY

dependencies are understood to be files unless they are put under the `.PHONY` special target
