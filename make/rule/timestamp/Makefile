##phony

#if the rule is phony, then it is run even if the file exists

#if a target depends on a phony rule, it is always run,
#because phony rules are never considered already done (they have no timestamp)

#to avoid this TODO

.PHONY: clean change_in phony

#this rule is only run if `in` is newer than `out`
out: in
	@echo "$@"
	cp in out

in:
	@echo "$@"
	echo a > in

change_in:
	@echo "$@"
	echo a >> in

#if there are no dependencies,
#the rule is only run if the file does not exist
nodep:
	@echo "$@"

change_nodep:
	@echo "$@"
	echo a >> nodep

phony:
	@echo "$@"

change_phony:
	@echo "$@"
	echo a >> phony

clean:
	rm -f in out nodep phony

depends_on_phony: phony
