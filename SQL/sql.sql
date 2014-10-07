create database news;

use news;

create table shownews(
id varchar(50) primary key ,
title varchar(55),
author varchar(55),
newstime datetime,
content text,
attachment varchar(4000),
newtype varchar(55),
publishertype varchar(100)
)ENGINE=InnoDB default charset=utf8;


insert into shownews values(null,'admin','t',now(),'sdf',null,'学生动态','学院办公室');
