CREATE TABLE eligible_instrument (
 id INT NOT NULL,
 eligible_instrument VARCHAR(500)
);

ALTER TABLE eligible_instrument ADD CONSTRAINT PK_eligible_instrument PRIMARY KEY (id);


CREATE TABLE email (
 id INT NOT NULL,
 email  VARCHAR(500) NOT NULL
);

ALTER TABLE email ADD CONSTRAINT PK_email PRIMARY KEY (id);


CREATE TABLE ensemble (
 id INT NOT NULL,
 minimum_nbr INT NOT NULL,
 maximum_nbr INT,
 price DECIMAL(10)
);

ALTER TABLE ensemble ADD CONSTRAINT PK_ensemble PRIMARY KEY (id);


CREATE TABLE group_lesson (
 id INT NOT NULL,
 minimum_nbr INT NOT NULL,
 maximum_nbr INT,
 skill_level VARCHAR(100),
 price DECIMAL(10)
);

ALTER TABLE group_lesson ADD CONSTRAINT PK_group_lesson PRIMARY KEY (id);


CREATE TABLE individual_lesson (
 id INT NOT NULL,
 skill_level VARCHAR(100),
 price DECIMAL(10)
);

ALTER TABLE individual_lesson ADD CONSTRAINT PK_individual_lesson PRIMARY KEY (id);


CREATE TABLE instrument (
 id INT NOT NULL,
 type VARCHAR(500) NOT NULL,
 nbr_in_stock INT,
 rented INT,
 brand VARCHAR(500),
 price DECIMAL(10)
);

ALTER TABLE instrument ADD CONSTRAINT PK_instrument PRIMARY KEY (id);


CREATE TABLE person_detail (
 id INT NOT NULL,
 person_nbr VARCHAR(12) NOT NULL,
 first_name VARCHAR(500),
 last_name VARCHAR(500),
 age INT,
 address VARCHAR(1500)
);

ALTER TABLE person_detail ADD CONSTRAINT PK_person_detail PRIMARY KEY (id);


CREATE TABLE person_detail_email (
 person_detail_id INT NOT NULL,
 email_id INT NOT NULL
);

ALTER TABLE person_detail_email ADD CONSTRAINT PK_person_detail_email PRIMARY KEY (person_detail_id,email_id);


CREATE TABLE phone (
 id INT NOT NULL,
 phone VARCHAR(500) NOT NULL
);

ALTER TABLE phone ADD CONSTRAINT PK_phone PRIMARY KEY (id);


CREATE TABLE phone_parent (
 id INT NOT NULL,
 phone_parent VARCHAR(500) NOT NULL
);

ALTER TABLE phone_parent ADD CONSTRAINT PK_phone_parent PRIMARY KEY (id);


CREATE TABLE enrollment_submission (
 id INT NOT NULL,
 skill_level VARCHAR(100),
 enrollment_decision VARCHAR(500),
 submission_time TIMESTAMP(6) NOT NULL,
 parent_name VARCHAR(500),
 person_detail_id INT NOT NULL
);

ALTER TABLE enrollment_submission ADD CONSTRAINT PK_enrollment_submission PRIMARY KEY (id);


CREATE TABLE instructor (
 id INT NOT NULL,
 ensemble_yes_or_no VARCHAR(100),
 person_detail_id INT NOT NULL
);

ALTER TABLE instructor ADD CONSTRAINT PK_instructor PRIMARY KEY (id);


CREATE TABLE instructor_eligible_instrument (
 instructor_id INT NOT NULL,
 eligible_instrument_id INT NOT NULL
);

ALTER TABLE instructor_eligible_instrument ADD CONSTRAINT PK_instructor_eligible_instrument PRIMARY KEY (instructor_id,eligible_instrument_id);


CREATE TABLE instructor_payment (
 instructor_id INT NOT NULL,
 amount DECIMAL(10),
 month VARCHAR(500) NOT NULL
);

ALTER TABLE instructor_payment ADD CONSTRAINT PK_instructor_payment PRIMARY KEY (instructor_id);


CREATE TABLE person_detail_phone (
 person_detail_id INT NOT NULL,
 phone_id INT NOT NULL
);

ALTER TABLE person_detail_phone ADD CONSTRAINT PK_person_detail_phone PRIMARY KEY (person_detail_id,phone_id);


CREATE TABLE student (
 id INT NOT NULL,
 enrollment_date DATE NOT NULL,
 nbr_of_instrument_rented INT,
 instrument_lease_id INT NOT NULL,
 enrollment_submission_id INT NOT NULL
);

ALTER TABLE student ADD CONSTRAINT PK_student PRIMARY KEY (id);


CREATE TABLE submission_phone_parent (
 enrollment_submission_id INT NOT NULL,
 phone_parent_id INT NOT NULL
);

ALTER TABLE submission_phone_parent ADD CONSTRAINT PK_submission_phone_parent PRIMARY KEY (enrollment_submission_id,phone_parent_id);


CREATE TABLE class_type (
 id INT NOT NULL,
 type_of_instrument  VARCHAR(500) NOT NULL,
 instrument_or_ensemble VARCHAR(100) NOT NULL,
 start_time TIMESTAMP(10) NOT NULL,
 end_time TIMESTAMP(10) NOT NULL,
 group_lesson_id INT,
 individual_lesson_id INT,
 ensemble_id INT,
 instructor_id INT
);

ALTER TABLE class_type ADD CONSTRAINT PK_class_type PRIMARY KEY (id);


CREATE TABLE instrument_lease (
 instrument_id INT NOT NULL,
 start_month DATE NOT NULL,
 end_month DATE NOT NULL,
 student_id INT NOT NULL
);

ALTER TABLE instrument_lease ADD CONSTRAINT PK_instrument_lease PRIMARY KEY (instrument_id);


CREATE TABLE monthly_bill (
 student_id INT NOT NULL,
 discount DECIMAL(10),
 total_amount DECIMAL(10),
 month VARCHAR(500) NOT NULL
);

ALTER TABLE monthly_bill ADD CONSTRAINT PK_monthly_bill PRIMARY KEY (student_id);


ALTER TABLE person_detail_email ADD CONSTRAINT FK_person_detail_email_0 FOREIGN KEY (person_detail_id) REFERENCES person_detail (id);
ALTER TABLE person_detail_email ADD CONSTRAINT FK_person_detail_email_1 FOREIGN KEY (email_id) REFERENCES email (id);


ALTER TABLE enrollment_submission ADD CONSTRAINT FK_enrollment_submission_0 FOREIGN KEY (person_detail_id) REFERENCES person_detail (id);


ALTER TABLE instructor ADD CONSTRAINT FK_instructor_0 FOREIGN KEY (person_detail_id) REFERENCES person_detail (id);


ALTER TABLE instructor_eligible_instrument ADD CONSTRAINT FK_instructor_eligible_instrument_0 FOREIGN KEY (instructor_id) REFERENCES instructor (id);
ALTER TABLE instructor_eligible_instrument ADD CONSTRAINT FK_instructor_eligible_instrument_1 FOREIGN KEY (eligible_instrument_id) REFERENCES eligible_instrument (id);


ALTER TABLE instructor_payment ADD CONSTRAINT FK_instructor_payment_0 FOREIGN KEY (instructor_id) REFERENCES instructor (id);


ALTER TABLE person_detail_phone ADD CONSTRAINT FK_person_detail_phone_0 FOREIGN KEY (person_detail_id) REFERENCES person_detail (id);
ALTER TABLE person_detail_phone ADD CONSTRAINT FK_person_detail_phone_1 FOREIGN KEY (phone_id) REFERENCES phone (id);


ALTER TABLE student ADD CONSTRAINT FK_student_0 FOREIGN KEY (enrollment_submission_id) REFERENCES enrollment_submission (id);


ALTER TABLE submission_phone_parent ADD CONSTRAINT FK_submission_phone_parent_0 FOREIGN KEY (enrollment_submission_id) REFERENCES enrollment_submission (id);
ALTER TABLE submission_phone_parent ADD CONSTRAINT FK_submission_phone_parent_1 FOREIGN KEY (phone_parent_id) REFERENCES phone_parent (id);


ALTER TABLE class_type ADD CONSTRAINT FK_class_type_0 FOREIGN KEY (group_lesson_id) REFERENCES group_lesson (id);
ALTER TABLE class_type ADD CONSTRAINT FK_class_type_1 FOREIGN KEY (individual_lesson_id) REFERENCES individual_lesson (id);
ALTER TABLE class_type ADD CONSTRAINT FK_class_type_2 FOREIGN KEY (ensemble_id) REFERENCES ensemble (id);
ALTER TABLE class_type ADD CONSTRAINT FK_class_type_3 FOREIGN KEY (instructor_id) REFERENCES instructor (id);


ALTER TABLE instrument_lease ADD CONSTRAINT FK_instrument_lease_0 FOREIGN KEY (instrument_id) REFERENCES instrument (id);
ALTER TABLE instrument_lease ADD CONSTRAINT FK_instrument_lease_1 FOREIGN KEY (student_id) REFERENCES student (id);


ALTER TABLE monthly_bill ADD CONSTRAINT FK_monthly_bill_0 FOREIGN KEY (student_id) REFERENCES student (id);


