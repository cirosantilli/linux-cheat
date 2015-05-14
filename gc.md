# gc

Graph Count various things in graphs.

Graphviz project.

Mnemonic `wc` for graphics.

Uses DOT language.

    echo 'graph g1 { a -- b; }' | gc

Output:

       2       1 g1 (<stdin>)
       ^       ^ ^^  ^^^^^^^
       1       2 3   4

1. node count
2. edge count
3. graph name
4. input file
