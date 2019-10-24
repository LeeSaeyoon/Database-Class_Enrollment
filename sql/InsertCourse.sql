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
	DBMS_OUTPUT.put_line(professorId || '���� �����ȣ ' || pCourseId ||
	', �й� ' || TO_CHAR(pCourseIdNo) || '�� ���� ������ ��û�Ͽ����ϴ�.');
	/* �⵵, �б� �˾Ƴ��� */
	nYear := Date2EnrollYear(SYSDATE);
	nSemester := Date2EnrollSemester(SYSDATE);
/*����1:�̹��ִ¼��� */
	SELECT count(*)
	INTO CourseFlag
	FROM teach
	WHERE c_id = pCourseId and c_no = pCourseIdNo and t_sem = nSemester and t_year = nYear;
	IF (CourseFlag>0)
	THEN
	RAISE exist_already;
	END IF;
/* ����2 : �ð� ���� ��ġ�� ���(����) */
	SELECT COUNT(*)
	INTO ProfCourseFlag
	FROM teach
	WHERE p_id=professorId and t_hour = pTeachHour and t_day = pTeachDay and t_sem = nSemester and t_year = nYear;
	IF (ProfCourseFlag > 0)
	THEN
	RAISE exist_already_for_prof;
	END IF;
/* ����3 : ���� ��ҿ� ���� �ð�, ���� ���Ͽ� ���� �ִ� ��� */
	SELECT count(*)
	INTO RoomCourseFlag
	FROM teach
	WHERE t_year= nYear and t_sem = nSemester
	and t_room = pTeachRoom and t_hour = pTeachHour and t_day = pTeachDay;
	IF (RoomCourseFlag>0)
	THEN
	RAISE exist_already_for_room;
	END IF;

/* ���� ��� */
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
re := '���� ����� �Ϸ�Ǿ����ϴ�.';
EXCEPTION
WHEN exist_already THEN
re := '�̹� �����ϴ� �й� �Դϴ�. �ٸ� �й� ��ȣ�� �Է��ϰų� �ٸ� ���� ��ȣ�� �Է����ּ���.';
WHEN exist_already_for_prof THEN
re := '�ش� �ð��� �̹� ���ǰ� �ֽ��ϴ�. �ٸ� �ð��̳� ������ �������ּ���.';
WHEN exist_already_for_room THEN
re := '�ش� ��ҿ��� ���� �ð��� �ٸ� ���ǰ� �ֽ��ϴ�.';
WHEN OTHERS THEN
ROLLBACK;
re := SQLCODE;
END;
/