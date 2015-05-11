.POSIX:

RUN ?= Main

.PHONY: all clean run

all:
	javac *.java

clean:
	rm -f *.class

run: all
	java -ea '$(RUN)'
