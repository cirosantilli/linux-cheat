EXT ?= f
RUN ?= main

.PROXY: clean run

main: main.f
	gfortran -o '$(RUN)' '$(RUN).$(EXT)'

clean:
	rm '$(RUN)'

run: $(RUN)
	./'$(RUN)'
