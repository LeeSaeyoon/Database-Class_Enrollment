# 수강 신청 시스템
Class enrollment


## DB 설계도
-	STUDENTS 테이블
: s_id[학번]을 PRIMARY KEY로 갖는다.
그 외에 s_pwd[비밀번호], s_major[전공]을 갖는다.
-	ENROLL 테이블
: s_id[학번], c_id[과목번호]를 각각 STUDENTS 테이블과 CLASS 테이블을 참조하는 FOREIGN KEY로 갖는다.
-	ADMINISTER 테이블
: a_id[관리자ID]를 PRIMARY KEY로 갖는다.
그 외에 a_pwd[관리자 비밀번호]를 갖는다.
-	CLASS 테이블
: c_id[과목ID]를 PRIMARY KEY로 갖는다.
a_id[관리자ID]를 FOREIGN KEY로 갖는다.
그 외에 c_no[과목번호], c_name[과목명], c_div[분반], c_credit[학점], c_hour[강의시간(교시)], c_day[강의요일], c_year[수강연도], c_sem[수강학기], c_maxppl[수강정원], c_where[장소]를 갖는다.
