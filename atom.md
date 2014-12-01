# Atom

Text editor.

Open source.

Still immature, lacking features and plugins, but very promising.

Huge advantage: sane, beautiful tech stack:

- Node.js + `node-webkit` + CoffeeScript + LESS + CSON. No Vimscript!!
- built with a package system that resolves dependencies from day 0: `apm`
- unit tests system from day one, including for packages, based on Jasmine

Default key bindings: Sublime text clone, but Vim-mode mappings with `apm install vim-mode`

Command cheatsheets:

- <https://bugsnag.com/blog/atom-editor-cheat-sheet>

## Commands

`c-,`: configuration view

## Configuration files

All under `~/.atom/`

- `config.cson`: main configuration file
- `keybinding.cson`

## Packages

Disable packages: not possible through GUI. `config.cson` > `core` > `disabledPackages` array.

### APM

Search for package:

    apm search vim

Install package:

    apm install vim-mode

### Packages I recommend:

    apm install vim-mode
