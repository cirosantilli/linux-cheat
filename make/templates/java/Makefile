.POSIX:

OUT_EXT ?= .class
RUN ?= A

.PHONY: all clean run

all:
	javac *.java

clean:
	rm -f *$(OUT_EXT)

run: all
	java -ea '$(RUN)'
