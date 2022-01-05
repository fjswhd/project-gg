create table member (
	m_id		varchar2(15)	primary key,
	password	varchar2(100)					not null,
	email		varchar2(30)					not null,
	reg_date	date			default sysdate	not null,
	nickname	varchar2(15),
	birthday	date,
	place		varchar2(60),
	tag			varchar2(160),
	picture		varchar2(100),
	rating		number			default 0.0 	not null,
	admin		char(1)			default 'n' 	not null
)

create table category (
	c_no		number			primary key,
	c_name		varchar2(15)	not null
)

CREATE TABLE board (
	b_no 		number 			primary key,
	m_id						references member(m_id),
	c_no						references category(c_no),
	subject		varchar2(100)					not null,
	s_date		date							not null,
	e_date		date							not null,
	address		varchar2(300)					not null,
	content		varchar2(1500)					not null,
	member_cnt	number							not null,
	end			char(1)			default 'n' 	not null,
	readcount	number			default 0		not null,
	reg_date	date			default sysdate	not null
)

--카테고리 데이터 입력
INSERT INTO CATEGORY VALUES (10, '여행')
INSERT INTO CATEGORY VALUES (20, '식사')
INSERT INTO CATEGORY VALUES (30, '취미')
INSERT INTO CATEGORY VALUES (40, '스터디')
INSERT INTO CATEGORY VALUES (90, '기타')
