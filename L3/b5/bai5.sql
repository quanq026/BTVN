create schema training;

create table training.courses(
	course_id serial primary key,
	course_name varchar(100) not null unique,
	description text,
	tuition_fee numeric(12,2) check(tuition_fee >= 0)
);

create table training.lecturers(
	lecturer_id serial primary key,
	full_name varchar(100) not null,
	major varchar(100),
	phone varchar(15) default ''
);

create table training.students(
	student_id serial primary key,
	full_name varchar(100) not null,
	email varchar(100) not null unique,
	register_date date default current_date
);

create table training.classes(
	class_id serial primary key,
	schedule varchar(200),
	course_id int references training.courses(course_id),
	lecturer_id int references training.lecturers(lecturer_id)
);

create table training.enrollments(
	student_id int not null references training.students(student_id),
	class_id int not null references training.classes(class_id),
	primary key(student_id, class_id)
);