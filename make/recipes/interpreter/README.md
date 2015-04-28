Which program will be used to run the recipes

Make uses `$SHELL` var (makefile var) to determine the interpreter to use

Reminders:

- each recipe line means one separated shell invocation
- recipe lines ending in `\\` get following line appended and are passed together to the interpreter #**with** the `\\`

Default: `sh`
