CREATE OR REPLACE PROCEDURE ProfessorEnrollTimeTable (enrollPID IN NUMBER,/*selecttimetableprofessor*/
	p_enroll_course OUT SYS_REFCURSOR,
	total_course OUT NUMBER,
	total_unit OUT NUMBER)
IS
	year NUMBER;
	semester NUMBER;
BEGIN
	year := Date2EnrollYear(SYSDATE);
	semester := Date2EnrollSemester(SYSDATE);
	OPEN p_enroll_course FOR
	
	SELECT c.c_id, c.c_no, c.c_name, c.c_credit, t.t_room, t.t_hour, t.t_day
	from teach t, course c
	where t.t_year= year and t.t_sem = semester and t.c_id = c.c_id and t.c_no = c.c_no and p_id=enrollPID;
	
	select COUNT(*)
	into total_course
	from teach
	where t_year = year and t_sem = semester and p_id = enrollPID;
	
	select SUM(c.c_credit)
	into total_unit
	from teach t, course c
	where t.t_year = year and t.t_sem = semester and t.p_id = enrollPID and t.c_id = c.c_id and t.c_no = c.c_no;
	DBMS_OUTPUT.PUT_LINE('총 '||total_course||' 과목과 총 '||total_unit||' 학점을 강의합니다.');
END;
/