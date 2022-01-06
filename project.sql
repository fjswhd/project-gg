drop table member cascade constraints;
create table member (
    m_id            VARCHAR2(30)        primary key,
    password        VARCHAR2(100)       not null, 
    reg_date        date                default sysdate,
    nickname        VARCHAR2(15),
    birthday        date,
    place           VARCHAR2(60),
    tag             varchar2(160),
    picture         varchar2(100),
    rating          number              default 0.0,
    admin           char(1)             default 'n'         check (admin in ('y', 'n')),
    del             char(1)             default 'n'         check (del in ('y', 'n'))
);

select * from member;


drop table notice cascade constraints;
create table notice (
    no_no           number                      primary key,
    m_id            REFERENCES member(m_id),
    subject         varchar2(100)               not null,
    content         varchar2(1500)              not null,
    readcount       number                      default 0,
    reg_date        date                        default sysdate,
    del             char(1)                     default 'n'         check (del in ('y', 'n'))
);



drop table notification cascade constraints;
create table notification (
    n_no            number                      primary key,
    m_id            REFERENCES member(m_id),        
    content         varchar2(300)               not null,
    reg_date        date                        default sysdate,
    last_date       date                        default sysdate
);



drop table category cascade constraints;
create table category (
    c_no            number                     primary key,
    c_name          varchar2(15)               not null
);



drop table board cascade constraints;
create table board (
    b_no            number                      primary key, 
    m_id            REFERENCES member(m_id),
    c_no            REFERENCES category(c_no),          
    subject         varchar2(100)               not null,
    s_date          date                        not null,
    e_date          date                        not null,
    address         varchar2(300)               not null,
    content         varchar2(1500)              not null,
    m_count      number                      not null,
    readcount       number                      default 0,
    reg_date        date                        default sysdate,
    end             char(1)                     default 'n'         check (end in ('y', 'n')),
    del             char(1)                     default 'n'         check (del in ('y', 'n'))
);



drop table request cascade constraints;
create table request (
    b_no            REFERENCES board(b_no),                      
    m_id            REFERENCES member(m_id),
    reg_date        date                        default sysdate,
    cancel          char(1)                     default 'n'         check (cancel in ('y', 'n')),
    accept          char(1)                     default 'n'         check (accept in ('y', 'n'))
);



drop table parti cascade constraints;
create table parti (
    b_no            REFERENCES board(b_no),                      
    m_id            REFERENCES member(m_id),
    reg_date        date                        default sysdate,
    cancel          char(1)                     default 'n'         check (cancel in ('y', 'n')),
    ban             char(1)                     default 'n'         check (ban in ('y', 'n'))
);

        

drop table reply cascade constraints;
create table reply (
    re_no           number                      primary key,
    b_no            REFERENCES board(b_no),                      
    m_id            REFERENCES member(m_id),
    content         varchar2(300)               not null, 
    re_ref          number                      not null,
    re_step         number                      not null,
    reg_date        date                        default sysdate,
    secret          char(1)                     default 'n'         check (secret in ('y', 'n')),
    del             char(1)                     default 'n'         check (del in ('y', 'n'))
);



drop table rating cascade constraints;
create table rating (
    r_no            number                      primary key,
    m_id            REFERENCES member(m_id),
    b_no            REFERENCES board(b_no),                      
    r_score         number                      default 0
);