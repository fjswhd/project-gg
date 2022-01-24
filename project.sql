

select * from BOARD
select * from REQUEST
select * from PARTI
select * from rating
select * from member

update parti
set ban = 'n'
where m_id = 'fjswhd93@hanmail.net'
and b_no = 106

delete from member where m_id = 'ejm4000@naver.com'

INSERT INTO MEMBER
VALUES ('admin@naver.com', '', sysdate, 'admin', sysdate, '알 수 없음', '알 수 없음', 'user.svg', 0.0, 'y', 'n')

update member
set picture = 'user.svg', admin = 'y'
where m_id = 'admin@naver.com'

create table category (
	c_no		number			primary key,
	c_name		varchar2(15)	not null
)
--카테고리 데이터 입력
INSERT INTO CATEGORY VALUES (10, '여행')
INSERT INTO CATEGORY VALUES (20, '식사')
INSERT INTO CATEGORY VALUES (30, '취미')
INSERT INTO CATEGORY VALUES (40, '스터디')
INSERT INTO CATEGORY VALUES (90, '기타')

drop table board
CREATE TABLE board (
	b_no 		number 			primary key,
	m_id						references member(m_id),
	c_no						references category(c_no),
	subject		varchar2(100)					not null,
	s_date		date							not null,
	e_date		date							not null,
	address		varchar2(300)					not null,
	content		varchar2(1500)					not null,
	m_count		number							not null,
	readcount	number			default 0		not null,
	reg_date	date			default sysdate	not null,
	end			char(1)			default 'n' 	not null,
	del			char(1)			default 'n'		not null
)


CREATE TABLE MEMBER (
	m_id		varchar2(30)	primary key,
	password 	varchar2(100)	not null,
	reg_date	date			not null,
	nickname	varchar2(15),
	birthday	date,
	place		varchar2(60),
	tag			varchar2(160),
	picture		varchar2(100),
	rating		number			default 0 		not null,
	admin		char(1)			default 'n'		not null,
	del			char(1)			default	'n'		not null
)



CREATE TABLE NOTICE (
	no_no		number			primary key,
	m_id						references MEMBER(m_id),
	subject		varchar2(100) 					not null,
	content 	varchar2(1500) 					not null,
	readcount 	number 			default 0 		not null,
	reg_date 	date			default sysdate not null,
	del			char(1) 		default 'n'		not null
)

CREATE TABLE NOTIFICATION (
	n_no		number			primary key,
	m_id						references MEMBER(m_id),
	content		varchar2(300)					not null,
	reg_date	date			default sysdate	not null,
	last_date	date			default sysdate	not null
)

CREATE TABLE RATING (
	r_no	number	primary key,
	m_id			references MEMBER(m_id), --평가 받는 사람
	b_no			references BOARD(b_no),
	r_score	number	not null,
	m_id_eval		references MEMBER(m_id)	--평가 하는 사람
)


CREATE TABLE REQUEST (
	b_no				references BOARD(b_no),
	m_id				references MEMBER(m_id),
	reg_date	date	default sysdate	not null,
	cancel		char(1)	default 'n'		not null,
	accept		char(1)	default	'n'		not null,
	primary key (b_no, m_id)
)

CREATE TABLE PARTI (
	b_no				references BOARD(b_no),
	m_id				references MEMBER(m_id),
	reg_date	date	default sysdate	not null,
	cancel		char(1)	default 'n'		not null,
	ban			char(1)	default	'n'		not null,
	primary key (b_no, m_id)
)

CREATE TABLE REPLY (
	re_no		number			primary key,
	b_no						references BOARD(b_no),
	m_id						references MEMBER(m_id),
	content		varchar2(300)					not null,
	re_ref		number							not null,
	re_step		number							not null,
	reg_date	date			default sysdate not null,
	secret		char(1)			default 'n' not null,
	del			char(1)			default 'n' not null
)

CREATE OR REPLACE VIEW my_board 
AS
	SELECT b.*, c.c_name, m.nickname, ROUND(r.r_score, 2) AS r_score
	FROM BOARD b, CATEGORY c, MEMBER m, (
		SELECT b1.b_no, avg(r_score) r_score
		FROM BOARD b1, RATING r1
		WHERE b1.m_id = r1.m_id (+)
		AND b1.b_no = r1.b_no (+)
		GROUP BY b1.b_no
	) r
	WHERE b.c_no = c.c_no 
	AND b.m_id = m.m_id
	AND b.b_no = r.b_no
	ORDER BY b.b_no DESC

CREATE OR REPLACE VIEW my_parti
AS
	SELECT p.*, m.nickname, b.m_id b_m_id, b.c_no, b.subject, b.s_date, b.e_date, b.end, b.del, c.c_name, ROUND(r.r_score, 2) AS r_score
	FROM parti p, member m, board b, category c, (
		SELECT p1.b_no, avg(r_score) r_score
		FROM PARTI p1, RATING r1
		WHERE p1.m_id = r1.m_id (+)
		AND p1.b_no = r1.b_no (+)
		GROUP BY p1.b_no
	) r
	WHERE p.m_id = m.m_id
	AND p.b_no = b.b_no
	AND p.b_no = r.b_no
	AND b.c_no = c.c_no
	ORDER BY p.reg_date DESC
	
select * from my_board;

select * from my_parti;


SELECT p1.b_no, avg(r_score) r_score
		FROM PARTI p1, RATING r1
		WHERE p1.m_id = r1.m_id (+)
		AND p1.b_no = r1.b_no (+)
		AND p1.m_id = 'fjswhd93@hanmail.net'
		GROUP BY p1.b_no

SELECT p.*, m.nickname, b.*, c.c_name, ROUND(r.r_score, 2) AS r_score
	FROM parti p, member m, board b, category c, (
		SELECT p1.b_no, avg(r_score) r_score
		FROM PARTI p1, RATING r1
		WHERE p1.m_id = r1.m_id (+)
		AND p1.b_no = r1.b_no (+)
		GROUP BY p1.b_no
	) r
	WHERE p.m_id = m.m_id
	AND p.b_no = b.b_no
	AND p.b_no = r.b_no
	AND b.c_no = c.c_no
	ORDER BY p.reg_date DESC;
	
SELECT * FROM RATING

SELECT avg(r_score)
FROM (
	SELECT B_NO, M_ID, AVG(R_SCORE) R_SCORE
	FROM RATING
	GROUP BY B_NO, M_ID
) 
where m_id = 'ejm4000@naver.com'


update member
set rating = 0

SELECT B_NO, M_ID, AVG(R_SCORE) R_SCORE
	FROM RATING
	GROUP BY B_NO, M_ID
	
update member
set picture = '099b122a-4a36-4a0a-b848-609d55dbf46e.jpg'
where m_id = 'fjswhd93@naver.com'