##souces

  #best way to get started: <http://www.w3schools.com/sql/>
  #<http://www.pantz.org/software/mysql/mysqlcommands.html >

##intro

  #mysql is a database that runs on a server.
  
  #this means that requests are made to the server,
  #and the server returns responses.
  
  #to install the sever see <#mysql server>.

##mysql server

  sudo aptitude install -y mysql-server

    #he will ask you for the password, fill it in
    #mysql -u root #the tutorial said do that, but I didn't need to. This would be for the password.

  #configuration file:
    less /etc/mysql/my.cnf
  #contains info such as: listen port, ...

##interfaces
  
  ##mysql command

    #the `mysql` executable is a simple text based interface to mysql

    #it is bad to view tables that don't fit into the terminal width.

    #one advantage of this interface is the possibilty for automation
    #using bash. 
  
  ##phpmyadmin

    #popular php based broser interface for mysql
    
    #first make sure that php is installed. See <#php>.

    sudo aptitude install -y libapache2-mod-auth-mysql php5-mysql phpmyadmin
    #gksudo gedit /etc/php5/apache2/php.ini
      #according to tutorial, should uncomment ;extension=mysql.so, but I could not find it in the file. still works.

    sudo vim /etc/apache2/apache2.conf
    #ensure following line is anywhere in the file:
      #Include /etc/phpmyadmin/apache.conf
    sudo service apache2 restart

  #test phpmyadmin and mysql:
    firefox http://localhost/phpmyadmin &
  #login: 'root'. password: what you entered at installation.

##users

  #mysql has the concept of user permissions.

  #each user/host pair has certain priviledges such as
  #view, edit, delete databases, tables and entries.

  #those permissions may apply either to specific table/database
  #or to the entire server (global permissions)
  
  #by default, a superuser called root is created during server installation.
  
  ##login

    #logs in as user root
    #and prompts for password:
      mysql -u root -p

    #execute command and exit:
      mysql -u root -p -e "create database test;"

    #BAD: unsafe. Logs in without prompting password:
      mysql -u root -p"pass"
    #there must be no space between `-p` and `pass`

    #change password for an existing user:
      mysqladmin -u root -p password
    #prompts for old and new password

  #list users and their *global* priviledges:
    select * from mysql.user;
  #note how priviledges are given to user/host pairs.

  #create a new user:
    CREATE USER 'newuser'@'localhost' IDENTIFIED BY 'password';
  #this user has no priviledges
  
  #show all global priviledges supported by a server:
    SHOW PRIVILEGES;
  
  #view priviledges given for databases:
    SHOW GRANTS;
      #to current user:
    SHOW GRANTS FOR user@host;
      #to user:

  #give priviledges to an user:
    #*.* implies global priviledges:
    GRANT ALL            ON *   .*     TO 'user'@'localhost';
    #all tables on a mydb:
    GRANT ALL            ON mydb.*     TO 'user'@'localhost';
    GRANT SELECT, INSERT ON mydb.*     TO 'user'@'localhost';
    #only for table mydb.mytbl:
    GRANT ALL            ON mydb.mytbl TO 'user'@'localhost';
    GRANT SELECT, INSERT ON mydb.mytbl TO 'user'@'localhost';
    #                       ^^^^ ^^^^^                      
    #                       1    2                          
    FLUSH PRIVILEGES;
  #1: on which databases
  #2: on which tables of those databases

  #remove priviledges of an user:
    REVOKE

  #remove users:
    DROP USER user@localhost, user2@localhost

##commands

  ##databases

    #list databases:
      show databases

    #create databases:
      create database
      create database elearn_trac character set utf8;
        #utf8 charset. default is ascii.
    
    ##charset and collation
    
      ##charset

        #view all possible charsets:
          show character set;

        #view charset for given db/table/column:
          #<http://stackoverflow.com/questions/1049728/how-do-i-see-what-character-set-a-database-table-column-is-in-mysql>

      ##collation

        #is how strings in a given charset are compared for equal, smaller, larger.
        
        #may be set for entire database, tables or individual columns
        
        #examples: case sensitive, case insensitive, Uppercase comes first (ABC...abc)
        #same order: (AaBbCc...), etc.
      
        #view all possible collations for each charset
          show collation;

    #use a database:
      use db
    #necessary before most table operations
    
    #list tables of a database:
      show tables in db
      show tables
        #for current db

    #delete a database:
      drop db

  ##tables

    #get table description:
      desc tbl;

    #get more info on table:
      show create tbl
    #shows each step used to create it

    #creates a new table:

    #creates a new table with same structure as old one:
      CREATE TABLE newtable LIKE $oldtable

    #delete tables:
      drop table table1, table2;

    #copies data from old table to new table
      INSERT INTO $newtable SELECT * FROM $oldtable

    #removes all entries from a table
      TRUNCATE TABLE $tablename
    #faster than 

    #deletes entire table data. difference from truncate?
      DELETE FROM $table;

    ##select

      #choose certain entries to do actions on them

      #chose a column:
        select column from table

      #chose many columns
        select column1, column2 from table

      #unique entries:
        select distinct column from table
      #only shows each value of column once

      #chose all column:
        select * from table

    ##locks

      #synchronization method

        LOCK TABLES `$table1` READ; `$table2` WRITE;
        #cannot read from table1 and write to table2
        #use before making big db changes

        UNLOCK TABLES
        #releases all locks

##column types

  #length
  #there are length limitation on *row* size (sum of all columns)
    #2**16-1 = 8k-1
    #this means 8k-1/256 = 85 CHAR(256) fields are permitted
    #TEXT field not stored on the table: each occupies up to 12 bytes on their row

##dump (save to file)

  mysqldump -u root "$DB_NAME" > bak.sql
  mysqldump -u root "$DB_NAME" "$TABLE1" "$TABLE2" > bak.sql
  #dump to file
  #no USE
  #drops existing

  mysqldump -u root --databases "$DB1" "$DB2" > bak.sql
  #mutiple dbs
  #creates dbs with old names, uses them

  mysqldump -u root --all-databases > bak.sql
  #all dbs
  #with USE, old names

  # -d : no data
  # --no-create-info : data only

###restore

  PASS=
  mysql-u root -p"$PASS" < bak.sql
  #make sure the db exists/you want to overwrite it

  DB=
  DB2=
  PASS=
  mysql -u root -p"$PASS" -e "create database $DB2;"
  mysqldump -u root -p"$PASS" $DB | mysql -u root -p"$PASS" $DB2
  #make sure the db exists/you want to overwrite it
  #copy db to new name
