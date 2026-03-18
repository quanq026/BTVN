create database CompanyDB;

create table Departments(
	department_id serial primary key,
	department_name varchar(100) not null unique
);

create table Employees(
	emp_id serial primary key,
	name varchar(100) not null,
	dob date,
	department_id int references Departments(department_id)
);

create table Projects(
	project_id serial primary key,
	project_name varchar(100) not null unique,
	start_date date,
	end_date date check(end_date > start_date)
);

create table EmployeeProjects(
	emp_id int not null references Employees(emp_id),
	project_id int not null references Projects(project_id),
	primary key(emp_id, project_id)
);
