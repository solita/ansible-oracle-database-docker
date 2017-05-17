# ansible-oracle-database-docker
Creates Oracle Database Enterprise Edition 12.1 platform on Docker (for dev environments, only testing porpose).

## For Vagrant testing
To create one machine called dbvagrant for ip address 192.168.50.50.
Ip address can be changed in Vagrantfile and environment file needed.

Username and password is vagrant.

### Configuration (must)
Edit places marked with TODO tag in project.
Basically you need to type url where to download Oracle installation zip-files.

You can also add installation zip-files ( linuxamd64_12102_database_1of2.zip and linuxamd64_12102_database_2of2.zip ) under to files/ -directory .

### Run commands on project root folder
Create machine or re-provision machine
```
vagrant up --provision
```
Remove machine
```
vagrant destroy
```
Log in to machine ssh
```
vagrant ssh
```
### Other tips
After log in to machine run sudo -i to gain root privileges for shell.
```
[vagrant@dbvagrant ~]$ sudo -i
[root@dbvagrant ~]# 
```
To see state of machine you can run query running docker containers:
```
[root@dbvagrant ~]# docker ps
```
To use sqlplus for testdb:
```
[root@dbvagrant ~]# docker exec -it testdb sqlplus / as sysdba
```
To see state of testdb you can run query for system resource using:
```
[root@dbvagrant ~]# docker stats testdb
```
To see state of testdb you can run query for running process inside contaner:
```
[root@dbvagrant ~]# docker top testdb
```
To see state of testdb you can run query for logs:
```
[root@dbvagrant ~]# docker logs testdb
```