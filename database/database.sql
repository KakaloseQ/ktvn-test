use newspringboot;

CREATE TABLE role(
id bigint NOT NULL PRIMARY KEY auto_increment,
name VARCHAR(255) NOT NULL,
code VARCHAR(255) NOT NULL,
createddate TIMESTAMP NULL,
modifieddate TIMESTAMP NULL,
createdby VARCHAR(255) NULL,
modifiedby VARCHAR(255) NULL
);
-- Create table
create table APP_USER
(
  USER_ID           BIGINT not null,
  USER_NAME         VARCHAR(36) not null,
  ENCRYTED_PASSWORD VARCHAR(128) not null,
  ENABLED           BIT not null 
) ;
--  
alter table APP_USER
  add constraint APP_USER_PK primary key (USER_ID);
 
alter table APP_USER
  add constraint APP_USER_UK unique (USER_NAME);
 
 
-- Create table
create table APP_ROLE
(
  ROLE_ID   BIGINT not null,
  ROLE_NAME VARCHAR(30) not null
) ;
--  
alter table APP_ROLE
  add constraint APP_ROLE_PK primary key (ROLE_ID);
 
alter table APP_ROLE
  add constraint APP_ROLE_UK unique (ROLE_NAME);
 
 
-- Create table
create table USER_ROLE
(
  ID      BIGINT not null,
  USER_ID BIGINT not null,
  ROLE_ID BIGINT not null
);
--  
alter table USER_ROLE
  add constraint USER_ROLE_PK primary key (ID);
 
alter table USER_ROLE
  add constraint USER_ROLE_UK unique (USER_ID, ROLE_ID);
 
alter table USER_ROLE
  add constraint USER_ROLE_FK1 foreign key (USER_ID)
  references APP_USER (USER_ID);
 
alter table USER_ROLE
  add constraint USER_ROLE_FK2 foreign key (ROLE_ID)
  references APP_ROLE (ROLE_ID);
 
 
-- Used by Spring Remember Me API.  
CREATE TABLE Persistent_Logins (
 
    username varchar(64) not null,
    series varchar(64) not null,
    token varchar(64) not null,
    last_used timestamp not null,
    PRIMARY KEY (series)
     
);
 
--------------------------------------
 
insert into App_User (USER_ID, USER_NAME, ENCRYTED_PASSWORD, ENABLED)
values (2, 'dbuser1', '$2a$10$PrI5Gk9L.tSZiW9FXhTS8O8Mz9E97k2FZbFvGFFaSsiTUIl.TCrFu', 1);
 
insert into App_User (USER_ID, USER_NAME, ENCRYTED_PASSWORD, ENABLED)
values (1, 'dbadmin1', '$2a$10$PrI5Gk9L.tSZiW9FXhTS8O8Mz9E97k2FZbFvGFFaSsiTUIl.TCrFu', 1);
insert into App_User (USER_ID, USER_NAME, ENCRYTED_PASSWORD, ENABLED)
values (1, 'root1', '$2a$10$PrI5Gk9L.tSZiW9FXhTS8O8Mz9E97k2FZbFvGFFaSsiTUIl.TCrFu', 1);
 
---
 
insert into app_role (ROLE_ID, ROLE_NAME)
values (1, 'ROLE_ADMIN');
 
insert into app_role (ROLE_ID, ROLE_NAME)
values (2, 'ROLE_USER');

insert into app_role (ROLE_ID, ROLE_NAME)
values (3, 'ROLE_ROOT');
 
---
 
insert into user_role (ID, USER_ID, ROLE_ID)
values (1, 1, 1);
 
insert into user_role (ID, USER_ID, ROLE_ID)
values (2, 1, 2);
 
insert into user_role (ID, USER_ID, ROLE_ID)
values (3, 2, 2);

insert into user_role (ID, USER_ID, ROLE_ID)
values (4, 3, 3);

insert into user_role (ID, USER_ID, ROLE_ID)
values (5, 3, 1);

insert into user_role (ID, USER_ID, ROLE_ID)
values (6, 3, 2);
---
CREATE TABLE user(
id bigint NOT NULL PRIMARY KEY auto_increment,
name VARCHAR(255) NOT NULL,
password VARCHAR(255) NOT NULL,
fullname VARCHAR(255) NULL,
status int NOT NULL,
roleid bigint NOT NULL,
createddate TIMESTAMP NULL,
modifieddate TIMESTAMP NULL,
createdby VARCHAR(255) NULL,
modifiedby VARCHAR(255) NULL
);

ALTER TABLE user ADD CONSTRAINT fk_user_role FOREIGN KEY (roleid) REFERENCES role(id);

CREATE TABLE news(
id bigint NOT NULL PRIMARY KEY auto_increment,
tittle VARCHAR(255) NULL,
thumbnail VARCHAR(255) NULL,
shortdescription TEXT NULL,
content TEXT NULL,
categoryid bigint NOT NULL,
createddate TIMESTAMP NULL,
modifieddate TIMESTAMP NULL,
createdby VARCHAR(255) NULL,
modifiedby VARCHAR(255) NULL
);

CREATE TABLE category(
id bigint NOT NULL PRIMARY KEY auto_increment,
name VARCHAR(255) NOT NULL,
code VARCHAR(255) NOT NULL,
createddate TIMESTAMP NULL,
modifieddate TIMESTAMP NULL,
createdby VARCHAR(255) NULL,
modifiedby VARCHAR(255) NULL
);

ALTER TABLE news ADD CONSTRAINT fk_news_category FOREIGN KEY (categoryid) REFERENCES category(id);

CREATE TABLE comment(
id bigint NOT NULL PRIMARY KEY auto_increment,
content TEXT NOT NULL,
user_id bigint NOT NULL,
new_id bigint NOT NULL,
createddate TIMESTAMP NULL,
modifieddate TIMESTAMP NULL,
createdby VARCHAR(255) NULL,
modifiedby VARCHAR(255) NULL
);

ALTER TABLE comment ADD CONSTRAINT fk_comment_user FOREIGN KEY (user_id) REFERENCES user(id);
ALTER TABLE comment ADD CONSTRAINT fk_comment_news FOREIGN KEY (new_id) REFERENCES news(id);

