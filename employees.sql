DROP DATABASE IF EXISTS javatask2;

CREATE DATABASE javatask2 DEFAULT CHARACTER SET 'utf8';

USE javatask2;

create table employees
(
  idEmployee int(10) not null auto_increment,
  surname varchar(30),
  name varchar(30),
  gender ENUM('male', 'female'),
  marital_status ENUM('single', 'married', 'divorced'),
  salary INT(10),
  dob DATE,
  primary key (idEmployee)
) ENGINE=InnoDB;

create table technologies
(
  idTechnology int(10) not null auto_increment,
  name varchar(100),
  description varchar(200),
  rate ENUM('1', '2', '3'),
  primary key (idTechnology)
) ENGINE=InnoDB;

create table affair
(
 idAffair int(10) not null auto_increment,
 idEmployee int(10) not null,
 idTechnology int(10) not null,
 primary key (idAffair),
 foreign key (idEmployee) references employees(idEmployee)
 ON UPDATE CASCADE ON DELETE CASCADE,
 foreign key (idTechnology) references technologies(idTechnology)
 ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB CHARACTER SET=UTF8;