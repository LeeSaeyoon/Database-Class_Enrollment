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
DBMS_OUTPUT.put_line(sStudentId || '���� �����ȣ ' || CourseId ||
', �й� ' || TO_CHAR(CourseNo) || '�� ���� ����� ��û�Ͽ����ϴ�.');
/* �⵵, �б� �˾Ƴ��� */
nYear := Date2EnrollYear(SYSDATE);
nSemester := Date2EnrollSemester(SYSDATE);
/* ���� ó�� 1 : �ִ����� �ʰ����� */
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
/* ���� ó�� 2 : ������ ���� ��û ���� */
SELECT COUNT(*)
INTO tempCnt
FROM enroll
WHERE s_id = sStudentId and c_id = CourseId;
IF (tempCnt > 0)
THEN
RAISE overlap_course;
END IF;
/* ���� ó�� 3 : ������û �ο� �ʰ� ���� */
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
/* ���� ó�� 4 : ��û�� ����� �ð� �ߺ� ���� */
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
/* ���� ��û ��� */
INSERT INTO enroll(S_ID,C_ID,C_NO,E_YEAR,E_SEM)
VALUES (sStudentId, CourseId, CourseNo, nYear, nSemester);
COMMIT;
result := '������û ����� �Ϸ�Ǿ����ϴ�.';
EXCEPTION
WHEN overflow_max_flow THEN
result := '�ִ������� �ʰ��Ͽ����ϴ�';
WHEN overlap_course THEN
result := '�̹� ��ϵ� ������ ��û�Ͽ����ϴ�';
WHEN overflow_max_PPL THEN
result := '������û �ο��� �ʰ��Ǿ� ����� �Ұ����մϴ�';
WHEN overlap_course_time THEN
result := '�̹� ��ϵ� ���� �� �ߺ��Ǵ� �ð��� �����մϴ�';
WHEN OTHERS THEN
ROLLBACK;
result := SQLCODE;
END;
/