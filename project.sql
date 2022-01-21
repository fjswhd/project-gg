

select * from BOARD
select * from REQUEST
select * from PARTI
select * from rating
select * from member

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


select a2.*
from (
	select rownum rn, a1.*
	from (
		select b.*, c.c_name, m.nickname
		from board b, CATEGORY c, MEMBER m
		where b.c_no = c.c_no
		and b.m_id = m.m_id
		order by b_no desc
	) a1
) a2
where rn between '1' and '10'

		and s_date <= to_date('2022-02-01', 'yyyy-mm-dd')
		and to_date('2022-02-01', 'yyyy-mm-dd') <= e_date
		and b.c_no = '40'
		and address like '%'||'서울'||'%'
		and (subject like '%'||'코딩'||'%' or content like '%'||'코딩'||'%')