# column

`bsdmainutils` package.

If the input would be larger than the current terminal column count, format it into newspaper like columns.

    seq 100 | column

Sample output:

    1	6	11	16	21	26	31	36	41	46	51	56	61	66	71	76	81	86	91	96
    2	7	12	17	22	27	32	37	42	47	52	57	62	67	72	77	82	87	92	97
    3	8	13	18	23	28	33	38	43	48	53	58	63	68	73	78	83	88	93	98
    4	9	14	19	24	29	34	39	44	49	54	59	64	69	74	79	84	89	94	99
    5	10	15	20	25	30	35	40	45	50	55	60	65	70	75	80	85	90	95	100

Options:

- `-t`: format data into table format. Intelligently uses a separator char
- `-s`: set the separator char

Command:

    printf '123|1|12345\n12345|123|1\n' | column -ts'|'

Sample output:

    123    1    12345
    12345  123  1
