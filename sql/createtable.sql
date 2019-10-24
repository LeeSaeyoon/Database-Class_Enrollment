CREATE TABLE STUDENTS (
	s_id NUMBER(10) CONSTRAINT student_pk PRIMARY KEY,
	s_pw VARCHAR(20), /*s_pwd*/
	s_name VARCHAR(10),
	s_major VARCHAR(20), 
	s_addr VARCHAR(30),
	s_email VARCHAR(50)
);

CREATE TABLE PROFESSOR (
	p_id NUMBER(10) CONSTRAINT professor_pk PRIMARY KEY, /*p_pk*/
	p_pw VARCHAR(20),/*p_pwd*/
	p_name VARCHAR(10),
	p_major VARCHAR(20),
	p_email VARCHAR(50)
);

CREATE TABLE COURSE (
	c_id VARCHAR(4),
	c_no NUMBER(2),/*c_id_no*/
	c_credit NUMBER(1), /*c_unit*/
	c_name VARCHAR(30),
	
	CONSTRAINT course_pk PRIMARY KEY(c_id, c_no)/*c_pk*/
);

CREATE TABLE TEACH (/*¥ÎπÆ¿⁄∑Œ πŸ≤ﬁ*/
	c_id VARCHAR(4),
	c_no NUMBER(2),/*c_id_no*/
	p_id NUMBER(10),
	t_year NUMBER(4),
	t_sem NUMBER(1),/*t_semester*/
	t_hour NUMBER(2),/*t_time*/
	t_day NUMBER(1),
	t_maxppl NUMBER(3),/*t_max*/
	t_room VARCHAR(20),/*t_where*/
	/*º¯º≠πŸ≤ﬁ*/
	CONSTRAINT teach_pk PRIMARY KEY(c_id, c_no, t_year, t_sem),
	CONSTRAINT prof_teach_fk FOREIGN KEY (p_id) REFERENCES PROFESSOR(p_id),
	CONSTRAINT course_teach_fk FOREIGN KEY (c_id,c_no) REFERENCES COURSE(c_id,c_no)
);

CREATE TABLE ENROLL (/*¥ÎπÆ¿⁄∑Œ πŸ≤ﬁ*/
	s_id NUMBER(10) ,
	c_id VARCHAR(4),
	c_no NUMBER(2),/*c_id_no*/
	e_year NUMBER(4),
	e_sem NUMBER(1),/*e_semester*/
	/*¿Ã∏ß πŸ≤ﬁ*/
	CONSTRAINT enroll_pk PRIMARY KEY(s_id, c_id,e_year, e_sem),
	CONSTRAINT stu_enroll_fk FOREIGN KEY (s_id) REFERENCES STUDENTS(s_id),
	CONSTRAINT teach_enroll_fk FOREIGN KEY (c_id,c_no,e_year,e_sem) REFERENCES teach(c_id,c_no,t_year,t_sem)	
);

CREATE TABLE NOTICE(/*BOARD*/ /*b_ => n_ ∑Œ πŸ≤ﬁ*/ /*p_name, b_regdate ªË¡¶*/
	n_no NUMBER(10) CONSTRAINT pk_n PRIMARY KEY,
	n_name VARCHAR2(20),
	n_pw VARCHAR2(20),/*b_pwd*/
	n_title VARCHAR2(40) NOT NULL,
	n_cont VARCHAR2(1000),/*content*/
	n_look NUMBER(10) /*b_hit*/
);

CREATE SEQUENCE n_no
	START WITH 1
	INCREMENT BY 1
	MAXVALUE 9999999999;
	
commit;



CREATE TABLE STUDENTS (
	s_id NUMBER(10) CONSTRAINT student_pk PRIMARY KEY,
	s_pw VARCHAR(20), 
	s_name VARCHAR(10),
	s_major VARCHAR(20), 
	s_addr VARCHAR(30),
	s_email VARCHAR(50)
);

CREATE TABLE PROFESSOR (
	p_id NUMBER(10) CONSTRAINT professor_pk PRIMARY KEY, 
	p_pw VARCHAR(20),
	p_name VARCHAR(10),
	p_major VARCHAR(20),
	p_email VARCHAR(50)
);

CREATE TABLE COURSE (
	c_id VARCHAR(4),
	c_no NUMBER(2),
	c_credit NUMBER(1), 
	c_name VARCHAR(30),
	CONSTRAINT course_pk PRIMARY KEY(c_id, c_no)
);

CREATE TABLE TEACH (
	c_id VARCHAR(4),
	c_no NUMBER(2),
	p_id NUMBER(10),
	t_year NUMBER(4),
	t_sem NUMBER(1),
	t_hour NUMBER(2),
	t_day NUMBER(1),
	t_maxppl NUMBER(3),
	t_room VARCHAR(20),
	CONSTRAINT teach_pk PRIMARY KEY(c_id, c_no, t_year, t_sem),
	CONSTRAINT prof_teach_fk FOREIGN KEY (p_id) REFERENCES PROFESSOR(p_id),
	CONSTRAINT course_teach_fk FOREIGN KEY (c_id,c_no) REFERENCES COURSE(c_id,c_no)
);

CREATE TABLE ENROLL (
	s_id NUMBER(10) ,
	c_id VARCHAR(4),
	c_no NUMBER(2),
	e_year NUMBER(4),
	e_sem NUMBER(1),
	CONSTRAINT enroll_pk PRIMARY KEY(s_id, c_id,e_year, e_sem),
	CONSTRAINT stu_enroll_fk FOREIGN KEY (s_id) REFERENCES STUDENTS(s_id),
	CONSTRAINT teach_enroll_fk FOREIGN KEY (c_id,c_no,e_year,e_sem) REFERENCES teach(c_id,c_no,t_year,t_sem)	
);

CREATE TABLE NOTICE(
	n_no NUMBER(10) CONSTRAINT pk_n PRIMARY KEY,
	n_name VARCHAR2(20),
	n_pw VARCHAR2(20),
	n_title VARCHAR2(40) NOT NULL,
	n_cont VARCHAR2(1000),
	n_look NUMBER(10) 
);

CREATE SEQUENCE n_no
	START WITH 1
	INCREMENT BY 1
	MAXVALUE 9999999999;
	
commit;