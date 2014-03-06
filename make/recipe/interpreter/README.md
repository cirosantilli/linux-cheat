which program will be used to run the recipes

make uses `$SHELL` var (makefile var) to determine the interpreter to use

remember:

- each recipe line means one separated shell invocation

- recipe lines ending in `\`  get following line appended and are passed together to the interpreter
   #**with** the `\`

default: sh
