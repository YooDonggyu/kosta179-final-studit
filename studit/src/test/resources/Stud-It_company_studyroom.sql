--업체
drop table company cascade constraint
CREATE TABLE company(
	company_no number primary key,
	name varchar2(100) not null,
	addr1 varchar2(50) not null,
	addr2 varchar2(50) not null,
	addr3 varchar2(50) not null,
	addr4 varchar2(100) not null,
	primary_addr varchar2(100) not null,
	detail_addr varchar2(100) not null,
	tel varchar2(100) not null,
	license varchar2(100) not null,
	regdate date not null,
	profile_path varchar2(100) default 'default.png',
	intro clob not null,
	state varchar2(50) not null,
	open varchar2(50) not null,
	close varchar2(50) not null,
	holiday varchar2(50) not null,
	hit number default 0,
	url varchar2(100),
	member_email varchar2(100) not null,
	constraint fk4_member_email foreign key(member_email) references member(member_email)
);
create sequence company_no_seq nocache;

drop sequence company_no_seq
insert into member_position values( member_position_no_seq.nextval, '업체', 'd@d.com');

insert into company(
company_no
, name, addr1, addr2, addr3, addr4, primary_addr, detail_addr
, tel, license, regdate, profile_path, intro
, state, open, close, holiday, hit, url, member_email
)values(
company_no_seq.nextval
, 'MOIM', '서울', '서초구', '-', '강남대로321 416호', '서울 서초구 강남대로321', '416호'
, '021234567', '1234567890', sysdate, 'company.png', '조용하고 아늑한 공간입니다.'
, '대기', '09', '22', '영업', 0, 'moim.com', 'a@a.com'
);

insert into company(
company_no
, name, addr1, addr2, addr3, addr4, primary_addr, detail_addr
, tel, license, regdate, intro, state
, open, close, holiday, member_email
)values(
company_no_seq.nextval
, 'MOIM', '경기도', '성남시', '분당구', '분당로53번길 12 서현나산플라자', '경기도 성남시 분당구', '분당로53번길 12 서현나산플라자'
, '031-8017-3537', '1234567891', sysdate, '★ 분당 서현역 스터디모임 전문공간 MOiM 입니다! (예약문의: 031-8017-3537) MOiM 스터디룸을 찾아주셔서 감사합니다. MOiM은 공간이 필요하신 모든 연령대, 어떠한 모임이든 환영합니다.'
, '대기', '09', '22', '영업', 'f@f.com'
);

insert into company(
company_no, name, addr1, addr2, addr3, addr4, primary_addr, detail_addr
, tel, license, regdate, intro
, state, open, close, holiday, member_email
)values(
company_no_seq.nextval
, 'CLARA','경기도','성남시','분당구','분당로53번길 12 서현나산플라자', '경기도 성남시 분당구', '분당로53번길 12 서현나산플라자'
,'031-8017-3537','1234567892',sysdate,'★ 분당 서현역 스터디모임 전문공간 CLARA 입니다! CLARA은 공간이 필요하신 모든 연령대, 어떠한 모임이든 환영합니다.'
,'승인', '09','22','영업','g@g.com'
);

insert into company(
company_no
, name, addr1, addr2, addr3, addr4, primary_addr, detail_addr
, tel, license, regdate, intro
, state, open, close, holiday, member_email
)values(
company_no_seq.nextval
, 'IU','경기도','성남시','분당구','분당로53번길 12 서현나산플라자', '경기도 성남시 분당구', '분당로53번길 12 서현나산플라자'
,'031-8017-3537','1234567893',sysdate,'★ IU와 함께하는 스터디공간 IU 입니다! 문의는 서정우 강사님께 하시면 되겠습니다.'
,'승인', '09','22','영업','h@h.com'
);

insert into company(
company_no
, name, addr1, addr2, addr3, addr4, primary_addr, detail_addr
, tel, license, regdate, intro
, state, open, close, holiday, member_email
)values(
company_no_seq.nextval
, 'REDVELVET','경기도','성남시','수정구','분당로53번길 12 서현나산플라자', '경기도 성남시 수정구', '분당로53번길 12 서현나산플라자'
,'031-8017-3537','1234567894',sysdate,'★ REDVELVET와 함께하는 스터디공간 REDVELVET 입니다! 찾아주셔서 감사합니다.'
,'승인', '09','22','영업','f@f.com'
);

insert into company(
company_no
, name, addr1, addr2, addr3, addr4, primary_addr, detail_addr
, tel, license, regdate, intro
, state, open, close, holiday, member_email
)values(
company_no_seq.nextval
, '소녀시대','경기도','성남시','수정구','분당로53번길 12 서현나산플라자', '경기도 성남시 수정구', '분당로53번길 12 서현나산플라자'
,'031-8017-3537','1234567895',sysdate,'★ 소녀시대와 함께하는 스터디공간 소녀시대 입니다! 오늘은 소녀시대! 감사합니다.'
,'승인', '09','22','영업','g@g.com'
);

insert into company(
company_no
, name, addr1, addr2, addr3, addr4, primary_addr, detail_addr
, tel, license, regdate, intro
, state, open, close, holiday, member_email
)values(
company_no_seq.nextval
, 'EXO','경기도','성남시','중원구','분당로53번길 12 서현나산플라자', '경기도 성남시 중원구', '분당로53번길 12 서현나산플라자'
,'031-8017-3537','1234567896',sysdate,'★ EXO 함께하는 스터디공간 EXO 입니다! 문의는 조선화군에게 하시면 됩니다.'
,'승인', '10','22','영업','h@h.com'
);

insert into company(
company_no
, name, addr1, addr2, addr3, addr4, primary_addr, detail_addr
, tel, license, regdate, intro
, state, open, close, holiday, member_email
)values(
company_no_seq.nextval
, '방탄소년단','서울특별시','강남구','논현동','분당로53번길 12 서현나산플라자', '서울특별시 강남구 논현동', '분당로53번길 12 서현나산플라자'
,'031-8017-3537','1234567897',sysdate,'★ 방탄소년단 함께하는 스터디공간 방탄소년단 입니다! 문의는 변태섭군에게 하시면 됩니다.'
,'승인', '09','22','영업','f@f.com'
);

insert into company(
company_no
, name, addr1, addr2, addr3, addr4, primary_addr, detail_addr
, tel, license, regdate, intro
, state, open, close, holiday, member_email
)values(
company_no_seq.nextval
, '여자친구','서울특별시','강남구','자곡동','분당로53번길 12 서현나산플라자', '서울특별시 강남구 자곡동', '분당로53번길 12 서현나산플라자'
,'031-8017-3537','1234567898',sysdate,'★ 여자친구가 있으신 분만 오실 수 있는 스터디공간 여자친구 입니다! 솔로지옥 커플천국.'
,'승인', '09','22','영업','g@g.com'
);

insert into company(
company_no
, name, addr1, addr2, addr3, addr4, primary_addr, detail_addr
, tel, license, regdate, intro
, state, open, close, holiday, member_email
)values(
company_no_seq.nextval
, '시를 잊은 그대에게','서울특별시','구로구','신도림동','분당로53번길 12 서현나산플라자', '서울특별시 구로구 신도림동', '분당로53번길 12 서현나산플라자'
,'031-8017-3537','1234567899',sysdate,'★ 시낭송 위주의 스터디가 주인 스터디공간 시를 잊은 그대에게 입니다! 문의는 호유란님께.'
,'승인', '09','22','영업','h@h.com'
);

insert into company(
company_no
, name, addr1, addr2, addr3, addr4, primary_addr, detail_addr
, tel, license, regdate, intro
, state, open, close, holiday, member_email
)values(
company_no_seq.nextval
, '시를 잊은 그대에게','서울특별시','구로구','신도림동','분당로53번길 12 서현나산플라자', '서울특별시 구로구 신도림동', '분당로53번길 12 서현나산플라자'
,'031-8017-3537','1234567810',sysdate,'★ 시낭송 위주의 스터디가 주인 스터디공간 시를 잊은 그대에게 입니다! 문의는 호유란님께.'
,'승인', '09','22','영업','h@h.com'
);

update company set state='승인' where company_no=1


--업체 사진
CREATE TABLE com_pic
(
	com_pic_no number primary key ,
	path varchar2(100) not null,
	company_no number not null,
	constraint fk2_company_no foreign key(company_no) references company(company_no)
);
create sequence com_pic_no_seq nocache;


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
insert into com_business_day(com_day_no, day, company_no) values(com_business_day_seq.nextval, '화', 1);
insert into com_business_day(com_day_no, day, company_no) values(com_business_day_seq.nextval, '목', 1);
insert into com_business_day(com_day_no, day, company_no) values(com_business_day_seq.nextval, '금', 1);
insert into com_business_day(com_day_no, day, company_no) values(com_business_day_seq.nextval, '토', 1);
select c.name, d.day 
from com_business_day d, company c
where d.company_no=c.company_no


--해시태그
create table hashtag (
	hashtag_no number primary key,
	content varchar2(100) not null,
	company_no number not null,
	constraint fk5_company_no foreign key(company_no) references company(company_no)
);

create sequence hashtag_seq nocache;

insert into hashtag(hashtag_no, content, company_no) values(hashtag_seq.nextval, '화이트보드', 1);
insert into hashtag(hashtag_no, content, company_no) values(hashtag_seq.nextval, '분위기', 1);
insert into hashtag(hashtag_no, content, company_no) values(hashtag_seq.nextval, '꽃향기', 1);
insert into hashtag(hashtag_no, content, company_no) values(hashtag_seq.nextval, '고백', 2);
insert into hashtag(hashtag_no, content, company_no) values(hashtag_seq.nextval, '성공적', 2);
insert into hashtag(hashtag_no, content, company_no) values(hashtag_seq.nextval, '분위기', 2);
insert into hashtag(hashtag_no, content, company_no) values(hashtag_seq.nextval, '커피리필무료', 3);
insert into hashtag(hashtag_no, content, company_no) values(hashtag_seq.nextval, '커피향', 3);
insert into hashtag(hashtag_no, content, company_no) values(hashtag_seq.nextval, '커피존맛', 4);
insert into hashtag(hashtag_no, content, company_no) values(hashtag_seq.nextval, '고백', 5);
insert into hashtag(hashtag_no, content, company_no) values(hashtag_seq.nextval, '24시', 5);
insert into hashtag(hashtag_no, content, company_no) values(hashtag_seq.nextval, '24시', 6);
insert into hashtag(hashtag_no, content, company_no) values(hashtag_seq.nextval, '주차공간', 6);
insert into hashtag(hashtag_no, content, company_no) values(hashtag_seq.nextval, '밝은조명', 6);
insert into hashtag(hashtag_no, content, company_no) values(hashtag_seq.nextval, '스터디', 7);
insert into hashtag(hashtag_no, content, company_no) values(hashtag_seq.nextval, '조용한', 8);
insert into hashtag(hashtag_no, content, company_no) values(hashtag_seq.nextval, '북카페', 8);
insert into hashtag(hashtag_no, content, company_no) values(hashtag_seq.nextval, '고양이카페', 9);
insert into hashtag(hashtag_no, content, company_no) values(hashtag_seq.nextval, '강아지카페', 9);
--스터디룸
create table studyroom(
	studyroom_no number primary key,
	name varchar2(100) not null,
 	capacity number not null,
	price number not null,
	content clob not null,
	company_no number not null,
	constraint fk6_company_no foreign key(company_no) references company(company_no)
);

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
);

create sequence studyroom_function_seq nocache;

insert into studyroom_function(function_no, name, studyroom_no) values(studyroom_function_seq.nextval, '프로젝터', 2);
insert into studyroom_function(function_no, name, studyroom_no) values(studyroom_function_seq.nextval, '화이트보드', 2);

select s.name, f.name
from studyroom s, studyroom_function f
where s.studyroom_no=f.studyroom_no

--스터디룸 사진
create table studyroom_pic(
	studyroom_pic_no number primary key,
	path varchar2(100) default 'studyroom.png',
	studyroom_no number not null,
	constraint fk2_studyroom_no foreign key(studyroom_no) references studyroom(studyroom_no)
);

create sequence studyroom_pic_seq nocache;
insert into studyroom_pic(studyroom_pic_no, studyroom_no) values(studyroom_pic_seq.nextval, 2);
update studyroom_pic set path='studyroom.png' where studyroom_pic_no = 1
select * from studyroom_pic

select s.name, p.path
from studyroom s, studyroom_pic p
where s.studyroom_no=p.studyroom_no

--나의 스터디룸 신청 현황
 drop table studyroom_condition cascade constraint
create table studyroom_condition (
	studyroom_condition_no number primary key,
	member_email varchar2(100) not null,
	regdate date not null,
	studyroom_no number not null,
	start_time varchar2(100) not null,
	end_time varchar2(100) not null,
	state varchar2(100) default '예약대기',
	use_date date not null,
	constraint fk3_studyroom_no foreign key(studyroom_no) references studyroom(studyroom_no),
	constraint fk5_member_email foreign key(member_email) references member(member_email)
);
drop  sequence studyroom_condition_seq
create sequence studyroom_condition_seq nocache;

insert into studyroom_condition(studyroom_condition_no, member_email, regdate, studyroom_no, start_time, end_time, state, use_date) 
values(studyroom_condition_seq.nextval, 'a@a.com', sysdate, 1, '14','16', '예약대기', to_date('2018-05-30','YYYY-MM-DD'));

insert into studyroom_condition(studyroom_condition_no, member_email, regdate, studyroom_no, start_time, end_time, state, use_date) 
values(studyroom_condition_seq.nextval, 'b@b.com', sysdate, 1, '11','12', '예약완료', to_date('2018-05-31','YYYY-MM-DD'));

insert into studyroom_condition(studyroom_condition_no, member_email, regdate, studyroom_no, start_time, end_time, state, use_date) 
values(studyroom_condition_seq.nextval, 'b@b.com', sysdate, 1, '09','10', '예약완료', to_date('2018-10-31','YYYY-MM-DD'));

insert into studyroom_condition(studyroom_condition_no, member_email, regdate, studyroom_no, start_time, end_time, state, use_date) 
values(studyroom_condition_seq.nextval, 'c@c.com', sysdate, 1, '11','14', '예약완료', to_date('2018-09-03','YYYY-MM-DD'));

insert into studyroom_condition(studyroom_condition_no, member_email, regdate, studyroom_no, start_time, end_time, state, use_date) 
values(studyroom_condition_seq.nextval, 'a@a.com', sysdate, 1, '17','18', '예약불가', to_date('2018-12-02','YYYY-MM-DD'));

insert into studyroom_condition(studyroom_condition_no, member_email, regdate, studyroom_no, start_time, end_time, state, use_date) 
values(studyroom_condition_seq.nextval, 'c@c.com', sysdate, 1, '14','18', '예약대기', to_date('2019-03-13','YYYY-MM-DD'));
insert into studyroom_condition(studyroom_condition_no, member_email, regdate, studyroom_no, start_time, end_time, state, use_date) 
values(studyroom_condition_seq.nextval, 'a@a.com', sysdate, 1, '18','19', '예약불가', to_date('2019-04-20','YYYY-MM-DD'));

insert into studyroom_condition(studyroom_condition_no, member_email, regdate, studyroom_no, start_time, end_time, state, use_date) 
values(studyroom_condition_seq.nextval, 'b@b.com', sysdate, 1, '11','12', '예약완료', to_date('2018-09-09','YYYY-MM-DD'));

insert into studyroom_condition(studyroom_condition_no, member_email, regdate, studyroom_no, start_time, end_time, state, use_date) 
values(studyroom_condition_seq.nextval, 'a@a.com', sysdate, 1, '15','16', '예약대기', to_date('2018-12-31','YYYY-MM-DD'));

insert into studyroom_condition(studyroom_condition_no, member_email, regdate, studyroom_no, start_time, end_time, state, use_date) 
values(studyroom_condition_seq.nextval, 'a@a.com', sysdate, 1, '12','13', '예약불가', to_date('2018-11-12','YYYY-MM-DD'));

insert into studyroom_condition(studyroom_condition_no, member_email, regdate, studyroom_no, start_time, end_time, state, use_date) 
values(studyroom_condition_seq.nextval, 'c@c.com', sysdate, 1, '08','10', '예약대기', to_date('2019-06-13','YYYY-MM-DD'));

insert into studyroom_condition(studyroom_condition_no, member_email, regdate, studyroom_no, start_time, end_time, state, use_date) 
values(studyroom_condition_seq.nextval, 'a@a.com', sysdate, 1, '15','16', '예약불가', to_date('2019-09-20','YYYY-MM-DD'));

insert into studyroom_condition(studyroom_condition_no, member_email, regdate, studyroom_no, start_time, end_time, state, use_date) 
values(studyroom_condition_seq.nextval, 'b@b.com', sysdate, 1, '12','12', '예약완료', to_date('2018-10-09','YYYY-MM-DD'));

insert into studyroom_condition(studyroom_condition_no, member_email, regdate, studyroom_no, start_time, end_time, state, use_date) 
values(studyroom_condition_seq.nextval, 'a@a.com', sysdate, 1, '13','14', '예약대기', to_date('2018-11-30','YYYY-MM-DD'));


insert into studyroom_condition(studyroom_condition_no, member_email, regdate, studyroom_no, start_time, end_time, state, use_date) 
values(studyroom_condition_seq.nextval, 'a@a.com', sysdate, 1, '12','13', '예약불가', to_date('2018-11-12','YYYY-MM-DD'));

insert into studyroom_condition(studyroom_condition_no, member_email, regdate, studyroom_no, start_time, end_time, state, use_date) 
values(studyroom_condition_seq.nextval, 'c@c.com', sysdate, 1, '08','10', '예약대기', to_date('2019-06-13','YYYY-MM-DD'));

insert into studyroom_condition(studyroom_condition_no, member_email, regdate, studyroom_no, start_time, end_time, state, use_date) 
values(studyroom_condition_seq.nextval, 'a@a.com', sysdate, 1, '15','16', '예약불가', to_date('2019-09-20','YYYY-MM-DD'));

insert into studyroom_condition(studyroom_condition_no, member_email, regdate, studyroom_no, start_time, end_time, state, use_date) 
values(studyroom_condition_seq.nextval, 'b@b.com', sysdate, 1, '12','12', '예약완료', to_date('2018-10-09','YYYY-MM-DD'));

insert into studyroom_condition(studyroom_condition_no, member_email, regdate, studyroom_no, start_time, end_time, state, use_date) 
values(studyroom_condition_seq.nextval, 'a@a.com', sysdate, 1, '13','14', '예약대기', to_date('2018-11-30','YYYY-MM-DD'));


insert into studyroom_condition(studyroom_condition_no, member_email, regdate, studyroom_no, start_time, end_time, state, use_date) 
values(studyroom_condition_seq.nextval, 'a@a.com', sysdate, 1, '13','14', '예약대기', to_date('2018-11-30','YYYY-MM-DD'));

commit
