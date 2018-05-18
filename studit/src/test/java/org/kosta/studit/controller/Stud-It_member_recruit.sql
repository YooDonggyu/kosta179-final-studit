
drop table member cascade constraints;
﻿--회원
CREATE TABLE member
(
    member_email varchar2(100) primary key, 
    password varchar2(100) not null, 
    name varchar2(100) not null, 
    addr varchar2(100) not null, 
    phone varchar2(100) not null, 
    regdate DATE not null, 
    password_hint varchar2(100) not null, 
    password_answer varchar2(100) not null, 
    pic_path varchar2(100) 
)

insert into member(member_email,password,name,addr,phone,regdate,password_hint,password_answer,pic_path) 
values('a@a.com','1','아이유','판교','010-1234-5678',sysdate,'내 나이는?','25','');
insert into member(member_email,password,name,addr,phone,regdate,password_hint,password_answer,pic_path) 
values('b@b.com','2','가','서울','010-2143-1566',sysdate,'1?','2','');
insert into member(member_email,password,name,addr,phone,regdate,password_hint,password_answer,pic_path) 
values('c@c.com','3','나','대전','010-1684-8832',sysdate,'2?','3','');
insert into member(member_email,password,name,addr,phone,regdate,password_hint,password_answer,pic_path) 
values('d@d.com','4','다','대구','010-9562-8465',sysdate,'3?','4','');
insert into member(member_email,password,name,addr,phone,regdate,password_hint,password_answer,pic_path) 
values('tico99@naver.com','1234','admin','유스페이스','010-5648-8978',sysdate,'코스타','179기','');
insert into member(member_email,password,name,addr,phone,regdate,password_hint,password_answer,pic_path) 
values('e@e.com','5','다','대구','010-5562-8465',sysdate,'3?','4','');


select *from member

drop table member_position
--직책
CREATE TABLE member_position
(
	member_position_no number  primary key ,
	name varchar2(100)  not null ,
	member_email varchar2(100)  not null,
	constraint fk_member_email foreign key(member_email) references member(member_email)
)
drop sequence member_position_no_seq;
create sequence member_position_no_seq nocache;

insert into MEMBER_POSITION(member_position_no,name,member_email) 
values(member_position_no_seq.nextval,'관리자','tico99@naver.com');
insert into MEMBER_POSITION(member_position_no,name,member_email) 
values(member_position_no_seq.nextval,'회원','a@a.com');
insert into MEMBER_POSITION(member_position_no,name,member_email) 
values(member_position_no_seq.nextval,'회원','b@b.com');
insert into MEMBER_POSITION(member_position_no,name,member_email) 
values(member_position_no_seq.nextval,'회원','c@c.com');
insert into MEMBER_POSITION(member_position_no,name,member_email) 
values(member_position_no_seq.nextval,'회원','d@d.com');







--검색 키워드
create table search_keyword(
	keyword varchar2(100) primary key,
	hit number default 0
)

--대분류
CREATE TABLE big_category
(
	big_category_no number primary key ,
	name varchar2(100) not null 
)

create sequence big_category_no_seq nocache;

insert into big_category(big_category_no,name) values(big_category_no_seq.nextval,'취업');
insert into big_category(big_category_no,name) values(big_category_no_seq.nextval,'어학');
insert into big_category(big_category_no,name) values(big_category_no_seq.nextval,'프로그래밍');
insert into big_category(big_category_no,name) values(big_category_no_seq.nextval,'자기계발');
insert into big_category(big_category_no,name) values(big_category_no_seq.nextval,'기타');


--소분류
CREATE TABLE small_category
(
	small_category_no number  primary key ,
	name varchar2(100) not null ,
	big_category_no number not null ,
	constraint fk_big_category_no foreign key(big_category_no) references big_category(big_category_no)
);

create sequence small_category_no_seq nocache;

insert into small_category(small_category_no,name,big_category_no) 
values(small_category_no_seq.nextval,'대기업','1');
insert into small_category(small_category_no,name,big_category_no) 
values(small_category_no_seq.nextval,'영어','2');
insert into small_category(small_category_no,name,big_category_no) 
values(small_category_no_seq.nextval,'JAVA','3');
insert into small_category(small_category_no,name,big_category_no) 
values(small_category_no_seq.nextval,'인문학','4');

select s.small_category_no, s.name as 소분류, b.name as 대분류
from small_category s, big_category b
where s.big_category_no=b.big_category_no

--모집 게시글
CREATE TABLE recruit_post
(
	recruit_post_no number primary key ,
	title varchar2(100) not null ,
	content clob not null ,
	regdate date not null ,
	hit number default 0,
	condition varchar2(50) not null ,
	capacity number not null ,
	member_email varchar2(100) not null ,
	small_category_no number not null ,
	location varchar2(100) not null,
	constraint fk_small_category_no foreign key(small_category_no) references small_category(small_category_no),
	constraint fk2_member_email foreign key(member_email) references member(member_email)
);
create sequence recruit_post_no_seq nocache;



insert into recruit_post (recruit_post_no,title,content,regdate,condition,capacity,member_email,small_category_no,location) 
values(recruit_post_no_seq.nextval,'Hello, everyone! Lets go to study!','11111',sysdate,'모집중',6,'a@a.com',3,'강남');
insert into recruit_post (recruit_post_no,title,content,regdate,condition,capacity,member_email,small_category_no,location) 
values(recruit_post_no_seq.nextval,'Are you crazy?','22222',sysdate,'모집완료',4,'b@b.com',1,'종로');

--모집 요일 선택
CREATE TABLE recruit_day
(
	recruit_day_no number primary key ,
	day varchar(50) not null, 
	recruit_post_no not null,
	constraint fk_recruit_post_no foreign key(recruit_post_no) references recruit_post(recruit_post_no)
);
create sequence recruit_day_no_seq nocache;

insert into recruit_day(recruit_day_no,day,recruit_post_no) 
values(recruit_day_no_seq.nextval,'월요일',1);
insert into recruit_day(recruit_day_no,day,recruit_post_no) 
values(recruit_day_no_seq.nextval,'수요일',1);
insert into recruit_day(recruit_day_no,day,recruit_post_no) 
values(recruit_day_no_seq.nextval,'금요일',1);

insert into recruit_day(recruit_day_no,day,recruit_post_no) 
values(recruit_day_no_seq.nextval,'화요일',2);
insert into recruit_day(recruit_day_no,day,recruit_post_no) 
values(recruit_day_no_seq.nextval,'목요일',2);

--모집 게시글 댓글
CREATE TABLE recruit_post_comment
(
	recruit_comment_no number primary key ,
	content clob not null,
	name varchar2(100) not null,
	regdate date not null, 
	recruit_post_no number not null,
	constraint fk2_recruit_post_no foreign key(recruit_post_no) references recruit_post(recruit_post_no)
);
create sequence recruit_comment_no_seq nocache;

insert into recruit_post_comment(recruit_comment_no, content, name, regdate, recruit_post_no)
values(recruit_comment_no_seq.nextval, '혹시 월수만 참여해도 될까요?','제이썬' ,sysdate,1);
insert into recruit_post_comment(recruit_comment_no, content, name, regdate, recruit_post_no)
values(recruit_comment_no_seq.nextval, '스터디 시간이 안 적혀있네요..','모지리' ,sysdate,1);
insert into recruit_post_comment(recruit_comment_no, content, name, regdate, recruit_post_no)
values(recruit_comment_no_seq.nextval, '화목 싫은데요? 에벱베베','강호동' ,sysdate,2);

--회원이 신청한 스터디 현황
CREATE TABLE study_condition
(
	study_condition_no number primary key,
	regdate date not null,
	state varchar2(100) not null,
	self_appeal varchar2(100) not null,
	recruit_post_no number not null,
	member_email varchar2(100) not null,
	constraint fk3_recruit_post_no foreign key(recruit_post_no) references recruit_post(recruit_post_no),
	constraint fk3_member_email foreign key(member_email) references member(member_email)
);
create sequence study_condition_no_seq nocache;
