﻿--업체
CREATE TABLE company(
	company_no number primary key,
	name varchar2(100) not null,
	addr1 varchar2(50) not null,
	addr2 varchar2(50) not null,
	addr3 varchar2(50) not null,
	addr4 varchar2(100) not null,
	latitude number not null,
	longitude number not null,
	tel varchar2(100) not null,
	license varchar2(100) not null,
	regdate date not null,
	profile_path varchar2(100) not null,
	intro clob not null,
	state varchar2(50) not null,
	open varchar2(50) not null,
	close varchar2(50) not null,
	holiday varchar2(50) not null,
	hit number default 0,
	url varchar2(100) not null,
	member_email varchar2(100) not null,
	constraint fk4_member_email foreign key(member_email) references member(member_email)
);
create sequence company_no_seq nocache;

insert into member_position values( member_position_no_seq.nextval, '업체', 'd@d.com');
insert into company(
company_no
, name
, addr1
, addr2
, addr3
, addr4
, latitude
, longitude
, tel
, license
, regdate
, profile_path
, intro
, state
, open
, close
, holiday
, url
, member_email
)
values(company_no_seq.nextval
, 'MOIM'
,'경기도'
,'성남시'
,'분당구'
,'분당로53번길 12 서현나산플라자'
, 3
, 3
,'031-8017-3537'
,'222-18-56167'
,sysdate
,'/image'
,'★ 분당 서현역 스터디모임 전문공간 MOiM 입니다! (예약문의: 031-8017-3537) MOiM 스터디룸을 찾아주셔서 감사합니다. MOiM은 공간이 필요하신 모든 연령대, 어떠한 모임이든 환영합니다.'
,'대기'
, '09:00'
,'22:00'
,'영업'
,'http://www.moimstudy.com/'
,'d@d.com'
);


--공지사항
CREATE TABLE com_announcement
(
	anc_no number primary key,
	title varchar2(100) not null,
	content clob not null,
	regdate date not null,
	company_no number not null,
	constraint fk_company_no foreign key(company_no) references company(company_no)
);
create sequence anc_no_seq nocache;

--업체 사진
CREATE TABLE com_pic
(
	com_pic_no number primary key ,
	path varchar2(100) not null,
	company_no number not null,
	constraint fk2_company_no foreign key(company_no) references company(company_no)
);
create sequence com_pic_no_seq nocache;

--업체 후기
CREATE TABLE com_review
(
	com_review_no number primary key,
	content clob not null,
	score number not null,
	regdate date not null,
	name varchar2(100) not null,
	company_no number not null,
	constraint fk3_company_no foreign key(company_no) references company(company_no)
);

create sequence com_review_seq nocache;
insert into com_review(com_review_no, content, score, regdate, name, company_no) 
values(com_review_seq.nextval, '다신 안가요', 1, sysdate, '유란', 1) ;

--업체 후기 댓글
CREATE TABLE com_review_comment(
	com_comment_no number primary key,
	content clob not null,
	com_review_no number not null,
	name varchar2(100) not null,
	regdate date not null,
	constraint fk_com_review_no foreign key(com_review_no) references com_review(com_review_no)
);

create sequence com_review_comment_seq nocache;

insert into com_review_comment(com_comment_no, content, com_review_no, name, regdate) values(com_review_comment_seq.nextval, '왜그러세요', 2, 'MOIM', sysdate);

select com.name, r.content, r.name, c.content, c.name 
from com_review_comment c, com_review r, company com
where com.company_no=r.company_no and r.com_review_no=c.com_review_no

--업체 요일 선택
create table com_business_day (
	com_day_no number primary key,
	day varchar2(50) not null,
	company_no number not null,
	constraint fk4_company_no foreign key(company_no) references company(company_no)
);
create sequence com_business_day_seq nocache;
insert into com_business_day(com_day_no, day, company_no) values(com_business_day_seq.nextval, '월', 1);
insert into com_business_day(com_day_no, day, company_no) values(com_business_day_seq.nextval, '수', 1);

select c.name, d.day 
from com_business_day d, company c
where d.company_no=c.company_no


--해시태그
create table hashtag (
	hashtag_no number primary key,
	content varchar2(100) not null,
	company_no number not null,
	constraint fk5_company_no foreign key(company_no) references company(company_no)
)

create sequence hashtag_seq nocache;
insert into hashtag(hashtag_no, content, company_no) values(hashtag_seq.nextval, '화이트보드', 1);

--스터디룸
create table studyroom(
	studyroom_no number primary key,
	name varchar2(100) not null,
 	capacity number not null,
	price number not null,
	content clob not null,
	company_no number not null,
	constraint fk6_company_no foreign key(company_no) references company(company_no)
)

create sequence studyroom_seq nocache;
insert into studyroom(studyroom_no, name, capacity, price, content, company_no)
values(studyroom_seq.nextval, 'room-A', 15, 10000, '쾌적한 공간', 1);
insert into studyroom(studyroom_no, name, capacity, price, content, company_no)
values(studyroom_seq.nextval, 'room-B', 6, 5000, '소규모 모임에 적합', 1);

select c.name, s.name, s.capacity, s.price, s.content, c.addr1
from studyroom s, company c
where s.company_no=c.company_no

select count(*) 
from studyroom s, company c
where s.company_no=c.company_no

--스터디룸 제공 기능
create table studyroom_function(
	function_no number primary key,
	name varchar2(100) not null,
	studyroom_no number not null,
	constraint fk_studyroom_no foreign key(studyroom_no) references studyroom(studyroom_no)
)

create sequence studyroom_function_seq nocache;

insert into studyroom_function(function_no, name, studyroom_no) values(studyroom_function_seq.nextval, '프로젝터', 2);
insert into studyroom_function(function_no, name, studyroom_no) values(studyroom_function_seq.nextval, '화이트보드', 2);

select s.name, f.name
from studyroom s, studyroom_function f
where s.studyroom_no=f.studyroom_no

--스터디룸 사진
create table studyroom_pic(
	studyroom_pic_no number primary key,
	path varchar2(100) not null,
	studyroom_no number not null,
	constraint fk2_studyroom_no foreign key(studyroom_no) references studyroom(studyroom_no)
)

create sequence studyroom_pic_seq nocache;
insert into studyroom_pic(studyroom_pic_no, path, studyroom_no) values(studyroom_pic_seq.nextval, 'image.jpg', 2)

select s.name, p.path
from studyroom s, studyroom_pic p
where s.studyroom_no=p.studyroom_no

--나의 스터디룸 신청 현황
create table studyroom_condition (
	studyroom_condition_no number primary key,
	member_email varchar2(100) not null,
	regdate date not null,
	studyroom_no number not null,
	start_time varchar2(100) not null,
	end_time varchar2(100) not null,
	state varchar2(100) not null,
	use_date date not null,
	constraint fk3_studyroom_no foreign key(studyroom_no) references studyroom(studyroom_no),
	constraint fk5_member_email foreign key(member_email) references member(member_email)
)

create sequence studyroom_condition_seq nocache;

insert into studyroom_condition(studyroom_condition_no, member_email, regdate, studyroom_no, start_time, end_time, state, use_date) 
values(studyroom_condition_seq.nextval, 'a@a.com', sysdate, 1, '14:00','16:00', '대기중', to_date('2018-05-30','YYYY-MM-DD'));
insert into studyroom_condition(studyroom_condition_no, member_email, regdate, studyroom_no, start_time, end_time, state, use_date) 
values(studyroom_condition_seq.nextval, 'b@b.com', sysdate, 1, '11:00','12:00', '승인', to_date('2018-05-31','YYYY-MM-DD'));
insert into studyroom_condition(studyroom_condition_no, member_email, regdate, studyroom_no, start_time, end_time, state, use_date) 
values(studyroom_condition_seq.nextval, 'b@b.com', sysdate, 1, '09:00','10:00', '승인', to_date('2018-10-31','YYYY-MM-DD'));
insert into studyroom_condition(studyroom_condition_no, member_email, regdate, studyroom_no, start_time, end_time, state, use_date) 
values(studyroom_condition_seq.nextval, 'c@c.com', sysdate, 1, '11:00','14:00', '승인', to_date('2018-09-03','YYYY-MM-DD'));
insert into studyroom_condition(studyroom_condition_no, member_email, regdate, studyroom_no, start_time, end_time, state, use_date) 
values(studyroom_condition_seq.nextval, 'a@a.com', sysdate, 1, '17:00','18:00', '거절', to_date('2018-12-02','YYYY-MM-DD'));
insert into studyroom_condition(studyroom_condition_no, member_email, regdate, studyroom_no, start_time, end_time, state, use_date) 
values(studyroom_condition_seq.nextval, 'c@c.com', sysdate, 1, '14:00','18:00', '대기중', to_date('2019-03-13','YYYY-MM-DD'));
insert into studyroom_condition(studyroom_condition_no, member_email, regdate, studyroom_no, start_time, end_time, state, use_date) 
values(studyroom_condition_seq.nextval, 'a@a.com', sysdate, 1, '18:00','19:00', '거절', to_date('2019-04-20','YYYY-MM-DD'));
insert into studyroom_condition(studyroom_condition_no, member_email, regdate, studyroom_no, start_time, end_time, state, use_date) 
values(studyroom_condition_seq.nextval, 'b@b.com', sysdate, 1, '11:00','12:00', '승인', to_date('2018-09-09','YYYY-MM-DD'));
insert into studyroom_condition(studyroom_condition_no, member_email, regdate, studyroom_no, start_time, end_time, state, use_date) 
values(studyroom_condition_seq.nextval, 'a@a.com', sysdate, 1, '15:00','16:00', '대기중', to_date('2018-12-31','YYYY-MM-DD'));

insert into studyroom_condition(studyroom_condition_no, member_email, regdate, studyroom_no, start_time, end_time, state, use_date) 
values(studyroom_condition_seq.nextval, 'a@a.com', sysdate, 1, '12:00','13:00', '거절', to_date('2018-11-12','YYYY-MM-DD'));
insert into studyroom_condition(studyroom_condition_no, member_email, regdate, studyroom_no, start_time, end_time, state, use_date) 
values(studyroom_condition_seq.nextval, 'c@c.com', sysdate, 1, '08:00','10:00', '대기중', to_date('2019-06-13','YYYY-MM-DD'));
insert into studyroom_condition(studyroom_condition_no, member_email, regdate, studyroom_no, start_time, end_time, state, use_date) 
values(studyroom_condition_seq.nextval, 'a@a.com', sysdate, 1, '15:00','16:00', '거절', to_date('2019-09-20','YYYY-MM-DD'));
insert into studyroom_condition(studyroom_condition_no, member_email, regdate, studyroom_no, start_time, end_time, state, use_date) 
values(studyroom_condition_seq.nextval, 'b@b.com', sysdate, 1, '12:00','12:00', '승인', to_date('2018-10-09','YYYY-MM-DD'));
insert into studyroom_condition(studyroom_condition_no, member_email, regdate, studyroom_no, start_time, end_time, state, use_date) 
values(studyroom_condition_seq.nextval, 'a@a.com', sysdate, 1, '13:00','14:00', '대기중', to_date('2018-11-30','YYYY-MM-DD'));

insert into studyroom_condition(studyroom_condition_no, member_email, regdate, studyroom_no, start_time, end_time, state, use_date) 
values(studyroom_condition_seq.nextval, 'a@a.com', sysdate, 1, '12:00','13:00', '거절', to_date('2018-11-12','YYYY-MM-DD'));
insert into studyroom_condition(studyroom_condition_no, member_email, regdate, studyroom_no, start_time, end_time, state, use_date) 
values(studyroom_condition_seq.nextval, 'c@c.com', sysdate, 1, '08:00','10:00', '대기중', to_date('2019-06-13','YYYY-MM-DD'));
insert into studyroom_condition(studyroom_condition_no, member_email, regdate, studyroom_no, start_time, end_time, state, use_date) 
values(studyroom_condition_seq.nextval, 'a@a.com', sysdate, 1, '15:00','16:00', '거절', to_date('2019-09-20','YYYY-MM-DD'));
insert into studyroom_condition(studyroom_condition_no, member_email, regdate, studyroom_no, start_time, end_time, state, use_date) 
values(studyroom_condition_seq.nextval, 'b@b.com', sysdate, 1, '12:00','12:00', '승인', to_date('2018-10-09','YYYY-MM-DD'));
insert into studyroom_condition(studyroom_condition_no, member_email, regdate, studyroom_no, start_time, end_time, state, use_date) 
values(studyroom_condition_seq.nextval, 'a@a.com', sysdate, 1, '13:00','14:00', '대기중', to_date('2018-11-30','YYYY-MM-DD'));

insert into studyroom_condition(studyroom_condition_no, member_email, regdate, studyroom_no, start_time, end_time, state, use_date) 
values(studyroom_condition_seq.nextval, 'a@a.com', sysdate, 1, '13:00','14:00', '대기중', to_date('2018-11-30','YYYY-MM-DD'));

commit



select s.name, sc.member_email, sc.use_date, sc.start_time, sc.end_time, sc.state
from studyroom s, studyroom_condition sc
where s.studyroom_no=sc.studyroom_no
