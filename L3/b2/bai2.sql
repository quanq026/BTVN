create schema university;

create table university.students(
	student_id char(10) not null primary key,
	full_name varchar(100) not null,
	gender boolean,
	birthday date,
	address varchar(200),
	phone varchar(15) default ''
);

create table university.subjects(
	subject_id char(10) not null primary key,
	subject_name varchar(100) not null unique,
	credits int check(credits > 0)
);

create table university.lecturers(
	lecturer_id char(10) not null primary key,
	full_name varchar(100) not null,
	gender boolean,
	birthday date,
	address varchar(200),
	phone varchar(15) default ''
);

create table university.class_sections(
	class_id char(10) not null primary key,
	class_name varchar(100) not null unique,
	start_date date default current_date,
	end_date date check(end_date > start_date),
	subject_id char(10) references university.subjects(subject_id),
	lecturer_id char(10) references university.lecturers(lecturer_id)
);

create table university.lecturer_subject(
	lecturer_id char(10) not null references university.lecturers(lecturer_id),
	subject_id char(10) not null references university.subjects(subject_id),
	primary key(lecturer_id, subject_id)
);

create table university.enrollments(
	student_id char(10) not null references university.students(student_id),
	class_id char(10) not null references university.class_sections(class_id),
	enroll_date date default current_date,
	primary key(student_id, class_id)
);