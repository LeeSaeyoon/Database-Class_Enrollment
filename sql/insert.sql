--데이터 insert 시험

INSERT INTO students VALUES (1411111, '12345', '유은지', '소프트웨어학부', '경기도 안양시', 'ejyoo@naver.com');



INSERT INTO professor VALUES (0411111, '12345', '심준호', '소프트웨어학부', 'jhshim@sookmyung.ac.kr');

INSERT INTO COURSE VALUES ('C111', 1, 3, '데이터베이스프로그래밍');

INSERT INTO TEACH VALUES ('C111', 1, 0411111, 2018, 1, 12, 3, 50, '명신관311A');

INSERT INTO enroll VALUES ('1411111', 'C111', 1, 2018, 1);
commit;


INSERT INTO students VALUES (1411111, '12345', '유은지', '소프트웨어학부', '경기도 안양시', 'ejyoo@naver.com');

INSERT INTO students VALUES (1411111, '12345', '양여명', '소프트웨어학부', '경기도 안양시', 'abc@naver.com');
INSERT INTO students VALUES (2222222, '12345', '이보현', '소프트웨어학부', '경기도 안양시', 'def@naver.com');
INSERT INTO students VALUES (3333333, '12345', '양유정', '소프트웨어학부', '경기도 안양시', 'ghi@naver.com');





INSERT INTO professor VALUES (0411111, '12345', '심준호', '소프트웨어학부', 'jhshim@sookmyung.ac.kr');
INSERT INTO professor VALUES (9111111, '12345', '김철수', '소프트웨어학부', 'aaabb@sookmyung.ac.kr');
INSERT INTO professor VALUES (0222222, '12345', '안영희', '소프트웨어학부', 'jccd@sookmyung.ac.kr');
INSERT INTO professor VALUES (0333333, '12345', '강동원', '소프트웨어학부', 'ggss@sookmyung.ac.kr');
INSERT INTO professor VALUES (4222222, '12345', '이기용', '소프트웨어학부', 'ggggs@sookmyung.ac.kr');


INSERT INTO professor VALUES (6555555, '12345', '데이빗', '소프트웨어학부', 'ggss@sookmyung.ac.kr');
INSERT INTO professor VALUES (6666666, '12345', '아베', '소프트웨어학부', 'ggss@sookmyung.ac.kr');
INSERT INTO professor VALUES (6777777, '12345', '시진퐁퐁', '소프트웨어학부', 'ggss@sookmyung.ac.kr');

commit;


