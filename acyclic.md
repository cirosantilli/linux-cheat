# acyclic

Graphviz project.

Determine if the digraph is acyclic, and print a modified version with some edges reversed so that it becomes acyclic:

    echo 'digraph g1 { a -> b; b -> a }' | acyclic && exit 1

Output:

    digraph g1 {
        a -> b;
        a -> b;
    }
