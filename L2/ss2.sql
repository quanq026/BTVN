create database universitydb;

create schema university;

create table university.students(
	student_id serial primary key,
	first_name varchar(50) not null,
	last_name varchar(50) not null,
	birth_date date,
	email varchar(100) not null unique
);

create table university.courses(
	course_id serial primary key,
	course_name varchar(100) not null,
	credits int
);

create table university.enrollments(
	enrollment_id serial primary key,
	student_id int references university.students(student_id),
	course_id int references university.courses(course_id),
	enroll_date date default current_date
);

select datname from pg_database;

select schema_name from information_schema.schemata;

select column_name, data_type, character_maximum_length, is_nullable
from information_schema.columns
where table_schema = 'university' and table_name = 'students';

select column_name, data_type, character_maximum_length, is_nullable
from information_schema.columns
where table_schema = 'university' and table_name = 'courses';

select column_name, data_type, character_maximum_length, is_nullable
from information_schema.columns
where table_schema = 'university' and table_name = 'enrollments';