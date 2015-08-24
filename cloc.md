# cloc

Count files, line of code, empty lines and comment lines under directory.

    cloc .

Does not seem possible to add new languages. For more flexibility see: <http://stackoverflow.com/questions/1358540/how-to-count-all-the-lines-of-code-in-a-directory-recursively> A good one is:

    ( find ./ -name '*.tex' -print0 | xargs -0 cat ) | wc -l

Sample output for GDB:

        4770 text files.
        4642 unique files.
        367 files ignored.

    http://cloc.sourceforge.net v 1.60  T=26.40 s (164.1 files/s, 45916.2 lines/s)
    -------------------------------------------------------------------------------
    Language                     files          blank        comment           code
    -------------------------------------------------------------------------------
    C                             1566         122060         116444         514166
    Expect                        1315          30758          41690         121034
    Assembly                       153           2932           2441          51870
    Bourne Shell                    27           7605           6785          44371
    C/C++ Header                   443          15009          21944          34987
    m4                              90           1064            777          12973
    yacc                             9           2179           1849          12028
    C++                            173           2830           2295           9533
    XML                            174            555            823           7395
    Python                          63           1620           2659           4387
    Ada                            220            809           3160           2262
    make                             2            298            247           1639
    Teamcenter def                   5            164             62           1262
    Lisp                            16            231            405           1012
    lex                              1            108             87            455
    OpenCL                           6             91             71            433
    Pascal                          10            102             65            348
    Perl                             2             76             57            235
    Fortran 90                      10             43            142            163
    awk                              2             15             55            142
    sed                              8              7             20            139
    Objective C                      3             30              4            134
    Go                              10             34              3            116
    DTD                             11             58             55            114
    XSLT                             3              5              0            100
    Java                             4             14             34             73
    Fortran 77                       5             18             72             43
    D                                1              5             12              4
    -------------------------------------------------------------------------------
    SUM:                          4332         188720         202258         821418
    -------------------------------------------------------------------------------

In 2015 takes around 30 minutes on the Linux kernel: <http://www.quora.com/How-many-lines-of-code-are-in-the-Linux-kernel>
