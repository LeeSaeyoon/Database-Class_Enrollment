CREATE OR REPLACE PROCEDURE InsertCourse(professorId IN NUMBER,
	pCourseId IN VARCHAR2,
	pCourseIdNo IN NUMBER,
	pCourseName IN VARCHAR2,
	pCourseCredit IN NUMBER, /*pCourseUnit*/
	pCourseMaxPPL IN NUMBER, /*pCourseMax*/
	pTeachDay IN NUMBER, 
	pTeachHour IN NUMBER, /*pTeachTime*/
	pTeachRoom IN VARCHAR2, /*pTeachRoom*/
	re OUT VARCHAR2)
IS
	exist_already EXCEPTION; /*exist_course*/
	exist_already_for_prof EXCEPTION; /*professor_already_have_course*/
	exist_already_for_room EXCEPTION; /*where_already_have_course*/
	nYear NUMBER; 
	nSemester NUMBER;
	CourseFlag NUMBER; /*nCountCourse*/
	ProfCourseFlag NUMBER; /*nProfessorCourse*/
	RoomCourseFlag NUMBER; /*nWhereCourse*/
	CourseMake NUMBER; /*nExistCourse*/
BEGIN
	re := '';
	DBMS_OUTPUT.put_line('#');
	DBMS_OUTPUT.put_line(professorId || '님이 과목번호 ' || pCourseId ||
	', 분반 ' || TO_CHAR(pCourseIdNo) || '의 강의 개설을 요청하였습니다.');
	/* 년도, 학기 알아내기 */
	nYear := Date2EnrollYear(SYSDATE);
	nSemester := Date2EnrollSemester(SYSDATE);
/*예외1:이미있는수업 */
	SELECT count(*)
	INTO CourseFlag
	FROM teach
	WHERE c_id = pCourseId and c_no = pCourseIdNo and t_sem = nSemester and t_year = nYear;
	IF (CourseFlag>0)
	THEN
	RAISE exist_already;
	END IF;
/* 예외2 : 시간 요일 겹치는 경우(교수) */
	SELECT COUNT(*)
	INTO ProfCourseFlag
	FROM teach
	WHERE p_id=professorId and t_hour = pTeachHour and t_day = pTeachDay and t_sem = nSemester and t_year = nYear;
	IF (ProfCourseFlag > 0)
	THEN
	RAISE exist_already_for_prof;
	END IF;
/* 예외3 : 수업 장소에 같은 시간, 같은 요일에 강의 있는 경우 */
	SELECT count(*)
	INTO RoomCourseFlag
	FROM teach
	WHERE t_year= nYear and t_sem = nSemester
	and t_room = pTeachRoom and t_hour = pTeachHour and t_day = pTeachDay;
	IF (RoomCourseFlag>0)
	THEN
	RAISE exist_already_for_room;
	END IF;

/* 수업 등록 */
SELECT count(*)
INTO CourseMake
FROM course
WHERE c_id = pCourseId and c_no = pCourseIdNo;
IF (CourseMake<=0)
THEN
INSERT INTO course values(pCourseId, pCourseIdNo,pCourseCredit,pCourseName);
END IF;
INSERT INTO teach values(pCourseId, pCourseIdNo, professorId, nYear, nSemester, pTeachHour, pTeachDay, pCourseMaxPPL,
pTeachRoom);
COMMIT;
re := '수업 등록이 완료되었습니다.';
EXCEPTION
WHEN exist_already THEN
re := '이미 존재하는 분반 입니다. 다른 분반 번호를 입력하거나 다른 강의 번호를 입력해주세요.';
WHEN exist_already_for_prof THEN
re := '해당 시간은 이미 강의가 있습니다. 다른 시간이나 요일을 선택해주세요.';
WHEN exist_already_for_room THEN
re := '해당 장소에는 같은 시간에 다른 강의가 있습니다.';
WHEN OTHERS THEN
ROLLBACK;
re := SQLCODE;
END;
/