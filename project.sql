drop table member;
create table member (
	m_id		varchar2(30)	primary key,
	password	varchar2(100)					not null,
	reg_date	date			default sysdate	not null,
	nickname	varchar2(15),
	birthday	date,
	place		varchar2(60),
	tag			varchar2(160),
	picture		varchar2(100),
	rating		number			default 0.0 	not null,
	admin		char(1)			default 'n' 	not null,
	del			char(1)			default 'n' 	not null
)


select * from member
delete from member where m_id = 'ejm4000@naver.com'
delete from member where m_id = '123'

insert into MEMBER (m_id, password)
values ('dlwhdals', '1234');

delete from member where m_id = ''
create table category (
	c_no		number			primary key,
	c_name		varchar2(15)	not null
)

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

--카테고리 데이터 입력
INSERT INTO CATEGORY VALUES (10, '여행')
INSERT INTO CATEGORY VALUES (20, '식사')
INSERT INTO CATEGORY VALUES (30, '취미')
INSERT INTO CATEGORY VALUES (40, '스터디')
INSERT INTO CATEGORY VALUES (90, '기타')

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
	m_id			references MEMBER(m_id),
	b_no			references BOARD(b_no),
	r_score	number	not null
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

insert into reply values ('1', '1', 'dlwhdals', '안녕하세요.', 0, 0, sysdate, 'n', 'n')
insert into reply values ('2', '1', 'dlwhdals', '안녕하세요.2', 0, 0, sysdate, 'n', 'n')
insert into reply values ('3', '1', 'dlwhdals', '안녕하세요.3', 0, 0, sysdate, 'y', 'n')
insert into reply values ('4', '1', 'dlwhdals', '안녕하세요.3', 0, 0, sysdate, 'n', 'y')

SELECT re.*, b.*   FROM REPLY re, BOARD b   WHERE b_no = '1'   AND re.b_no = b.b_no