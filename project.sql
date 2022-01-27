--$2a$10$pWfgZ78Fpc4ZOG2lrcdByuvTKDYKG0IR5h7vAAwYU8eu8jX.0Tmm.

INSERT INTO MEMBER VALUES ('admin@naver.com', '', sysdate, 'admin', sysdate, '알 수 없음', '알 수 없음', 'user.svg', 0.0, 'y', 'n');
update member set picture = 'user.svg', admin = 'y' where m_id = 'admin@naver.com';

INSERT INTO MEMBER VALUES ('a@a.com', '$2a$10$pWfgZ78Fpc4ZOG2lrcdByuvTKDYKG0IR5h7vAAwYU8eu8jX.0Tmm.', sysdate, '같가', sysdate, '알 수 없음', '알 수 없음', 'user.svg', 0.0, 'n', 'n');
INSERT INTO MEMBER VALUES ('b@b.com', '$2a$10$pWfgZ78Fpc4ZOG2lrcdByuvTKDYKG0IR5h7vAAwYU8eu8jX.0Tmm.', sysdate, '은영짱짱', sysdate, '고덕이 좋아요', '맛있는거 짱짱', 'user.svg', 0.0, 'n', 'n');
INSERT INTO MEMBER VALUES ('c@c.com', '$2a$10$pWfgZ78Fpc4ZOG2lrcdByuvTKDYKG0IR5h7vAAwYU8eu8jX.0Tmm.', sysdate, '종민쿤', sysdate, '고양시', '맛집찾기 좋아요', 'user.svg', 0.0, 'n', 'n');
INSERT INTO MEMBER VALUES ('d@d.com', '$2a$10$pWfgZ78Fpc4ZOG2lrcdByuvTKDYKG0IR5h7vAAwYU8eu8jX.0Tmm.', sysdate, '지선양', sysdate, '연희', '축구 같이 보러 가실 분 찾아용', 'user.svg', 0.0, 'n', 'n');
INSERT INTO MEMBER VALUES ('e@e.com', '$2a$10$pWfgZ78Fpc4ZOG2lrcdByuvTKDYKG0IR5h7vAAwYU8eu8jX.0Tmm.', sysdate, '윤석사마', sysdate, '아현', '함께 몸 만드실 분?', 'user.svg', 0.0, 'n', 'n');
INSERT INTO MEMBER VALUES ('f@f.com', '$2a$10$pWfgZ78Fpc4ZOG2lrcdByuvTKDYKG0IR5h7vAAwYU8eu8jX.0Tmm.', sysdate, '주니센세', sysdate, '알 수 없음', '알 수 없음', 'user.svg', 0.0, 'n', 'n');

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
	

SELECT avg(r_score)
FROM (
	SELECT B_NO, M_ID, AVG(R_SCORE) R_SCORE
	FROM RATING
	GROUP BY B_NO, M_ID
) 
where m_id = 'ejm4000@naver.com'

select * from board order by b_no desc
delete from board where b_no = 1;

insert into parti values ('22', 'c@c.com', to_date('2022-01-20', 'yyyy-mm-dd'), 'n', 'n');
insert into parti values ('22', 'd@d.com', to_date('2022-01-20', 'yyyy-mm-dd'), 'n', 'n');
insert into parti values ('23', 'c@c.com', to_date('2022-01-20', 'yyyy-mm-dd'), 'n', 'n');
insert into parti values ('23', 'd@d.com', to_date('2022-01-20', 'yyyy-mm-dd'), 'n', 'n');
insert into parti values ('24', 'c@c.com', to_date('2022-01-20', 'yyyy-mm-dd'), 'n', 'n');
insert into parti values ('24', 'd@d.com', to_date('2022-01-20', 'yyyy-mm-dd'), 'n', 'n');
insert into parti values ('25', 'c@c.com', to_date('2022-01-20', 'yyyy-mm-dd'), 'n', 'n');
insert into parti values ('25', 'd@d.com', to_date('2022-01-20', 'yyyy-mm-dd'), 'n', 'n');
insert into parti values ('26', 'c@c.com', to_date('2022-01-20', 'yyyy-mm-dd'), 'n', 'n');
insert into parti values ('26', 'd@d.com', to_date('2022-01-20', 'yyyy-mm-dd'), 'n', 'n');
insert into parti values ('27', 'c@c.com', to_date('2022-01-20', 'yyyy-mm-dd'), 'n', 'n');
insert into parti values ('27', 'd@d.com', to_date('2022-01-20', 'yyyy-mm-dd'), 'n', 'n');
insert into parti values ('28', 'c@c.com', to_date('2022-01-20', 'yyyy-mm-dd'), 'n', 'n');
insert into parti values ('28', 'd@d.com', to_date('2022-01-20', 'yyyy-mm-dd'), 'n', 'n');
insert into parti values ('29', 'c@c.com', to_date('2022-01-20', 'yyyy-mm-dd'), 'n', 'n');
insert into parti values ('29', 'd@d.com', to_date('2022-01-20', 'yyyy-mm-dd'), 'n', 'n');
insert into parti values ('30', 'c@c.com', to_date('2022-01-20', 'yyyy-mm-dd'), 'n', 'n');
insert into parti values ('30', 'd@d.com', to_date('2022-01-20', 'yyyy-mm-dd'), 'n', 'n');
insert into parti values ('31', 'c@c.com', to_date('2022-01-20', 'yyyy-mm-dd'), 'n', 'n');
insert into parti values ('31', 'd@d.com', to_date('2022-01-20', 'yyyy-mm-dd'), 'n', 'n');
insert into parti values ('32', 'c@c.com', to_date('2022-01-20', 'yyyy-mm-dd'), 'n', 'n');
insert into parti values ('32', 'd@d.com', to_date('2022-01-20', 'yyyy-mm-dd'), 'n', 'n');
insert into parti values ('33', 'c@c.com', to_date('2022-01-20', 'yyyy-mm-dd'), 'n', 'n');
insert into parti values ('33', 'd@d.com', to_date('2022-01-20', 'yyyy-mm-dd'), 'n', 'n');
insert into parti values ('34', 'c@c.com', to_date('2022-01-20', 'yyyy-mm-dd'), 'n', 'n');
insert into parti values ('34', 'd@d.com', to_date('2022-01-20', 'yyyy-mm-dd'), 'n', 'n');
insert into parti values ('35', 'b@b.com', to_date('2022-01-20', 'yyyy-mm-dd'), 'n', 'n');
insert into parti values ('35', 'd@d.com', to_date('2022-01-20', 'yyyy-mm-dd'), 'n', 'n');
insert into parti values ('36', 'b@b.com', to_date('2022-01-20', 'yyyy-mm-dd'), 'n', 'n');
insert into parti values ('36', 'd@d.com', to_date('2022-01-20', 'yyyy-mm-dd'), 'n', 'n');
insert into parti values ('37', 'b@b.com', to_date('2022-01-20', 'yyyy-mm-dd'), 'n', 'n');
insert into parti values ('37', 'd@d.com', to_date('2022-01-20', 'yyyy-mm-dd'), 'n', 'n');
insert into parti values ('38', 'b@b.com', to_date('2022-01-20', 'yyyy-mm-dd'), 'n', 'n');
insert into parti values ('38', 'd@d.com', to_date('2022-01-20', 'yyyy-mm-dd'), 'n', 'n');
insert into parti values ('39', 'b@b.com', to_date('2022-01-20', 'yyyy-mm-dd'), 'n', 'n');
insert into parti values ('39', 'd@d.com', to_date('2022-01-20', 'yyyy-mm-dd'), 'n', 'n');
insert into parti values ('40', 'b@b.com', to_date('2022-01-20', 'yyyy-mm-dd'), 'n', 'n');
insert into parti values ('40', 'd@d.com', to_date('2022-01-20', 'yyyy-mm-dd'), 'n', 'n');
insert into parti values ('41', 'b@b.com', to_date('2022-01-20', 'yyyy-mm-dd'), 'n', 'n');
insert into parti values ('41', 'd@d.com', to_date('2022-01-20', 'yyyy-mm-dd'), 'n', 'n');
insert into parti values ('42', 'b@b.com', to_date('2022-01-20', 'yyyy-mm-dd'), 'n', 'n');
insert into parti values ('42', 'd@d.com', to_date('2022-01-20', 'yyyy-mm-dd'), 'n', 'n');
insert into parti values ('43', 'b@b.com', to_date('2022-01-20', 'yyyy-mm-dd'), 'n', 'n');
insert into parti values ('43', 'd@d.com', to_date('2022-01-20', 'yyyy-mm-dd'), 'n', 'n');
insert into parti values ('44', 'b@b.com', to_date('2022-01-20', 'yyyy-mm-dd'), 'n', 'n');
insert into parti values ('44', 'd@d.com', to_date('2022-01-20', 'yyyy-mm-dd'), 'n', 'n');

delete from reply where b_no = 17

select * from reply where b_no = 17


insert into board values ('22', 'b@b.com', '10', '전주 여행 가실 분 22', to_date('2022-01-22', 'yyyy-mm-dd'), to_date('2022-01-23', 'yyyy-mm-dd'), '한국도로공사 전주수목원(전북 전주시 덕진구 반월동 848-23)', '<p>같이 가실 분</p>', 3, 0, to_date('2022-01-22', 'yyyy-mm-dd'), 'n', 'n')
insert into board values ('23', 'b@b.com', '10', '전주 여행 가실 분 23', to_date('2022-01-22', 'yyyy-mm-dd'), to_date('2022-01-23', 'yyyy-mm-dd'), '경기전(전북 전주시 완산구 풍남동3가 102)', '<p>같이 가실 분</p>', 3, 0, to_date('2022-01-22', 'yyyy-mm-dd'), 'n', 'n')
insert into board values ('24', 'b@b.com', '10', '전주 여행 가실 분 24', to_date('2022-01-22', 'yyyy-mm-dd'), to_date('2022-01-23', 'yyyy-mm-dd'), '전주한옥마을(전북 전주시 완산구 풍남동3가 64-1)', '<p>같이 가실 분</p>', 3, 0, to_date('2022-01-22', 'yyyy-mm-dd'), 'n', 'n')
insert into board values ('25', 'b@b.com', '10', '전주 여행 가실 분 25', to_date('2022-01-22', 'yyyy-mm-dd'), to_date('2022-01-23', 'yyyy-mm-dd'), '전주한옥마을(전북 전주시 완산구 풍남동3가 64-1)', '<p>같이 가실 분</p>', 3, 0, to_date('2022-01-22', 'yyyy-mm-dd'), 'n', 'n');
insert into board values ('26', 'b@b.com', '10', '전주 여행 가실 분 26', to_date('2022-01-22', 'yyyy-mm-dd'), to_date('2022-01-23', 'yyyy-mm-dd'), '전주한옥마을(전북 전주시 완산구 풍남동3가 64-1)', '<p>같이 가실 분</p>', 3, 0, to_date('2022-01-22', 'yyyy-mm-dd'), 'n', 'n');
insert into board values ('27', 'b@b.com', '10', '전주 여행 가실 분 27', to_date('2022-01-22', 'yyyy-mm-dd'), to_date('2022-01-23', 'yyyy-mm-dd'), '전주한옥마을(전북 전주시 완산구 풍남동3가 64-1)', '<p>같이 가실 분</p>', 3, 0, to_date('2022-01-22', 'yyyy-mm-dd'), 'n', 'n');
insert into board values ('28', 'b@b.com', '10', '전주 여행 가실 분 28', to_date('2022-01-22', 'yyyy-mm-dd'), to_date('2022-01-23', 'yyyy-mm-dd'), '전주한옥마을(전북 전주시 완산구 풍남동3가 64-1)', '<p>같이 가실 분</p>', 3, 0, to_date('2022-01-22', 'yyyy-mm-dd'), 'n', 'n');
insert into board values ('29', 'b@b.com', '10', '전주 여행 가실 분 29', to_date('2022-01-22', 'yyyy-mm-dd'), to_date('2022-01-23', 'yyyy-mm-dd'), '전주한옥마을(전북 전주시 완산구 풍남동3가 64-1)', '<p>같이 가실 분</p>', 3, 0, to_date('2022-01-22', 'yyyy-mm-dd'), 'n', 'n');
insert into board values ('30', 'b@b.com', '10', '전주 여행 가실 분 30', to_date('2022-01-22', 'yyyy-mm-dd'), to_date('2022-01-23', 'yyyy-mm-dd'), '전주한옥마을(전북 전주시 완산구 풍남동3가 64-1)', '<p>같이 가실 분</p>', 3, 0, to_date('2022-01-22', 'yyyy-mm-dd'), 'n', 'n');
insert into board values ('31', 'b@b.com', '10', '전주 여행 가실 분 31', to_date('2022-01-24', 'yyyy-mm-dd'), to_date('2022-01-26', 'yyyy-mm-dd'), '전주한옥마을(전북 전주시 완산구 풍남동3가 64-1)', '<p>같이 가실 분</p>', 3, 0, to_date('2022-01-22', 'yyyy-mm-dd'), 'n', 'n');
insert into board values ('32', 'b@b.com', '10', '전주 여행 가실 분 32', to_date('2022-01-24', 'yyyy-mm-dd'), to_date('2022-01-26', 'yyyy-mm-dd'), '전주한옥마을(전북 전주시 완산구 풍남동3가 64-1)', '<p>같이 가실 분</p>', 3, 0, to_date('2022-01-22', 'yyyy-mm-dd'), 'n', 'n');
insert into board values ('33', 'b@b.com', '10', '전주 여행 가실 분 33', to_date('2022-01-29', 'yyyy-mm-dd'), to_date('2022-01-30', 'yyyy-mm-dd'), '전주한옥마을(전북 전주시 완산구 풍남동3가 64-1)', '<p>같이 가실 분</p>', 3, 0, to_date('2022-01-22', 'yyyy-mm-dd'), 'n', 'n');
insert into board values ('34', 'b@b.com', '10', '전주 여행 가실 분 34', to_date('2022-01-29', 'yyyy-mm-dd'), to_date('2022-01-30', 'yyyy-mm-dd'), '전주한옥마을(전북 전주시 완산구 풍남동3가 64-1)', '<p>같이 가실 분</p>', 3, 0, to_date('2022-01-22', 'yyyy-mm-dd'), 'n', 'n');
insert into board values ('35', 'c@c.com', '40', '코딩 스터디 하실 분 35', to_date('2022-01-22', 'yyyy-mm-dd'), to_date('2022-01-23', 'yyyy-mm-dd'), '플랜에이스터디카페 이대이화센터(서울 서대문구 대현동 37-1)', '<p>같이 하실 분</p>', 3, 0, to_date('2022-01-22', 'yyyy-mm-dd'), 'n', 'n');
insert into board values ('36', 'c@c.com', '40', '코딩 스터디 하실 분 36', to_date('2022-01-22', 'yyyy-mm-dd'), to_date('2022-01-23', 'yyyy-mm-dd'), '플랜에이스터디카페 이대이화센터(서울 서대문구 대현동 37-1)', '<p>같이 하실 분</p>', 3, 0, to_date('2022-01-22', 'yyyy-mm-dd'), 'n', 'n');
insert into board values ('37', 'c@c.com', '40', '코딩 스터디 하실 분 37', to_date('2022-01-22', 'yyyy-mm-dd'), to_date('2022-01-23', 'yyyy-mm-dd'), '플랜에이스터디카페 이대이화센터(서울 서대문구 대현동 37-1)', '<p>같이 하실 분</p>', 3, 0, to_date('2022-01-22', 'yyyy-mm-dd'), 'n', 'n');
insert into board values ('38', 'c@c.com', '40', '코딩 스터디 하실 분 38', to_date('2022-01-22', 'yyyy-mm-dd'), to_date('2022-01-23', 'yyyy-mm-dd'), '플랜에이스터디카페 이대이화센터(서울 서대문구 대현동 37-1)', '<p>같이 하실 분</p>', 3, 0, to_date('2022-01-22', 'yyyy-mm-dd'), 'n', 'n');
insert into board values ('39', 'c@c.com', '40', '코딩 스터디 하실 분 39', to_date('2022-01-22', 'yyyy-mm-dd'), to_date('2022-01-23', 'yyyy-mm-dd'), '플랜에이스터디카페 이대이화센터(서울 서대문구 대현동 37-1)', '<p>같이 하실 분</p>', 3, 0, to_date('2022-01-22', 'yyyy-mm-dd'), 'n', 'n');
insert into board values ('40', 'c@c.com', '40', '코딩 스터디 하실 분 40', to_date('2022-01-22', 'yyyy-mm-dd'), to_date('2022-01-23', 'yyyy-mm-dd'), '플랜에이스터디카페 이대이화센터(서울 서대문구 대현동 37-1)', '<p>같이 하실 분</p>', 3, 0, to_date('2022-01-22', 'yyyy-mm-dd'), 'n', 'n');
insert into board values ('41', 'c@c.com', '40', '코딩 스터디 하실 분 41', to_date('2022-01-22', 'yyyy-mm-dd'), to_date('2022-01-23', 'yyyy-mm-dd'), '플랜에이스터디카페 이대이화센터(서울 서대문구 대현동 37-1)', '<p>같이 하실 분</p>', 3, 0, to_date('2022-01-22', 'yyyy-mm-dd'), 'n', 'n');
insert into board values ('42', 'c@c.com', '40', '코딩 스터디 하실 분 42', to_date('2022-01-22', 'yyyy-mm-dd'), to_date('2022-01-23', 'yyyy-mm-dd'), '플랜에이스터디카페 이대이화센터(서울 서대문구 대현동 37-1)', '<p>같이 하실 분</p>', 3, 0, to_date('2022-01-22', 'yyyy-mm-dd'), 'n', 'n');
insert into board values ('43', 'c@c.com', '40', '코딩 스터디 하실 분 43', to_date('2022-01-22', 'yyyy-mm-dd'), to_date('2022-01-23', 'yyyy-mm-dd'), '플랜에이스터디카페 이대이화센터(서울 서대문구 대현동 37-1)', '<p>같이 하실 분</p>', 3, 0, to_date('2022-01-22', 'yyyy-mm-dd'), 'n', 'n');
insert into board values ('44', 'c@c.com', '40', '코딩 스터디 하실 분 44', to_date('2022-01-22', 'yyyy-mm-dd'), to_date('2022-01-23', 'yyyy-mm-dd'), '플랜에이스터디카페 이대이화센터(서울 서대문구 대현동 37-1)', '<p>같이 하실 분</p>', 3, 0, to_date('2022-01-22', 'yyyy-mm-dd'), 'n', 'n');
insert into board values ('45', 'c@c.com', '40', '코딩 스터디 하실 분 45', to_date('2022-01-25', 'yyyy-mm-dd'), to_date('2022-01-26', 'yyyy-mm-dd'), '플랜에이스터디카페 이대이화센터(서울 서대문구 대현동 37-1)', '<p>같이 하실 분</p>', 3, 0, to_date('2022-01-22', 'yyyy-mm-dd'), 'n', 'n');
insert into board values ('46', 'c@c.com', '40', '코딩 스터디 하실 분 46', to_date('2022-01-29', 'yyyy-mm-dd'), to_date('2022-01-30', 'yyyy-mm-dd'), '플랜에이스터디카페 이대이화센터(서울 서대문구 대현동 37-1)', '<p>같이 하실 분</p>', 3, 0, to_date('2022-01-22', 'yyyy-mm-dd'), 'n', 'n');
insert into board values ('47', 'c@c.com', '40', '코딩 스터디 하실 분 47', to_date('2022-01-29', 'yyyy-mm-dd'), to_date('2022-01-30', 'yyyy-mm-dd'), '플랜에이스터디카페 이대이화센터(서울 서대문구 대현동 37-1)', '<p>같이 하실 분</p>', 3, 0, to_date('2022-01-22', 'yyyy-mm-dd'), 'n', 'n');