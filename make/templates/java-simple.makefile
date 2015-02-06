IN_EXT ?= .java
OUT_EXT ?= .class
RUN ?= Main

INS := $(wildcard *$(IN_EXT))
OUTS_NOEXT := $(basename $(INS))
OUTS := $(addsuffix $(OUT_EXT), $(OUTS_NOEXT))

.PHONY: all clean install-deps-ubuntu run

all: $(OUTS)

%$(OUT_EXT): %$(IN_EXT)
	javac '$<'

clean:
	rm *$(OUT_EXT)

help:
	@echo 'Compile each `.java` file into a `.class`.'
	@echo ''
	@echo 'all                 - (default) Build all targets.'
	@echo 'clean               - Remove files built.'
	@echo 'install-deps-ubuntu - Install dependencies on Ubuntu.'
	@echo 'run                 - Run the default file.'
	@echo 'run RUN=Main        - Run the file named `Main.java` (default)'

install-deps-ubuntu:
	sudo apt-get install openjdk-7-jdk

run: all
	java -ea '$(RUN)'
