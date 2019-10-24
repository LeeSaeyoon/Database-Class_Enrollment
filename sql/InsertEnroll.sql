CREATE OR REPLACE PROCEDURE InsertEnroll(sStudentId IN VARCHAR2,
CourseId IN VARCHAR2, /*sCourseId*/
CourseNo IN NUMBER, /*nCourseIdNo*/
result OUT VARCHAR2)
IS
overflow_max_flow EXCEPTION; /*too_many_sumCourseUnit*/
overlap_course EXCEPTION; /*too_many_courses*/
overflow_max_PPL EXCEPTION; /*too_many_students*/
overlap_course_time EXCEPTION; /*duplicate_time*/
nYear NUMBER;
nSemester NUMBER;
SumCredit NUMBER; /*nSumCourseUnit*/
CourseCredit NUMBER; /*nCourseUnit*/
tempCnt NUMBER; /*nCnt*/
maxPPL NUMBER; /*nTeachMax*/
BEGIN
result := '';
DBMS_OUTPUT.put_line('#');
DBMS_OUTPUT.put_line(sStudentId || '님이 과목번호 ' || CourseId ||
', 분반 ' || TO_CHAR(CourseNo) || '의 수강 등록을 요청하였습니다.');
/* 년도, 학기 알아내기 */
nYear := Date2EnrollYear(SYSDATE);
nSemester := Date2EnrollSemester(SYSDATE);
/* 에러 처리 1 : 최대학점 초과여부 */
SELECT SUM(c.c_credit)
INTO SumCredit
FROM course c, enroll e
WHERE e.s_id = sStudentId and e.e_year = nYear and
e.e_sem = nSemester and e.c_id = c.c_id and e.c_no = c.c_no;
SELECT c_credit
INTO CourseCredit
FROM course
WHERE c_id = CourseId and c_no = CourseNo;
IF (SumCredit + CourseCredit > 18)
THEN
RAISE overflow_max_flow;
END IF;
/* 에러 처리 2 : 동일한 과목 신청 여부 */
SELECT COUNT(*)
INTO tempCnt
FROM enroll
WHERE s_id = sStudentId and c_id = CourseId;
IF (tempCnt > 0)
THEN
RAISE overlap_course;
END IF;
/* 에러 처리 3 : 수강신청 인원 초과 여부 */
SELECT t_maxppl
INTO maxPPL
FROM teach
WHERE t_year= nYear and t_sem = nSemester
and c_id = CourseId and c_no= CourseNo;
SELECT COUNT(*)
INTO tempCnt
FROM enroll
WHERE e_year = nYear and e_sem = nSemester
and c_id = CourseId and c_no = CourseNo;
IF (tempCnt >= maxPPL)
THEN
RAISE overflow_max_PPL;
END IF;
/* 에러 처리 4 : 신청한 과목들 시간 중복 여부 */
SELECT COUNT(*)
INTO tempCnt
FROM
(
SELECT t_hour,t_day
FROM teach
WHERE t_year=nYear and t_sem = nSemester and
c_id = CourseId and c_no = CourseNo
INTERSECT
SELECT t.t_hour, t.t_day
FROM teach t, enroll e
WHERE e.s_id=sStudentId and e.e_year=nYear and e.e_sem = nSemester and
t.t_year=nYear and t.t_sem = nSemester and
e.c_id=t.c_id and e.c_no=t.c_no
);
IF (tempCnt > 0)
THEN
RAISE overlap_course_time;
END IF;
/* 수강 신청 등록 */
INSERT INTO enroll(S_ID,C_ID,C_NO,E_YEAR,E_SEM)
VALUES (sStudentId, CourseId, CourseNo, nYear, nSemester);
COMMIT;
result := '수강신청 등록이 완료되었습니다.';
EXCEPTION
WHEN overflow_max_flow THEN
result := '최대학점을 초과하였습니다';
WHEN overlap_course THEN
result := '이미 등록된 과목을 신청하였습니다';
WHEN overflow_max_PPL THEN
result := '수강신청 인원이 초과되어 등록이 불가능합니다';
WHEN overlap_course_time THEN
result := '이미 등록된 과목 중 중복되는 시간이 존재합니다';
WHEN OTHERS THEN
ROLLBACK;
result := SQLCODE;
END;
/