CREATE TABLE School (
	school_id VARCHAR(10), 
	school_name  VARCHAR(50) NOT NULL, 
	website VARCHAR(50), 
	PRIMARY KEY (school_id), 
	UNIQUE (school_name));

CREATE TABLE Student (
	uni VARCHAR(8), 
	name  VARCHAR(25) NOT NULL, 
	degree VARCHAR(10) NOT NULL, 
	gender VARCHAR(8) NOT NULL, 
	race VARCHAR(10), 
	major VARCHAR(40) NOT NULL, 
	status VARCHAR(20) NOT NULL, 
	dateofbirth DATE NOT NULL, 
	gpa FLOAT, 
	PRIMARY KEY (uni), 
	CHECK ((gpa >= 2.0 OR gpa IS NULL) AND dateofbirth < CURRENT_DATE));

CREATE TABLE Includes_Department(
	school_id VARCHAR(10) NOT NULL,
	department_id VARCHAR(6),
	department_name VARCHAR(50) NOT NULL,
	location VARCHAR(80),
	webpage VARCHAR(50),
	PRIMARY KEY (department_id),
	UNIQUE (department_name),
	FOREIGN KEY (school_id) REFERENCES School);

CREATE TABLE Course_Offers (
	term VARCHAR(20),
	department_id VARCHAR(6),
	course_number VARCHAR(6),
	course_title VARCHAR(50) NOT NULL,
	day_time VARCHAR(20) NOT NULL,
	location VARCHAR(30),
	NumofStu_Enrolled INT NOT NULL,
	NumofStu_Max INT NOT NULL,
	points INT NOT NULL,
	PRIMARY KEY (department_id, term, course_number),
	FOREIGN KEY (department_id) REFERENCES Includes_Department,
	CHECK (NumofStu_Enrolled >= 1 AND points > 0 AND NumofStu_MAX > 0));

CREATE TABLE Staff(
	staff_id INT,
	name VARCHAR(25) NOT NULL,
	gender VARCHAR(8) NOT NULL,
	title VARCHAR(30),
	highest_degree VARCHAR(10),
	PRIMARY KEY (staff_id));

CREATE TABLE Company(
	company_id VARCHAR(10),
	company_name VARCHAR(35) NOT NULL,
	industry VARCHAR(20) NOT NULL,
	hq_address VARCHAR(80) NOT NULL,
	PRIMARY KEY (company_id))
	UNIQUE (company_name);

CREATE TABLE Consists_of(
	school_id VARCHAR(10),
	staff_id INT,
	PRIMARY KEY (school_id, staff_id),
	FOREIGN KEY (school_id) REFERENCES School,
	FOREIGN KEY (staff_id) REFERENCES Staff);

CREATE TABLE Teaches(
	staff_id INT,
	term VARCHAR(20),
	department_id VARCHAR(6),
	course_number VARCHAR(6),
	PRIMARY KEY (staff_id, department_id, term, course_number),
	FOREIGN KEY (staff_id) REFERENCES Staff,
	FOREIGN KEY (department_id, term, course_number) REFERENCES Course_Offers);

CREATE TABLE Has(
	school_id VARCHAR(10),
	uni VARCHAR(8),
	PRIMARY KEY (school_id, uni),
	FOREIGN KEY (school_id) REFERENCES School,
	FOREIGN KEY (uni) REFERENCES Student ON DELETE CASCADE
    									 ON UPDATE CASCADE);

CREATE TABLE Enrolls(
	uni VARCHAR(8),
	term VARCHAR(20),
	department_id VARCHAR(6),
	course_number VARCHAR(6),
	grade VARCHAR(4),
	PRIMARY KEY (uni, department_id, term, course_number),
	FOREIGN KEY (uni) REFERENCES Student ON DELETE CASCADE
    					   				 ON UPDATE CASCADE,
	FOREIGN KEY (department_id, term, course_number) REFERENCES Course_Offers);

CREATE TABLE Works_in(
	uni VARCHAR(8),
	company_id VARCHAR(10),
	PRIMARY KEY (uni, company_id),
	FOREIGN KEY (UNIQUE) REFERENCES Student ON DELETE CASCADE
    									    ON UPDATE CASCADE,
	FOREIGN KEY (company_id) REFERENCES Company);


