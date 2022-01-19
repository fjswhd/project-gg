drop table member;

select * from BOARD
select * from REQUEST
select * from PARTI

update request set accept = 'w'

delete from REQUEST
delete from Parti

delete from board where b_no > 5
update BOARD set content = '<h2>Hello World!</h2><p>안녕하세요! 저는 이대에서 국비지원 교육을 받고 있는 학생입니다.</p><p>이번 1월 말에 수료를 앞두고 있고 2월부터 본격적으로 취업을 위한 코딩테스트 준비를 생각 중입니다.</p><p>2월뿐 아니라 취업 전까지는 꾸준히 이어갈 생각입니다!</p><ul><li><p>자바, 스프링 우대</p></li><li><p>파이썬 환영</p></li><li><p>자바스크립트도 환영!</p></li></ul><p>관심있으신 분들은 어려워 마시고 댓글 남겨주세요!</p><p><br></p><p><a href="http://www.choongang.co.kr">중앙정보처리학원</a></p>' where b_no = 3;
update board set content = '<h3>놀러 가실 분!</h3><div contenteditable=\"false\"><hr></div><p>맛집 위주로 갈 겁니다!</p><p><a href=\"http://bootstrapk.com/\">놀러가자!</a></p>' where b_no = 4;
select * from member
delete from member where m_id = 'ejm4000@naver.com'
delete from member where m_id = 'fjswhd93@naver.com'
delete from member where m_id = 'fjswhd93@gmail.com'
delete from member where m_id = 'dlwhdals'

update member set reg_date = sysdate, nickname = '아빠상어', birthday = sysdate, place = '고양시', tag = '게임', picture = 'user.svg', rating = 0, admin = 'n', del = 'n' where m_id = 'dlwhdals'


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