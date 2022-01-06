drop table member;
create table member (
	m_id		varchar2(15)	primary key,
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
insert into MEMBER (m_id, password)
values ('dlwhdals', '1234');

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
