# Dijkstra

Graphviz project.

    echo 'digraph g1 { a -> b [len=1]; b -> c[len=2] }' | dijkstra a

Output:

    digraph g1 {
        graph [maxdist=3.000];
        a        [dist=0.000];
        b        [dist=1.000];
        a -> b   [len=1];
        c        [dist=3.000];
        b -> c   [len=2];
    }
