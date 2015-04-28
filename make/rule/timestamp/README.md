Rules are only made if inputs have been changed after the outputs.

Make determines this by comparing the time of last modification timestamp of inputs and outputs.

# PHONY

Dependencies are understood to be files unless they are put under the `.PHONY` special target.
