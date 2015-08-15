# sloccount

Count lines of code per subdirectory and language:

    sloccount .

Sample output for GDB Binutils 2.21

    SLOC	Directory	SLOC-by-Language (Sorted)
    397838  top_dir         ansic=382405,yacc=12028,sh=2076,lex=624,python=311,
                            perl=228,awk=142,lisp=24
    225982  testsuite       exp=120713,asm=50675,ansic=38439,cpp=9683,ada=2461,
                            python=1317,sh=934,lisp=857,pascal=348,f90=168,objc=134,xml=75,java=73,sed=62,fortran=43
    33356   gdbserver       ansic=33356
    18269   python          ansic=16242,python=2027
    15028   gnulib          ansic=14450,sh=578
    14671   features        ansic=11672,xml=2947,sh=52
    13702   guile           ansic=13075,lisp=627
    7313    tui             ansic=7313
    6483    mi              ansic=6483
    6291    stubs           ansic=6291
    5819    cli             ansic=5819
    5124    nat             ansic=5124
    4778    common          ansic=4765,sh=13
    4411    syscalls        xml=4373,python=38
    3404    compile         ansic=3404
    2660    contrib         sh=2003,python=639,ansic=18
    208     config          sh=125,ansic=43,sed=40
    153     regformats      sh=143,ansic=10
    110     target          ansic=110
    45      doc             sed=37,perl=5,sh=3
    44      system-gdbinit  python=44
    33      po              sh=33
    0       data-directory  (none)


    Totals grouped by language (dominant language first):
    ansic:       549019 (71.70%)
    exp:         120713 (15.76%)
    asm:          50675 (6.62%)
    yacc:         12028 (1.57%)
    cpp:           9683 (1.26%)
    xml:           7395 (0.97%)
    sh:            5960 (0.78%)
    python:        4376 (0.57%)
    ada:           2461 (0.32%)
    lisp:          1508 (0.20%)
    lex:            624 (0.08%)
    pascal:         348 (0.05%)
    perl:           233 (0.03%)
    f90:            168 (0.02%)
    awk:            142 (0.02%)
    sed:            139 (0.02%)
    objc:           134 (0.02%)
    java:            73 (0.01%)
    fortran:         43 (0.01%)




    Total Physical Source Lines of Code (SLOC)                = 765,722
    Development Effort Estimate, Person-Years (Person-Months) = 213.45 (2,561.45)
    (Basic COCOMO model, Person-Months = 2.4 * (KSLOC**1.05))
    Schedule Estimate, Years (Months)                         = 4.11 (49.34)
    (Basic COCOMO model, Months = 2.5 * (person-months**0.38))
    Estimated Average Number of Developers (Effort/Schedule)  = 51.92
    Total Estimated Cost to Develop                           = $ 28,834,758
    (average salary = $56,286/year, overhead = 2.40).
    SLOCCount, Copyright (C) 2001-2004 David A. Wheeler
    SLOCCount is Open Source Software/Free Software, licensed under the GNU GPL.
    SLOCCount comes with ABSOLUTELY NO WARRANTY, and you are welcome to
    redistribute it under certain conditions as specified by the GNU GPL license;
    see the documentation for details.
    Please credit this data as "generated using David A. Wheeler's 'SLOCCount'."

I like the COCOMO part.
