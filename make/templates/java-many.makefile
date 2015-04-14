# Compile each Java file in the current directory.
# Put the output in the current directory.

OUT_EXT ?= .class
RUN ?= Main

.PHONY: all clean run

# javac already compiles only if necessary based on timestamps.
# It even takes care of imports for us!
all:
	javac *.java

clean:
	rm *$(OUT_EXT)

run: all
	java -ea '$(RUN)'
