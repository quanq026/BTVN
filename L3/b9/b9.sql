create database SchoolDB;

create table Students(
	student_id serial primary key,
	name varchar(100) not null,
	dob date
);

create table Courses(
	course_id serial primary key,
	course_name varchar(100) not null unique,
	credits int check(credits > 0)
);

create table Enrollments(
	enrollment_id serial primary key,
	student_id int references Students(student_id),
	course_id int references Courses(course_id),
	grade char(1) check(grade in ('A', 'B', 'C', 'D', 'F'))
);
