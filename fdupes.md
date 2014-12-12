# fdupes

Fine command line tool for eliminating byte by byte duplicates you can either:

-   pick one by one

-   tell fdupes to pick the first one without asking
    (seem to pick one of the directories first always)

Finds and prints dupes:

    fdupes -r .

Finds dupes, and prompt which to keep for each match

    fdupes -rd .
