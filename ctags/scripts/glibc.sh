#!/usr/bin/env bash

BAD_ARCHS='(aarch64|alpha|arm|hppa|ia64|m68k|mach/hurd|microblaze|mips|nios2|powerpc|s390|sh|sparc|tile)'
git ls-files |
  grep -Pv "^(hurd|sysdeps/(unix/(sysv/linux/)?)?$BAD_ARCHS)/" |
  ctags -R --c-kinds=-m -L -
