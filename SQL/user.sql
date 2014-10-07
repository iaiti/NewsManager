create table users(
id int primary key auto_increment,
name varchar(55),
pw varchar(200),
usertype varchar(200)
)ENGINE=InnoDB default charset=utf8;

密码加密之后发现编码问题 所以要统一编码 
建立数据库时可以使用以下命令：

create database app_relation character set utf8; 

use app_relation;

source app_relation.sql;
MySQL会出现中文乱码的原因不外乎下列几点：
1.server本身设定问题，例如还停留在latin1
2.table的语系设定问题(包含character与collation)
3.客户端程式(例如php)的连线语系设定问题
强烈建议使用utf8!!!!

二、避免导入数据有中文乱码的问题
1:将数据编码格式保存为utf-8
设置默认编码为utf8：
set names utf8;
设置数据库db_name默认为utf8:
ALTER DATABASE news DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;
设置表tb_name默认编码为utf8:
ALTER TABLE users DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;
导入：
修改数据库编码的命令为：

alter database news character set utf8; 
insert into users values(null,'admin',MD5('admin'),'administrator');
insert into users values(null,'admin',MD5('admin'),'你是');