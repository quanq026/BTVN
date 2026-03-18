create schema hospital;

create table hospital.departments(
	department_id serial primary key,
	department_name varchar(100) not null unique,
	location varchar(200)
);

create table hospital.patients(
	patient_id serial primary key,
	full_name varchar(100) not null,
	gender boolean,
	birthday date,
	address varchar(200),
	phone varchar(15) default ''
);

create table hospital.doctors(
	doctor_id serial primary key,
	full_name varchar(100) not null,
	gender boolean,
	birthday date,
	phone varchar(15) default '',
	department_id int references hospital.departments(department_id)
);

create table hospital.medical_records(
	record_id serial primary key,
	exam_date date default current_date,
	diagnosis text,
	treatment text,
	patient_id int references hospital.patients(patient_id),
	doctor_id int references hospital.doctors(doctor_id)
);