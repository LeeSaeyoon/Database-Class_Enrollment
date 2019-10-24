CREATE OR REPLACE PROCEDURE StudentEnrollTimetable (enrollSID IN NUMBER,
   s_enroll_course OUT SYS_REFCURSOR,
   total_course OUT NUMBER,
   total_unit OUT NUMBER)
IS
   year NUMBER;
   semester NUMBER;
BEGIN
   year := Date2EnrollYear(SYSDATE);
   semester := Date2EnrollSemester(SYSDATE);
   OPEN s_enroll_course FOR
   SELECT c.c_id, c.c_no, c.c_name, c.c_credit, t.t_room, t.t_hour, t.t_day
   from teach t, course c, enroll e
   where e.e_year= year and t.t_year = year and e.e_sem = semester and t.t_sem = semester and t.c_id = c.c_id
   and c.c_id = e.c_id and t.c_no = c.c_no and c.c_no = e.c_no and s_id = enrollSID;
   
   select COUNT(*)
   into total_course
   from enroll
   where e_year = year and e_sem = semester and s_id = enrollSID;
   
   select SUM(c.c_credit)
   into total_unit
   from enroll e, course c
   where e.e_year = year and e.e_sem = semester and e.s_id = enrollSID and e.c_id = c.c_id and e.c_no = c.c_no;
   DBMS_OUTPUT.PUT_LINE('총 '||total_course||' 과목과 총 '||total_unit||' 학점을 신청하였습니다.');
END;
/