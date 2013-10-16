#intro

MySQL is an open source data base management system (DBMS).

As of 2013, MySQL is the most popular server-based DBMS.

MySQL runs on a server.
The server executable is often called `mysqld`, which stands for MySQL deamon.

This means that either TCP or UDP requests are made on a standard port
in order to make requests to MySQL.

The default IANA port for MySQL is 3306.

Clients make CRUD requests to the server to the server using a special language also called mysql.
This language is not a general computer language, but rather a language specialized for making querries.
As such, it does not allow for basic features of general languages such as conditionals or loops.

The server holds session state about the connection. For example, a `SHOW WARNINGS` querry
will only show warnings if the last query produced a warning.

#sql standard

MySQL is generally compatible with the SQL standrad for DBMS,
but it is well known that there are many differences between how different DBMS
implement SQL, so it is not safe to assume that using SQL only will increase portability
too much.

Other important servers that implement SQL-like languages are:

- postgres. Also open source.
- sqlite. No server.

#mysql server

Configuration file:

    less /etc/mysql/my.cnf

Contains info such as: port to listen to.

#interfaces

##mysql utility

CLI interface to MySQL.

###login

Visualisation get messy when tables don't fit into the terminal width.

One advantage of this interface is the possibilty for automation using bash.

Log in as user `root` at host `localhost` and prompts for password:

    mysql -u root -h localhost -p

Automaticlly do a `USE cur_db` after logging in.

    mysql -u root -h localhost -p cur_db

TODO what defaults are taken is `-u` and `-l` are ommited:

    mysql -p

Without the `-p`, will try to login without using a password,
which is likely to fail for the root with default settings:

    mysql -u root -h localhost

TODO when does login without password not fail?

Log in with given password:

    mysql -u root -h localhost -p"pass"

There must be no space between `-p` and `"pass"`.
This has obviously the security risk of exposing your password.

###use modes

The `mysql` CLI utility can be used either as:

- an interactive REPL interface to MySQL

- a batch interface to MySQL, which deals with things such as login for you.
    Batch mode is used via either the `-e` option or by reading commands from a pipe.

    Execute commands from string and exit:

        mysql -u root -p -e "SHOW DATABASES;"

    Execute commands from a file and exit:

        mysql -u root -p < a.sql

###output format

If the output is to be given to a terminal,
mysql may process MySQL output to make it more human readable,
for example by adding table borders.

If the output is to be put into a pipe, mysql utility detects this and removes by default those
human readability features, separating columns with tab characters, and rows with newlines.
This makes sense since it is expected that the output is to be further interpreted by another program,
so human readable features should only complicate its task.

It is possible to customize what should be done in each case via command line options.

The following options are relevant:

- `-s`: silent. Does not print table borders.
    Separates entries with tabs and rows with newlines.

        mysql -se "SHOW DATABSES;"

`-N`: ommit table headers containing column names.

        mysql -Ne "SHOW DATABSES;"

`-r`: raw. Controls if the special characters `\0`, `\t` `\n` should be represented as backslash escapes or not.

    If yes, then the backslash character gets printed as `\\` to differentiate it.

##mysqladmin

CLI utilty that simplifies mysql administration tasks.

`-u`, `-p` and `-h` have analogous usage to that of the `mysql` command.

Login as user `root` and change its pasword:

    mysqladmin -u root -h localhost -p password

`password` here is a mysqladmin subcommand.
It seems that it is not possible to change the password of another user with this method.
Use `SET PASSWORD` or `UPDATE PASSWORD` for that instead.

##mysldump

CLI utility that allows to easily save a database to a file.

Dump to file, no `USE` instructions, drops existing tables:

    mysqldump -u root "$DB_NAME" > bak.sql
    mysqldump -u root "$DB_NAME" "$TABLE1" "$TABLE2" > bak.sql

Mutiple dbs, creates dbs with old names, uses them:

    mysqldump -u root --databases "$DB1" "$DB2" > bak.sql

    mysqldump -u root --all-databases > bak.sql

All dbs, includes `USE` statements.

    -d : no data
    --no-create-info : data only

##restore database from file

Make sure the db exists and that you really want to overwrite it!

    PASS=
    mysql -u root -p"$PASS" < bak.sql

    DB=
    DB2=
    PASS=
    mysql -u root -p"$PASS" -e "create database $DB2;"
    mysqldump -u root -p"$PASS" $DB | mysql -u root -p"$PASS" $DB2

##phpmyadmin

Popular php based broser interface for mysql.

Allows to view and modify databases on a browser.

##api

All major programming languages have a mysql interface.

The following have interfaces which are part of the mysql project:

- C
- Python
- PHP
- Perl
- Ruby

#test preparation

Before doing any tests, create a test user and a test database.

    mysql -u root -h localhost -p -e "
    CREATE USER 'test'@'localhost' IDENTIFIED BY 'pass';
    CREATE DATABASE test;
    GRANT ALL ON test.* TO 'test'@'localhost';
    "

You can now put into yout `.bashrc`:

    alias myt="mysql -u test -h localhost -ppass test"

so you can type `myt` to safely run any tests.

#help

The help command querries the server for mysql help information.

Examples:

    HELP DROP;
    HELP DROP TABLE;

#newlines

Newlines only have an effect when inside quotes. In other places, newlines are ignored.

#semicolon

A semicolon is required at the end of each command. Newlines do not work. For example:

    SELECT 'a'
    SELECT 'a';

is the same as

    SELECT 'a' SELECT 'a';

and therefore produces an error.

#comments

Single line comments can be done with the number sign `#`.

Multi line comments can be done as in C++ between `/**/` pairs.

If a multiline comment is for example of the form:

    /*!40100 SHOW TABLES */;

then it will *not* be treated as a comment on MySQL versions equal to or greater than `4.01.00`
and will get executed normally.

This type of version conditional comments serve a similar purpose to C `__STDC_VERSION__` typedefs.

#structure

MySQL organizes information hierarchically as:

- *databases* at the toplevel.
- each database contains tables.
- each table contains columns.
- each colun holds a single type of information:
    numbers, characters, text etx.

#command case

Commands are case insensitive.

For example, all the following work:

    SELECT * FROM db.tbl;
    select * from db.tbl;
    sElEct * fRoM db.tbl;

The most common convention is however to use upper case for built-in commands,
and lowercase for names given to tables, allowing to distinguish between both easily,
while allowing names to be all lowercase, as is usually the convention for variable names
in most modern programming languages.

#quotation types

There are three types of quotations in mysql:

- backticks: `` `table name` ``

    Can only be used for identifiers such as database or table names.

    Usage is only mandatory if either:

    - the identifier contain chars other than alphanumeric, underscore `_` or dollar `$`.

    - the identifier is a mysql keyword such as `date` or `int`.

    In other SQL implementations, square brackets must be used instead of backticks: `[]`

- single quotes: `'asdf'`. Represents literal strings.

- double quotes: `"asdf"`. Same as single quotes. Single quotes are more common across DBMSs, so prefer single quotes.

#error logging

Errors may occur either if a request is ill-formed or if an imposible operation is requested such as
dropping an inexistent table:

    DROP TABLE idontexist;

If one command gives an error, the execution is terminated immediately
without doing further commands in the same request. For example:

    DROP TABLE idontexist; SELECT 'hello';

will not show `hello` since an error ocurred before that.

Note that the `mysql` with the `-e` option sends all commands at once to the server
even if the commands are on separate lines. Therefore for example the following prints nothing:

    mysql -u test -h localhost -ppass test "DROP TABLE idontexist;
        SELECT 'hello';"

An error does not close the session.
Before the session is over, it is possible to retreive the last error message witht the `SHOW WARNINGS` function:

    DROP TABLE idontexist;
    SHOW WARNINGS

Besides the `error` level, mysql logging also represents the warning level, and the note level.
`SHOW WARNINGS` shows the last error, warning or note.

#literal values

##strings

Literal strings can be either single or double quoted:

    SELECT 'abc';
    SELECT "abc";

C-like escape characters such as `\n`, `\t` and `\0` are recognized.

Newlines are included:

    SELECT 'ab
    c';

Output:

    ab\nc

##numeric types

C-like.

Decimal:

    SELECT 123;

Hexadecimal:

    SELECT 0x70;

Is treated as a string in this context and Output:

    p

Floating point:

    SELECT 1.23, 1.23E2;

Output:

    1.23 123

Can only use upper case `E`.

##boolean

    SELECT TRUE, FALSE;

Output:

    1, 0

##null literal

Represents absense of data.

    SELECT NULL;

Ouputs:

    NULL

##literal tables

It seems that it is not possible to directly create literal rows or tables:
<http://stackoverflow.com/questions/985295/can-you-define-literal-tables-in-sql>

#identifiers

Identifiers are names for things like databases or tables.

It is possible to use identifiers with characters other than alphanumeric, `_` or dollar `$`
in the range U+0080 .. U+FFFF only if backticks are used.

For example the following are ok:

    CREATE TABLE `a é 中` (col0 INT);
    CREATE TABLE a_$ (col0 INT);

But the following are not:

    CREATE TABLE a b (col0 INT);
    CREATE TABLE aé (col0 INT);

#mysql db

As soon as you install mysql, a table called `mysql` is created.

This table is special as it contains metadata used by MySQL such as user information,
database metadata, etc.

Be very careful when editing this database directly.

#users

MySQL has the concept of users and permissions analogous to POSIX users and permissions.

Each user/host pair has certain priviledges such as
view, edit, delete databases, tables and entries.

Those permissions may apply either to specific table/database
or to the entire server (global permissions).

By default, a superuser called root is created during server installation.

List users and their *global* priviledges:

    SELECT * FROM mysql.user;

Note that priviledges are given to user/host pairs.

Create a new user with given password:

    CREATE USER 'newuser'@'localhost' IDENTIFIED BY 'password';

this user has no priviledges. He can only log from the `localhost` host.

Create a user on all hosts:

    CREATE USER 'newuser'@'%' IDENTIFIED BY 'password';

Does *not* include UNIX domain connections such is the case for localhost,
but does include all TCP/UDP connections.

Get current user host pair:

    SELECT USER();

Sample output:

    ciro@localhost

Show all global priviledges supported by a server:

    SHOW PRIVILEGES;

View priviledges given for databases to current user:

    SHOW GRANTS;

To a given user:

    SHOW GRANTS FOR user@host;

Give all priviledges to an user:

    GRANT ALL            ON *   .*     TO 'user'@'localhost';

*.* means global priviledges:

On all tables on db `mydb`:

    GRANT ALL            ON mydb.*     TO 'user'@'localhost';
    GRANT SELECT, INSERT ON mydb.*     TO 'user'@'localhost';

Only for table `mydb.mytbl`:

    GRANT ALL            ON mydb.mytbl TO 'user'@'localhost';
    GRANT SELECT, INSERT ON mydb.mytbl TO 'user'@'localhost';

Remove priviledges of an user:

    REVOKE;

Remove users:

    DROP USER user@localhost, user2@localhost;

Change password for an existing user:

    USE MYSQL
    SET PASSWORD FOR 'user-name'@'hostname-name' = PASSWORD('new-password');

Some sources mention that `FLUSH PRIVILEGES` priviledges is needed after `SET PASSWORD`,
but the 5.0 documentataion says that this should be necessary after a `GRANT`, `REVOKE`, or `SET PASSWORD`,
and, only if `INSERT`, `UPDATE` or `DELETE` are used directly.

Also consider using the `mysqladmin` utility for this task if you want to change your own password.

#flush

Flush tells MySQL to load to the mysqld memory metadata that has been modified
in the control table `mysql`, making it take effect.

For example, `INSERT` can be used to modify users and permissions on the `mysql` control database,
but it does take effect in the running mysql instance unless a `FLUSH PRIVILEGES` is done,
which makes the server load this new information and put it into effect.

#database

List all databases:

    SHOW DATABASES;

Create a database named `name`:

    CREATE DATABASE name;

Delete the database named `name`:

    DROP name;

Needless to say, this is a very drastic operation, that could result in large data loss.

View command that would create a database exactly like the given one:

    SHOW CREATE DATABASE test;

Sample output:

    Database	Create Database
    test	CREATE DATABASE `test` /*!40100 DEFAULT CHARSET latin1 */

##use

Choose default database.

After this command is given, database names may be ommited.

Set the current database to `db`:

    USE db;

After this is done, one can write for example:

    SHOW TABLES;

instead of:

    SHOW TABLES IN db;

The same goes for example for using `DESC` on table `db.tbl`:

    DESC db.tbl;

which after `USE` can be writen as:

    DESC tbl;

If a default database is not selected, ommiting the database will produce an error.

Get current default database:

    SELECT DATABASE();

#table

List all tables in current db:

    SHOW TABLES;

List all tables in given db named `db`:

    SHOW TABLES IN db;

##create table

Create a new table with the given columns:

    CREATE TABLE table_name(
        column_name0 INT,
        column_name1 INT
    ) CHARSET='utf8' ENGINE='InnoDB' COMMENT='table comment';
    DROP TABLE table_name;

creates a table with 2 columns.

Table options come after the closing `)`.
The `=` sign is optional, so the following would also do the same:

    CREATE TABLE table_name(
        column_name0 INT,
        column_name1 INT
    ) CHARSET 'utf8' ENGINE 'InnoDB' COMMENT 'table comment';
    DROP TABLE table_name;

It is recommended however that the `=` sign be used to increase readabilty by
making it clearer which key has which value.

It is not possible to create a table with no columns:

    CREATE TABLE table_name;

produces an error.

If a table already exists, creating it again gives an error.
To avoid such errors, it is possible to use the `IF NOT EXISTS` option:

    CREATE TABLE t( c0 INT );
    CREATE TABLE IF NOT EXISTS t( c0 INT );

Creates a new table with same structure as another existing one:

    CREATE TABLE newtable LIKE oldtable;

##drop table

Delete given tables:

    CREATE TABLE t0 (c0 INT);
    CREATE TABLE t1 (c0 INT);
    DROP TABLE t0, t1;
    SHOW TABLES;

The output should contain neither `t0` nor `t1`.

###show create table

Shows the exact command needed to to create a table, including options that depend on defaults
and were not explicitly given at table creation.

    CREATE TABLE t (
        c0 INT(2) NOT NULL AUTO_INCREMENT,
        c1 CHAR(2) UNIQUE DEFAULT 'ab',
        PRIMARY KEY(c0)
    ) ENGINE='InnoDB' CHARSET='utf8' COMMENT='table comment';
    SHOW CREATE TABLE t;
    DROP TABLE t;

Output:

    Table	Create Table
    t	CREATE TABLE `t` (
      `c0` int(2) NOT NULL AUTO_INCREMENT,
      `c1` char(2) DEFAULT 'ab',
      PRIMARY KEY (`c0`),
      UNIQUE KEY `c1` (`c1`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='table comment'

##insert into

Create a new table that contains all or part of the data from an existing table.

##view

TODO

##alter

Modify table and column properties.

Add a new column to an existing table:

    ALTER TABLE contacts ADD new_col_name VARCHAR(60);

Add a column from an existing table:

    ALTER TABLE table_name DROP col_name

Modify column properties:

    CREATE TABLE tbl_name (col_name INT);
    ALTER TABLE tbl_name MODIFY COLUMN col_name INT NOT NULL;
    DESC tbl_name;
    DROP TABLE tbl_name;

Output:

    col_name	int(11)	NO		NULL

Type conversions:

    CREATE TABLE tbl_name (col_name INT);
    INSERT INTO tbl_name VALUES (0), (1), (2);
    ALTER TABLE tbl_name MODIFY COLUMN col_name CHAR(16) NOT NULL;
    SELECT * FROM tbl_name;
    DROP TABLE tbl_name;

##table modifiers

###primary key

Different from `KEY`:

- enforces that there are no duplicates
- implies `NOT NULL`.
- can only be used once (but possibly with multiple columns)

Example:

    CREATE TABLE t (
        id INT,
        val VARCHAR(16),
        PRIMARY KEY (id)
    );
    INSERT INTO t VALUES (1, 'one');
    # ERROR: no dupes
    INSERT INTO t VALUES (1, 'one2');
    # ERROR: cannot be null
    INSERT INTO t VALUES (NULL, 'null');
    SELECT * FROM t;
    DROP TABLE t;

Multiple columns:

    CREATE TABLE t (
        id0 INT,
        id1 INT,
        val VARCHAR(16),
        PRIMARY KEY (id0, id1)
    );
    INSERT INTO t VALUES (1, 1, '11');
    INSERT INTO t VALUES (1, 2, '12');
    INSERT INTO t VALUES (2, 1, '21');
    # ERROR: dupe:
    INSERT INTO t VALUES (2, 1, '212');
    SELECT * FROM t;
    DROP TABLE t;

###foreign key

The row points to rows of another table.

TODO the other table must have a PRIMARY KEY?

###index

TODO how is the index implemented? hashmap? How to CRUD an index?

###index

Same as `KEY`.

###key

Same as `INDEX`.

The only effect of primary key is to help MySQL do certai optimizations.

MySQL does not even enforce the fact that primary keys are unique:
this is usually achieved by making the primary key `AUTO_INCREMENT`.

`KEY` does not imply `NOT NULL`.

For example:

    CREATE TABLE t (
        id INT,
        val VARCHAR(16),
        KEY (id),
        KEY (val)
    );
    INSERT INTO t VALUES (1, 'one');
    INSERT INTO t VALUES (1, 'one2');
    INSERT INTO t VALUES (NULL, 'null');
    SELECT * FROM t;
    DROP TABLE t;

does not generate any errors and happily Output:

    1	one
    1	one2
    NULL	null

It is also common to make the key `NOT NULL`, which makes sense and helps MySQL do certain optimizations.

TODO how does this help optimize?

##engine

Each table has an engine assigned to it.

The engine deterines exactly how data is stored and retreived in the table.

Starting from 5.1, engines can be plugged into a running instance of MySQL without restarting it.

List all available engines and their main capacities:

    SHOW ENGINES;

Sample output (shortened):

    +--------------------+---------+----------------------------------------------------------------+
    | Engine             | Support | Comment                                                        |
    +--------------------+---------+----------------------------------------------------------------+
    | MyISAM             | YES     | MyISAM storage engine                                          |
    | FEDERATED          | NO      | Federated MySQL storage engine                                 |
    | InnoDB             | DEFAULT | Supports transactions, row-level locking, and foreign keys     |
    +--------------------+---------+----------------------------------------------------------------+

    --------------+------+------------+
     Transactions | XA   | Savepoints |
    --------------+------+------------+
     NO           | NO   | NO         |
     NULL         | NULL | NULL       |
     YES          | YES  | YES        |
    --------------+------+------------+

Under `support` we see:

- `YES` the engine is currently supported.
- `NO`  not supported.
- `DEFAULT` the engine is the default one for new tables.

`XA` is a transaction standard by X/Open that is not specific for databases,
but could also be used in other types of systems.

The engine of a table can be specified at creation time via the `ENGINE` table option:

If is possible to retreive the table type via `SHOW CREATE TABLE`;

    CREATE TABLE t(c INT) ENGINE='InnoDB';
    SHOW CREATE TABLE t;
    DROP TABLE t;

#column

##data types

Each column holds a specific data type.

###int types

- `TINYINT`  : 1 byte
- `SMALLINT` : 2 bytes
- `MEDIUMINT`: 3 bytes
- `INT`      : 4 bytes
- `BIGINT`   : 8 bytes

Note that not all of those types are available across all SQL implementations.
`SMALLINT`, `INT` and `BIGINT` are the most portable.

MySQL offers unsiged versions to those types, but this is not SQL portable.

    CREATE TABLE t (
        si SMALLINT,
        i INT,
        bi BIGINT,
        iu SMALLINT UNSIGNED,
    );
    INSERT INTO t VALUES (0x8FFF, 0x8FFFFFFF, 0x8FFFFFFFFFFFFFFF, 0xFFFF);
    SELECT * FROM t;
    DROP TABLE t;

####int overflow

In case of overflow, the server silently stores the largest possible value:

    CREATE TABLE t ( si SMALLINT );
    INSERT INTO t VALUES ( 0x9000 );
    INSERT INTO t VALUES ( 0x8FFF );
    SELECT * FROM t;
    DROP TABLE t;

Output:

    32767
    32767

since `32767 == 0x8FFF` is the largest possible value.

###decimal

Represents decimal fractions precisely unlike floats.

For example, 0.3 cannot be represented precisely with floating point numbers since
its binary representation is infinite.

This is important for example in financial computations, where errors can add up
and make a big difference on the resulting output.

###date

Holds a year / month / day date.

Any punctuation char can be used as input delimiers:

    CREATE TABLE dates (d DATE);
    INSERT INTO dates VALUES ('2001-01-03');
    INSERT INTO dates VALUES ('2001/01/03');
    INSERT INTO dates VALUES ('20010203');
    INSERT INTO dates VALUES ('010127');
    INSERT INTO dates VALUES ('2001+01+03');
    INSERT INTO dates VALUES ('2001_01/03');
    SELECT * FROM dates;
    DROP TABLE dates;

The following are not OK:

    INSERT INTO dates VALUES ('2001a01a03');
    INSERT INTO dates VALUES ('2001 01 03');

The output is always of the form: `YYYY-MM-DD`.

The default valule for a `DATE` row is `NULL`:

    CREATE TABLE t (d DATE, i INT);
    INSERT INTO t (i) VALUES (1);
    SELECT * FROM t;
    DROP TABLE t;

Output:

    NULL	1

Range: `'1000-01-01'` to `'9999-12-31'`.

Bounds checking is not done automatically.

    CREATE TABLE t (d DATE);
    INSERT INTO t VALUES ('1000-01-01');
    INSERT INTO t VALUES ('999-01-01');
    INSERT INTO t VALUES ('10000-01-01');
    INSERT INTO t VALUES ('1000-12-01');
    INSERT INTO t VALUES ('1000-13-01');
    INSERT INTO t VALUES ('1000-01-31');
    INSERT INTO t VALUES ('1000-01-32');
    INSERT INTO t VALUES ('1000-04-30');
    INSERT INTO t VALUES ('1000-04-31');
    INSERT INTO t VALUES ('1000-04-32');
    SELECT * FROM t;
    DROP TABLE t;

Sample output:

    d
    1000-01-01
    0999-01-01
    0000-00-00
    1000-12-01
    0000-00-00
    1000-01-31
    0000-00-00
    1000-04-30
    0000-00-00
    0000-00-00

###datetime

Holds a `YYYY-MM-DD HH:mm:SS` time.

Like for `date`, any punctuation char is acceptable as separator.

    CREATE TABLE t (d DATETIME);
    INSERT INTO t VALUES ('2001-02-03 04:05:06');
    INSERT INTO t VALUES ('2001.02-03?04!05*06');
    SELECT * FROM t;
    DROP TABLE t;

Range: `1000-01-01 00:00:00` to `9999-12-31 23:59:59`.

###timestamp

Vs datetime: <http://stackoverflow.com/questions/409286/datetime-vs-timestamp>

Similar to datetime but:

- much smaller range: `'1970-01-01 00:00:01'` UTC to `'2038-01-09 03:14:07'` UTC
- occupies 4 bytes intead of 8
- is automatically affected by the `TIME_ZONE` variable
-  The default value is the current time, not `NULL` as in `DATE`.
- `UPDATE` updates it to current time.

    CREATE TABLE t (d TIMESTAMP, i INT);
    INSERT INTO t (i) VALUES (1);
    SELECT * FROM t;

wait, and then:

    INSERT INTO t (i) VALUES (2);
    SELECT * FROM t;

wait, and then:

    UPDATE t SET i=i+1;
    SELECT * FROM t;
    DROP TABLE t;

###char and varchar

`CHAR` and `VARCHAR` both store strings of characters in the given column encoding and collation.

`CHAR` and `VARCHAR` store and retreive the strings differently leading to slightly different behaviours
and different time/space performance characteristics.

`CHAR` has range 0 to 255. `VARCHAR` has range 0 to 65,535.

`CHAR` always uses up the same number of characters. If all the entries on a table use the same number of characters,
or almost the same number `CHAR` has two advantages over `VARCHAR`:

- may be slightly faster

- uses slightly less space since `CHAR` requires 1 or 2 bytes per entry to store the length of that entry.

    More precisely, `VARCHAR` requires on extra byte if the length is `255` or less, and 2 bytes if it is 256 or more.

    Note that this is `255` and not `256`, since the `255` already includes
    the 1 length byte so that everything will align nicely to 256 bytes.

`VARCHAR` however, may use less bytes than the maximum to represent each string.

In general, the performance gain of `CHAR` is small, and the flexibility of `VARCHAR` is preferred.
Only use `CHAR` if you are very sure that the size of data will always be the same or almost the same.

Why ever use `CHAR` instead of `VARCHAR`: <http://stackoverflow.com/questions/59667/why-would-i-ever-pick-char-over-varchar-in-sql>

Why ever use `VARCHAR(20)` instead of `VARCHAR(255)` if both will get one extra byte:
<http://stackoverflow.com/questions/262238/are-there-disadvantages-to-using-a-generic-varchar255-for-all-text-based-field>
In MySQL, there is a RAM memory performance difference, so stick with the smallest value possible.

###binary

Similar to `CHAR`, except that the column is not affected by encoding and collation:
bytes are stored as is.

Mostly useful for non-textual data.

###blob and text

`BLOB` and `TEXT` are very similar to `VARBINARY` and `VARCHAR`: <http://stackoverflow.com/questions/2023481/mysql-large-varchar-vs-text>
The main difference is that `TEXT` is stored as a reference to outside the table, while `VARCHAR` is stored inline.
`VARCHAR` may be faster to search since it avoids the dereference, but there are limits to row size.
Prefere `TEXT` when data can be arbitrarily large.

The difference between `BLOB` and `TEXT` is the same as that between `BINARY` and `CHAR`:
`BLOB` stores a string of bytes and has no encoding or collation.

##null

`NULL` can be inserted in place of any value that is not marked `NOT NULL`.

It represents absense of data.

    CREATE TABLE t (a INT, b INT);
    INSERT INTO t VALUES (0, 1);
    INSERT INTO t VALUES (0, NULL);
    SELECT * FROM t;
    DROP TABLE t;

Some functions and `NULL`:

    SELECT NULL + 0;

Output:

    NULL

Equality might not give what you want:

    SELECT NULL = NULL;

Output:

    NULL

Use the `IS NULL` operator instead:

    SELECT NULL IS NULL;

Output:

    1

##type conversion

TODO what happens here:

    CREATE TABLE t (a INT);
    INSERT INTO t VALUES ('abc');
    SELECT * FROM t;
    DROP TABLE t;

##column constraints

Besides the data type, each column may have one or more of several modifiers.

###not null

With `NOT NULL`, attempt to insert `NULL` given an error:

    CREATE TABLE t (a INT NOT NULL);
    INSERT INTO t VALUES (NULL);
    SELECT * FROM t;
    DROP TABLE t;

Output:

    ERROR 1048 (23000): Column 'a' cannot be null

###unique

Enforces that a given key is unique.

    CREATE TABLE t (a INT UNIQUE, b INT);
    INSERT INTO t VALUES (0, 0), (1, 0);
    INSERT INTO t VALUES (0, 1);
    SELECT * FROM t;
    DROP TABLE t;

Output:

    ERROR 1062 (23000): Duplicate entry '0' for key 'a'
    0	0
    1	0

###default

    CREATE TABLE t (a INT, b INT DEFAULT -1);
    INSERT INTO t VALUES (0, 1);
    INSERT INTO t VALUES (0, DEFAULT);
    INSERT INTO t VALUES (DEFAULT(b), 0);
    INSERT INTO t VALUES (DEFAULT(a), 0);
    # error:
    # error:
    #INSERT INTO t VALUES (0);
    INSERT INTO t (a) VALUES (0);
    SELECT * FROM t;
    DROP TABLE t;

Note that:

- `DEFAULT` is the default value for the current column. It is mandatory on the ordered mode.
- `DEFAULT(col_name)` is the default value for the current column.

    It is mandatory on the list form, but not on the dictionary form.

    INT columsn have a default `NULL` value if none is explicitly set.

It seems that the default for a `DATETIME` row cannot be `NOW()`:
<http://stackoverflow.com/questions/5818423/set-now-as-default-value-for-datetime-datatype>

Default can be a function:

    CREATE TABLE t (d DATETIME DEFAULT NOW());
    INSERT INTO t VALUES (DEFAULT);
    INSERT INTO t VALUES (DEFAULT);
    SELECT * FROM t;
    DROP TABLE t;

###check

Gets parsed, but is ignored since it is not implemented!

Enforces certain conditions on rows.

    CREATE TABLE t (
        a INT,
        b INT,
        CHECK (a + b < 3)
    );
    INSERT INTO t VALUES (0, 1);
    INSERT INTO t VALUES (1, 1);
    INSERT INTO t VALUES (2, 0);
    INSERT INTO t VALUES (3, -1);
    # should be error if it were implemented:
    INSERT INTO t VALUES (4, 0);
    SELECT * FROM t;
    DROP TABLE t;

###auto_increment

The value of the column is always generated by MySQL by incrementing the last value.

Count starts at `1`.

Major application: primary keys.

    CREATE TABLE t (
        id INT AUTO_INCREMENT,
        val VARCHAR(16),
        KEY (id)
    );
    INSERT INTO t (val) VALUES ('one'), ('two'), ('three');
    SELECT * FROM t;
    DROP TABLE t;

The `AUTO_INCREMENT` column must be a `KEY`, otherwise error:

    CREATE TABLE t (
        id INT AUTO_INCREMENT,
        val VARCHAR(16),
    );

Auto increment starts from the last largest value on the column.

    CREATE TABLE t (
        id INT AUTO_INCREMENT,
        val VARCHAR(16),
        KEY (id)
    );
    INSERT INTO t VALUES (2, 'two');
    INSERT INTO t (val) VALUES ('three'), ('four');
    INSERT INTO t VALUES (6, 'six');
    INSERT INTO t (val) VALUES ('seven'), ('eight');
    SELECT * FROM t;
    DROP TABLE t;

It is possible to explicitly tell `AUTO_INCREMENT` where to start:

    CREATE TABLE t (
        id INT AUTO_INCREMENT,
        val VARCHAR(16),
        KEY (id)
    ) AUTO_INCREMENT=3;
    INSERT INTO t (val) VALUES ('three'), ('four'), ('five');
    SELECT * FROM t;
    DROP TABLE t;

Output:

    3	three
    4	four
    5	five

If another larger value is inserted, it will be used instead of the one given to `AUTO_INCREMENT`

    CREATE TABLE t (
        id INT AUTO_INCREMENT,
        val VARCHAR(16),
        KEY (id)
    ) AUTO_INCREMENT=3;
    INSERT INTO t VALUES (4, 'four');
    INSERT INTO t (val) VALUES ('five'), ('six');
    SELECT * FROM t;
    DROP TABLE t;

Output:

    4	four
    5	five
    6	six

output:

    2	two
    3	three
    4	four
    6	six
    7	seven
    8	eight

###zerofill

Controls how numbers will be output.

    CREATE TABLE t (i INT, i0 INT(4) ZEROFILL);
    INSERT INTO t VALUES (12, 12);
    INSERT INTO t VALUES (123456, 123456);
    SELECT * FROM t;
    DROP TABLE t;

Output:

    12	0012
    123456	123456

The `(4)` mens that the minimum output width is `4`.

The difference of using it can only be noticed if `ZEROFILL` is set for the column.

Floating point types have two display parmeters: minimum width (inluding point and decimals)
and number of decimal cases:

    CREATE TABLE t (f FLOAT, f0 FLOAT(10, 2) ZEROFILL);
    INSERT INTO t VALUES (12.3456, 12.3456);
    SELECT * FROM t;
    DROP TABLE t;

##get column description

###show columns from

See `desc`.

###describe

See `desc`.

###desc

Same as `SHOW COLUMNS FROM` and `DESCRIBE`.

Get short description of all columns of a table.

    CREATE TABLE t (
        c0 INT(2) NOT NULL AUTO_INCREMENT,
        c1 CHAR(2) UNIQUE DEFAULT 'ab',
        PRIMARY KEY(c0)
    );
    DESC t;
    DROP TABLE t;

Output:

    +-------+---------+------+-----+---------+----------------+
    | Field | Type    | Null | Key | Default | Extra          |
    +-------+---------+------+-----+---------+----------------+
    | c0    | int(2)  | NO   | PRI | NULL    | auto_increment |
    | c1    | char(2) | YES  | UNI | ab      |                |
    +-------+---------+------+-----+---------+----------------+

###show full columns

Get more info than `DESC` including:

- column collation
- privileges
- comment

    CREATE TABLE t (
        c0 INT(2) NOT NULL AUTO_INCREMENT COMMENT 'my comment!',
        c1 CHAR(2) UNIQUE DEFAULT 'ab',
        PRIMARY KEY(c0)
    );
    SHOW FULL COLUMNS FROM t;
    DROP TABLE t;

Sample output:

    +-------+---------+-------------------+------+-----+
    | Field | Type    | Collation         | Null | Key |
    +-------+---------+-------------------+------+-----+
    | c0    | int(2)  | NULL              | NO   | PRI |
    | c1    | char(2) | latin1_swedish_ci | YES  | UNI |
    +-------+---------+-------------------+------+-----+

    ---------+----------------+---------------------------------+-------------+
     Default | Extra          | Privileges                      | Comment     |
    ---------+----------------+---------------------------------+-------------+
     NULL    | auto_increment | select,insert,update,references | my comment! |
     ab      |                | select,insert,update,references |             |
    ---------+----------------+---------------------------------+-------------+

##character set

See `charset`.

##charset

The encoding to use for text columns such as `CHAR` columns.

Does not apply to other types of columns such as `INT` or `DATE`.

Each column may have a different encoding. It is possible to set default charactersets
for databases and tables, which are then used for columns if not explicitly overridden.

Unless you are absolutely sure that the database will contain only ASCII characters
(for example it will not contain a natural language), make all databases UTF8.
Do this even if the database is intended to be English only,
since even in English contexts it may be useful to use non-ASCII characters.

List all possible character sets:

    SHOW CHARSET;

Use default UTF8 charset on a database. Default in 5.5 is `latin1`.

    CREATE DATABASE name CHARSET utf8;

`DEFAULT` is optional:

    CREATE DATABASE name DEFAULT CHARSET utf8;

Use default UTF8 charset on a table:

    CREATE TABLE t (
        c0 CHAR(1),
        c1 CHAR(1) CHARSET ascii
    ) CHARSET utf8;
    SHOW FULL COLUMNS FROM t;
    DROP TABLE t;

View default charset for given db/table/column:

<http://stackoverflow.com/questions/1049728/how-do-i-see-what-character-set-a-database-table-column-is-in-mysql>

##collation

Collation determines how strings in a given charset are compared for equal, smaller, larger.

Like `CHARSET`, each column has its own collation, and defaults can be set for databases and tables.

Examples: case sensitive, case insensitive, Uppercase comes first (ABC...abc)

View all possible collations for each charset:

    SHOW COLLATION;


##column limitations

Length.

There are length limitation on *row* size (sum of all columns).

2**16-1 = 8k-1

This means 8k-1/256 = 85 CHAR(256) fields are permitted.

TEXT field not stored on the table: each occupies up to 12 bytes on their row.

Copies data from old table to new table:

    INSERT INTO $newtable SELECT * FROM $oldtable;

#rows

##insert

Insert one or more rows into a table.

    CREATE TABLE t (
        i INT,
        v VARCHAR(16)
    );

Insert into the same order as parameters given:

    INSERT INTO t VALUES (1, 'ab');

Insert into serveral at once:

    INSERT INTO t VALUES (1, 'ab'), (2, 'bc');

The number of columns must match. The following produces an error:

    INSERT INTO t VALUES (1);

If no data is present, one solution is to use `NULL`:

    INSERT INTO t VALUES (1, NULL);

Specify order by row name:

    INSERT INTO t (v, i) VALUES ('cd', 2);

##update

Modify the selected rows.

Modify all rows:

    CREATE TABLE t (c0 INT, c1 INT);
    INSERT INTO t VALUES (1, 1), (2, 4), (3, 9);
    UPDATE t SET c1=c1+1;
    SELECT * FROM t;
    DROP TABLE t;

Output:

    1	2
    2	5
    3	10

Select certain rows to update with `WHERE`:

    CREATE TABLE t (c0 INT, c1 INT);
    INSERT INTO t VALUES (1, 1), (2, 4), (3, 9);
    UPDATE t SET c1=c1+1 WHERE c0<3;
    SELECT * FROM t;
    DROP TABLE t;

Output:

    1	2
    2	5
    3	9

##delete

Delete selected rows.

Delete all rows:

    CREATE TABLE t (c0 INT, c1 INT);
    INSERT INTO t VALUES (1, 1), (2, 4), (3, 9);
    DELETE FROM t;
    SELECT * FROM t;
    DROP TABLE t;

outputs nothing.

Delete selected rows:

    CREATE TABLE t (c0 INT, c1 INT);
    INSERT INTO t VALUES (1, 1), (2, 4), (3, 9);
    DELETE FROM t WHERE c0=3;
    SELECT * FROM t;
    DROP TABLE t;

Output:

    1	1
    2	4

##truncate

Removes all entries from a table:

    TRUNCATE TABLE table_name;

Similar to `DELETE FROM table_name`, but with some subtle differences,
in particular a possible performance gain, since TRUNCATE actually drops and recreates the table.

##select

Choose certain table columns to take further actions on them.
Returns chosen columns.

Print all data of column `col` of table `table`:

    SELECT COLUMN col FROM table;

Print all data of columns `col0` and `col1` of table `table`:

    SELECT col0,col1 FROM table;

Show entire table `table`:

    SELECT * FROM table;

###generate a column that is a function of other columns

It is possible generate a selection that is a function of the row values:

    CREATE TABLE t (c0 INT, c1 INT);
    INSERT INTO t VALUES (0, 0), (0, 1), (1, 2), (-1, 3);
    SELECT c0, c0 + c1, c0 FROM t;
    DROP TABLE t;

Output:

    +------+---------+------+
    | c0   | c0 + c1 | c0   |
    +------+---------+------+
    |    0 |       0 |    0 |
    |    0 |       1 |    0 |
    |    1 |       3 |    1 |
    |   -1 |       2 |   -1 |
    +------+---------+------+

###single values

Besides selecting rows from columns, `SELECT` can also select single values
or expressions.

These are treated as if they were rows with the same name as the input expression.

    SELECT 1;
    SELECT 1 + 1;

Output

    +---+
    | 1 |
    +---+
    | 1 |
    +---+

    +-------+
    | 1 + 1 |
    +-------+
    |     2 |
    +-------+

It is also possible to generate multiple rows as:

    SELECT 1 2

Output:

    +---+---+
    | 1 | 2 |
    +---+---+
    | 1 | 2 |
    +---+---+

###where

Filter only certain rows.

Any function or operator that returns a boolean can be used by substituting
the value of the row by its name (`c0`, `c1`, etc.):

It is not possible to refer to a column that have be created in the query
via `AS` or an aggregate function on the same command as in `(1)` and `(2)`.

    CREATE TABLE t (c0 INT, c1 INT);
    INSERT INTO t VALUES (0, 0), (0, 1), (1, 0), (2, 0);
    SELECT * FROM t WHERE c0 = 0;
    SELECT * FROM t WHERE c0 <> 0;
    SELECT * FROM t WHERE c0 BETWEEN 0 AND 1;
    SELECT * FROM t WHERE c0 IN(0, 2);
    SELECT * FROM t WHERE c0 > 0 AND C0 < 2;
    SELECT * FROM t WHERE c0 > 0 AND NOT (C0 > 2);
    SELECT * FROM t WHERE c0 = 0 OR c0 = 2;
    SELECT c0+c1 AS sum FROM t WHERE sum > 0;     #(1)
    SELECT c0+c1        FROM t WHERE `c0+c1` > 0; #(2)
    DROP TABLE t;

It would of course be possible to get all the results and then filter them using
a programming language, but the list of all results might be too long.

###order by

Order select output by one or more columns.

    CREATE TABLE t (c0 INT, c1 INT);
    INSERT INTO t VALUES (0, 1), (0, 0), (1, 1), (2, 0);
    SELECT * FROM t ORDER BY c0;
    SELECT * FROM t ORDER BY c0,c1;
    SELECT c0 + c1 AS sum FROM t ORDER BY sum;
    DROP TABLE t;

Output:

    c0	c1
    0	1
    0	0
    1	1
    2	0

    c0	c1
    0	0
    0	1
    1	1
    2	0

    sum
    0
    1
    2
    2

###limit

Limit the number of outputs.

    CREATE TABLE t (c0 INT);
    INSERT INTO t VALUES (0), (1), (2);
    SELECT * FROM t LIMIT 1;
    SELECT * FROM t LIMIT 2;
    DROP TABLE t;

Output:

    0

    0
    1

###distinct

Only show each value of a column tuple once:

    CREATE TABLE t (c0 INT, c1 INT);
    INSERT INTO t VALUES (0, 0), (0, 1), (1, 0), (1, 0);
    SELECT DISTINCT c0 FROM t;
    SELECT DISTINCT c0,c1 FROM t;
    SELECT DISTINCT *     FROM t;
    DROP TABLE t;

Output:

    0
    1

    0	0
    0	1
    1	0

If you want to use `DISTINCT` but also retrieve the entire table, try `GROUP BY`.

`SELECT DISTINCT` is applied after aggregate functions,
so you probably don't to use them together.

The best solution is to use the `DISTICT` form of the aggregate function `SUM(DISTINCT )`,
but it is also possible to have a subquery solution as in `(1)`

    CREATE TABLE t (c0 INT, c1 INT);
    INSERT INTO t VALUES (0, 0), (0, 1), (1, 0), (1, 0);
    SELECT DISTINCT SUM(c0) FROM t;
    SELECT SUM(DISTINCT c0) FROM t;
    SELECT SUM(t2.c0) FROM (SELECT DISTINCT c0 FROM t) AS t2;   #(1)
    DROP TABLE t;

Output:

    SUM(c0)
    2

    SUM(DISTINCT c0)
    1

    SUM(t2.c0)
    1

###subquery

Select can also work on query results output from other commands such as other `SELECT` or `UNION`.

`WHERE` + `IN`:

    CREATE TABLE t (c0 INT);
    INSERT INTO t VALUES (0), (1), (2);
    SELECT * FROM t WHERE c0 < 2 AND c0 IN (
        SELECT * FROM t WHERE c0 > 0
    );
    DROP TABLE t;

It is possible to avoid the usage of `WHERE` if `AS t2` is used as follows:

    CREATE TABLE t (c0 INT, c1 INT);
    INSERT INTO t VALUES (1, 1), (2, 4), (3, 9);
    SELECT MAX(c0) FROM (
        SELECT c0 FROM t
    ) AS t2;
    DROP TABLE t;

It is mandatory to rename the subquery as something using `AS` or else this produces an error.

`WHERE` + `MAX` to get the row where a given value is maximum:

    CREATE TABLE t (c0 INT, c1 INT);
    INSERT INTO t VALUES (1, 1), (2, 4), (3, 9);
    SELECT * FROM t WHERE c0 = (
        SELECT MAX(c0) FROM t
    );
    DROP TABLE t;

###as

Rename output columns and subquery tables.

    SELECT 1 AS one, 2 AS two;

Output:

    +-----+-----+
    | one | two |
    +-----+-----+
    |   1 |   2 |
    +-----+-----+

The as keyword is not mandatory, but is considered by the manual itself to be better style.

    SELECT 1 one, 2 two;

Output:

    +-----+-----+
    | one | two |
    +-----+-----+
    |   1 |   2 |
    +-----+-----+

Get the maximum sum of all rows:

    CREATE TABLE t (c0 INT, c1 INT);
    INSERT INTO t VALUES (1, 1), (2, 4), (3, 9);
    SELECT MAX(sum) FROM (
        SELECT c0 + c1 AS sum FROM t WHERE c0 > 0
    ) AS t2;
    DROP TABLE t;

Note how the subquery has a row called `sum` which is referred to at `MAX(sum)`,
and the subquery table is called `t2` (naming it is mandatory here).

The above example is not the best way to achieve this task since
`MAX(c0 + c1)` would work too.

It would also be possible to do the same via:

    CREATE TABLE t (c0 INT, c1 INT);
    INSERT INTO t VALUES (1, 1), (2, 4), (3, 9);
    SELECT MAX(`c0+ c1`) FROM (
        SELECT c0+ c1 FROM t WHERE c0 > 0
    ) AS t2;
    DROP TABLE t;

but that would be bad since it duplicates code.

###group by

Select all rows, but only show one netry per distinct column value.

    CREATE TABLE t (c0 CHAR(1), c1 INT);
    INSERT INTO t VALUES ('a', 1), ('a', 2), ('b', 3), ('b', 3);
    SELECT * FROM t GROUP BY c0;
    SELECT * FROM t GROUP BY c1;
    SELECT * FROM t GROUP BY c0,c1; #TODO what happens on this one? same as above?
    DROP TABLE t;

Output:

    a	1
    b	3

    a	1
    a	2
    b	3

    a	1
    a	2
    b	3

With aggregate functions the behaviour is different.
The aggregate is calculated once on each row of unique values.

    CREATE TABLE t (c0 CHAR(1), c1 INT);
    INSERT INTO t VALUES ('a', 1), ('a', 2), ('b', 3), ('b', 3);
    SELECT c0, SUM(c1) FROM t GROUP BY c0;
    DROP TABLE t;

Output:

    c0	SUM(c1)
    a	3
    b	6

###having

What `HAVING` does is simliar to `WHERE`, but:

- `HAVING` can refer to columns generated via `AS` or aggregate functions.

        CREATE TABLE t (c0 INT, c1 INT);
        INSERT INTO t VALUES (1, 1), (2, 4), (3, 9);
        SELECT c0+c1 AS sum FROM t HAVING sum > 3;
        DROP TABLE t;

    Output:

        sum
        6
        12

- `HAVING` is applied after `GROUP BY` while `WHERE` is applied before.

        CREATE TABLE t (c0 CHAR(1), c1 INT);
        INSERT INTO t VALUES ('a', 1), ('a', 2), ('b', 3), ('b', 3);
        SELECT c0, SUM(c1) AS sum FROM t GROUP BY c0 HAVING sum > 4;
        DROP TABLE t;

    Output:

        c0	sum
        b	6

#variables

##server system variables

Variables that affect the operation of the server.

##show variables

List variables and their values.

List all current SSVs:

    SHOW VARIABLES;

List all current SSVs that match a given mysql regexp:

    SHOW VARIABLES LIKE "%version%";

Fileter SSVs by any method accepted by `WHERE`:

    SHOW VARIABLES WHERE Variable_name LIKE "%version%";

`WHERE` operates on a table of type:

    Variable_name	Value

This method is more general and verbose than using `LIKE`.

##set variables

The `SET` command may be used to set the values of variables.

Note that `SET` can also appear on other contexts such as `SET PASSWORD`,
which have no relation to variables.

##variable types

Table of all server system variables: <http://dev.mysql.com/doc/refman/4.1/en/server-system-variables.html>

On that tables, variables have different properties:

- `Cmd-Line`: variable can be set from command line when starting `mysqld`.

- `Option file`: variable can be set from a configuration file

- `System Var`: TODO

- `Var Scope`: Session, global or both.

    Each variable can have one or two versions:

    - session: a version of the variable which affect the current session only.

        Those variables can be accessed and modified via `SHOW VARIABLES` and `SET`.

    - global:  a version of the variable that is the same across the server.

        Those variables can be accessed and modified via `SHOW GLOBAL VARIABLES` and `SET GLOBAL`.

        Since those variables affect the behaviour of the entire server,
        modifying them requires the `super` privilege, and they are intended to modify
        server operation without restarting it.

    Some variables can exist in both global and session versions.

    The session version takes precedence over the global version.

- `Dynamic`: If yes, the variables can be modified at runtime and take effect immediately.

    Attempting to modify non-dynamic variables results in an error. Example:

        set proxy_user := 'asdf';

Variables that control the server configuration.

Those variables are set at startup depending on how `mysqld` is compiled and configured,
but from 4.0.3 onwards they can also be modified without restarting the server via `SET` commands.

List `mysqld` variables and values after reading the configuration files:

    mysqld --verbose --help

##user-defined variable

User defined variables are variables defined by clients on the server,
which last only until the end of the current session.

User defined variables must be prefixed by the at sign `@`.

A user defined variable can be defined either via a `SET` command or inside another command.

Both `:=` and `=` are equivalent if `SET` is used. In other cases, such in a `SELECT`, `:=` is mandatory.

Example:

    SELECT @v1, @v2;
    SET @v1 := 1, @v2 = 2;
    SELECT @v1, @v2;
    SELECT @v1 := 2, @v2 = 2;
    SELECT @v1, @v2;

Output:

    @v1	@v2
    2	2

    @v1	@v2
    1	2

    @v1 := 2	@v2 = 2
    2	1

    @v1	@v2
    2	2

Note how `SELECT @v1 := 2, @v2 = 2;` only changes the value of `@v1`,
while all that the second part of the statment does is to compare `@v2` to `2`.

#functions and operators

Be aware that the presence of `NULL` can create many exceptions
on the expected behaviour of functions.

##arithmetic operators

Basically C like:

    SELECT 1 + 1

Output:

    2

##in

    SELECT 0 IN(0, 2);
    SELECT 1 IN(0, 2);
    SELECT 2 IN(0, 2);

Output:

    1
    0
    1

##between

    SELECT 0 BETWEEN 0 AND 2;
    SELECT 1 BETWEEN 0 AND 2;
    SELECT 2 BETWEEN 0 AND 2;
    SELECT 3 BETWEEN 0 AND 2;

Output:

    1
    1
    1
    0

##like

Simple regex:

- `%` is PERL `.*`
- `_` is PERL `.`

`\%` and `\_` escape.

    SELECT 'a'    LIKE 'ab';
    SELECT 'ac'   LIKE 'a%c';
    SELECT 'abc'  LIKE 'a%c';
    SELECT 'abbc' LIKE 'a%c';
    SELECT 'ac'   LIKE 'a_c';
    SELECT 'abc'  LIKE 'a_c';

Output:

    0
    1
    1
    1
    0
    1

##regexp

Similar to `LIKE` but uses Perl-like regexps, so it is much more powerful.

    SELECT 'a'   REGEXP 'ab';
    SELECT 'abc' REGEXP '^a.(c|d)$';

Output:

    0
    1

##aggregate function

Aggregate functions are function that operate on entire (subquery) columns instead of individual values.

###sum

Sum of a column.

It is possible to use any function of the input row such as `c0 * c1`.

It is possible to make two aggregate function queries on the same `SELECT` as in
`(1)`, but making a non-aggregate function query with
an aggregate function query only shows the first non aggregate output as in `(2)`,
which is probably not what you want.

`WHERE` is aplied before aggregate functions,
and selects which rows will be used for the calculation of the aggregate.

    CREATE TABLE t (c0 INT, c1 INT);
    INSERT INTO t VALUES (1, 1), (2, 4), (3, 9);
    SELECT SUM(c0) FROM t;
    SELECT SUM(c1) FROM t;
    SELECT SUM(c0 * c1) FROM t;
    SELECT SUM(c0 + c1) AS name FROM t;
    SELECT MAX(c0), SUM(c0) FROM t;     #(1)
    SELECT MAX(c0) + SUM(c0) FROM t;
    SELECT c0, SUM(c0) FROM t;          #(2)
    SELECT SUM(c0) FROM t WHERE c0 > 1;
    DROP TABLE t;

Output:

    SUM(c0)
    6

    SUM(c1)
    14

    SUM(c0 * c1)
    36

    name
    20

    MAX(c0)	SUM(c0)
    3	6

    MAX(c0) + SUM(c0)
    9

    c0	SUM(c0)
    1	6

    c0	SUM(c0)
    1	5

###max

Maximum value of a column.

    CREATE TABLE t (c0 INT, c1 INT);
    INSERT INTO t VALUES (1, 9), (2, 4), (3, 1);
    SELECT MAX(c0) FROM t;
    SELECT MAX(c1) FROM t;
    DROP TABLE t;

Output:

    3
    9

###avg

Average value of a column.

    CREATE TABLE t (c0 INT, c1 INT);
    INSERT INTO t VALUES (1, 1), (2, 4), (3, 9);
    SELECT AVG(c0) FROM t;
    SELECT AVG(c1) FROM t;
    DROP TABLE t;

Output:

    2.0000
    4.6667

###count

Return the number of non `NULL` entries of a column.

`COUNT(*)` counts the total number of entries of a table,
including entries that only contain `NULL` values.

    CREATE TABLE t (c0 INT, c1 INT);
    INSERT INTO t VALUES (0, 0), (1, NULL), (NULL, NULL);
    SELECT COUNT(c0) FROM t;
    SELECT COUNT(c1) FROM t;
    SELECT COUNT(*) FROM t;
    DROP TABLE t;

Output:

    2
    1
    3

###exists

Takes a subquery and returns `TRUE` iff that subquery has at least one row,
even if all its values are `NULL`.

    CREATE TABLE t(c0 INT);
    SELECT EXISTS( SELECT * FROM t );
    INSERT INTO t VALUES (NULL);
    SELECT EXISTS( SELECT * FROM t );
    DROP TABLE t;

Output:

    0
    1

#database file format

MySQL allows to use the file format exemplified in `./tbl.txt` to represent tables.

    CREATE TABLE t (i INT, v VARCHAR(4), d DATE);
    LOAD DATA LOCAL INFILE './tbl.txt' INTO TABLE t;
    SELECT * FROM t;
    DROP TABLE t;

This may fail if MySQL is not configured to allow access to local files.

Note how:

- `\N` represents `NULL`.
- `\n` and other escapes are interpreted as a newlines.
- `\\` myst be escaped to be a newline.

#transaction

Sometimes many queries are part of a single logical step, and if one of the queries fails,
then what we want to do is to rollback to the state before the initial step.
This is the function of transaction commmands.

TODO

#locks

Synchronization method

    LOCK TABLES table1 READ, table2 WRITE;

From now on, it is not possible to read from table1 or write to table2
use before making big db changes.

Release all locks:

    UNLOCK TABLES;

#sources

- <http://dev.mysql.com/doc/>

    The official docs.

    The official tutorial is too short and incomplete.

    The documentation in general is very good.

- <http://www.tutorialspoint.com/mysql/index.htm>

    Quite complete tutorial. Also suitable for beginners.

- <http://www.w3schools.com/sql/>

    A bit too simple, but good to start with.

- <http://www.pantz.org/software/mysql/mysqlcommands.html>

    Good way to get started.
