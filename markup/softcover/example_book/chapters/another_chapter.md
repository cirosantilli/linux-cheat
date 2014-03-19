# Another chapter

This is another chapter.[^numbering] It also includes a little code fencing, mainly to test an edge case for the sake of the Softcover test suite:[^why_code_fencing]

```console
$ find . \( -name \*.gemspec -or -name \*.jpg \) -type f
```

[^numbering]: Footnotes are numbered on a per-chapter basis.

[^why_code_fencing]: The test suite uses the template files to stress-test the build system. In this case, there used to be a bug when math syntax appeared in a non-math context. Including the code fencing as above ensures that any regressions will cause the test suite to fail.