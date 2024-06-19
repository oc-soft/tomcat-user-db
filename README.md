# Usage

Simple command line based tools for tomcat realm.

## prerequisite

You need to create user and database for tomcat realm.

## create tomcat user table

You will have tables.sql in scripts directory for table generation script.

```
$ bash tools/dbscript-gen.sh
```

You will have tables for tomcat realm in Mariadb (MySql) database.

```
$ maradb -u YourAccount -p

MariaDB > use YourDB;
MariaDB [YourDB] > source scripts/tables.sql
```


## fill accont and roles


### fill user password table
You have users.csv.plain source under the config directory.

```
tom tomcat_user_pw1
cat catpassword
```

You genreate config/users.csv from users.csv.plain source

```
$ bash tools/userdata-gen -t 'Your $CATANIAN_HOME'
```

Now you had config/users.csv.
You fill tables with config/users.csv.

```
$ maradb -u YourAccount -p

MariaDB > use YourDB;
MariaDB [YourDB] > load data local infile config/usres.csv replace into uesrs;
```

### fill user roles table

You have user_roles.csv source under the config directory.

```
tom	manager-gui
cat	manager-script
tom	manager-jvm
```

You fill tables with config/user_roles.csv.

```
$ maradb -u YourAccount -p

MariaDB > use YourDB;
MariaDB [YourDB] > load data local infile config/user_roles.csv 
```
