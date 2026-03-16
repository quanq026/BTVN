create database elearningdb;

create schema elearning;

create table elearning.students(
	student_id serial primary key,
	first_name varchar(50) not null,
	last_name varchar(50) not null,
	email varchar(100) not null unique
);

create table elearning.instructors(
	instructor_id serial primary key,
	first_name varchar(50) not null,
	last_name varchar(50) not null,
	email varchar(100) not null unique
);

create table elearning.courses(
	course_id serial primary key,
	course_name varchar(100) not null,
	instructor_id int references elearning.instructors(instructor_id)
);

create table elearning.enrollments(
	enrollment_id serial primary key,
	student_id int references elearning.students(student_id),
	course_id int references elearning.courses(course_id),
	enroll_date date not null
);

create table elearning.assignments(
	assignment_id serial primary key,
	course_id int references elearning.courses(course_id),
	title varchar(100) not null,
	due_date date not null
);

create table elearning.submissions(
	submission_id serial primary key,
	assignment_id int references elearning.assignments(assignment_id),
	student_id int references elearning.students(student_id),
	submission_date date not null,
	grade numeric(5,2) check(grade >= 0 and grade <= 100)
);

select datname from pg_database;

select schema_name from information_schema.schemata;

select column_name, data_type, character_maximum_length, is_nullable
from information_schema.columns
where table_schema = 'elearning' and table_name = 'students';

select column_name, data_type, character_maximum_length, is_nullable
from information_schema.columns
where table_schema = 'elearning' and table_name = 'instructors';

select column_name, data_type, character_maximum_length, is_nullable
from information_schema.columns
where table_schema = 'elearning' and table_name = 'courses';

select column_name, data_type, character_maximum_length, is_nullable
from information_schema.columns
where table_schema = 'elearning' and table_name = 'enrollments';

select column_name, data_type, character_maximum_length, is_nullable
from information_schema.columns
where table_schema = 'elearning' and table_name = 'assignments';

select column_name, data_type, character_maximum_length, is_nullable
from information_schema.columns
where table_schema = 'elearning' and table_name = 'submissions';