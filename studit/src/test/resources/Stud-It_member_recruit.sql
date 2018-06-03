
drop table member cascade constraints;
﻿--회원
CREATE TABLE member
(
    member_email varchar2(100) primary key, 
    password varchar2(100) not null, 
    name varchar2(100) not null, 
    primary_addr varchar2(100) not null,
    detail_addr varchar2(100) not null,
    phone varchar2(100) not null, 
    regdate DATE not null, 
    password_hint varchar2(100) not null, 
    password_answer varchar2(100) not null, 
    pic_path varchar2(300) default 'default.png' 
);
 
insert into member(member_email,password,name,primary_addr,detail_addr,phone,regdate,password_hint,password_answer) 
values('a@a.com','1','아이유','경기도 판교','1호','010-1234-5678',sysdate,'내 나이는?','25');
insert into member(member_email,password,name,primary_addr,detail_addr,phone,regdate,password_hint,password_answer) 
values('b@b.com','1','아삼유','충청북도 청주시','2호','010-1234-5678',sysdate,'내 나이는?','25');
insert into member(member_email,password,name,primary_addr,detail_addr,phone,regdate,password_hint,password_answer) 
values('c@c.com','1','아사유','대전광역시','3호','010-1234-5678',sysdate,'내 나이는?','25');
insert into member(member_email,password,name,primary_addr,detail_addr,phone,regdate,password_hint,password_answer) 
values('d@d.com','1','아오유','대구','4호','010-1234-5678',sysdate,'내 나이는?','25');
insert into member(member_email,password,name,primary_addr,detail_addr,phone,regdate,password_hint,password_answer) 
values('e@e.com','1','아이육','부산','5호','010-1234-5678',sysdate,'내 나이는?','25');
insert into member(member_email,password,name,primary_addr,detail_addr,phone,regdate,password_hint,password_answer) 
values('f@f.com','1','아이칠','찍고','6호','010-1234-5678',sysdate,'내 나이는?','25');
insert into member(member_email,password,name,primary_addr,detail_addr,phone,regdate,password_hint,password_answer) 
values('g@g.com','1','아이팔','서울','7호','010-1234-5678',sysdate,'내 나이는?','25');
insert into member(member_email,password,name,primary_addr,detail_addr,phone,regdate,password_hint,password_answer) 
values('h@h.com','1','아이구','신갈','8호','010-1234-5678',sysdate,'내 나이는?','25');
insert into member(member_email,password,name,primary_addr,detail_addr,phone,regdate,password_hint,password_answer) 
values('i@i.com','1','아이십','수원','9호','010-1234-5678',sysdate,'내 나이는?','25');
insert into member(member_email,password,name,primary_addr,detail_addr,phone,regdate,password_hint,password_answer) 
values('j@j.com','1','유동규','오이도','10','010-1234-5678',sysdate,'내 나이는?','25');
insert into member(member_email,password,name,primary_addr,detail_addr,phone,regdate,password_hint,password_answer) 
values('k@k.com','1','김유란','고양','11호','010-1234-5678',sysdate,'내 나이는?','25');
insert into member(member_email,password,name,primary_addr,detail_addr,phone,regdate,password_hint,password_answer) 
values('l@l.com','1','null승수','찾을 수 없습니다.','12호','010-1234-5678',sysdate,'내 나이는?','25');
insert into member(member_email,password,name,primary_addr,detail_addr,phone,regdate,password_hint,password_answer) 
values('tico99@naver.com','1','갓정우','천상계','101호','010-1234-5678',sysdate,'짐의 나이는?','25');
insert into member(member_email,password,name,primary_addr,detail_addr,phone,regdate,password_hint,password_answer) 
values('d@e.com','1','아이십','수원','9호','010-1234-5678',sysdate,'내 나이는?','25');
insert into member(member_email,password,name,primary_addr,detail_addr,phone,regdate,password_hint,password_answer) 
values('e@f.com','1','아이십','수원','9호','010-1234-5678',sysdate,'내 나이는?','25');
insert into member(member_email,password,name,primary_addr,detail_addr,phone,regdate,password_hint,password_answer) 
values('f@g.com','1','아이십','수원','9호','010-1234-5678',sysdate,'내 나이는?','25');
insert into member(member_email,password,name,primary_addr,detail_addr,phone,regdate,password_hint,password_answer) 
values('g@h.com','1','아이십','수원','9호','010-1234-5678',sysdate,'내 나이는?','25');
insert into member(member_email,password,name,primary_addr,detail_addr,phone,regdate,password_hint,password_answer) 
values('h@i.com','1','아이십','수원','9호','010-1234-5678',sysdate,'내 나이는?','25');
insert into member(member_email,password,name,primary_addr,detail_addr,phone,regdate,password_hint,password_answer) 
values('i@j.com','1','아이십','수원','9호','010-1234-5678',sysdate,'내 나이는?','25');
insert into member(member_email,password,name,primary_addr,detail_addr,phone,regdate,password_hint,password_answer) 
values('j@k.com','1','아이십','수원','9호','010-1234-5678',sysdate,'내 나이는?','25');


--직책
-- 직책은 관리자, 회원, 업체, 탈퇴
CREATE TABLE member_position
(
	member_position_no number  primary key ,
	name varchar2(100)  default '회원',
	member_email varchar2(100)  not null,
	constraint fk_member_email foreign key(member_email) references member(member_email)
);

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
insert into MEMBER_POSITION(member_position_no,name,member_email) 
values(member_position_no_seq.nextval,'회원','e@e.com');
insert into MEMBER_POSITION(member_position_no,name,member_email) 
values(member_position_no_seq.nextval,'업체','f@f.com');
insert into MEMBER_POSITION(member_position_no,name,member_email) 
values(member_position_no_seq.nextval,'업체','g@g.com');
insert into MEMBER_POSITION(member_position_no,name,member_email) 
values(member_position_no_seq.nextval,'업체','h@h.com');
insert into MEMBER_POSITION(member_position_no,name,member_email) 
values(member_position_no_seq.nextval,'탈퇴','i@i.com');
insert into MEMBER_POSITION(member_position_no,name,member_email) 
values(member_position_no_seq.nextval,'회원','j@j.com');
insert into MEMBER_POSITION(member_position_no,name,member_email) 
values(member_position_no_seq.nextval,'회원','k@k.com');
insert into MEMBER_POSITION(member_position_no,name,member_email) 
values(member_position_no_seq.nextval,'탈퇴','l@l.com');
insert into MEMBER_POSITION(member_position_no,name,member_email) 
values(member_position_no_seq.nextval,'회원','d@e.com');
insert into MEMBER_POSITION(member_position_no,name,member_email) 
values(member_position_no_seq.nextval,'회원','e@f.com');
insert into MEMBER_POSITION(member_position_no,name,member_email) 
values(member_position_no_seq.nextval,'회원','f@g.com');
insert into MEMBER_POSITION(member_position_no,name,member_email) 
values(member_position_no_seq.nextval,'회원','g@h.com');
insert into MEMBER_POSITION(member_position_no,name,member_email) 
values(member_position_no_seq.nextval,'회원','h@i.com');
insert into MEMBER_POSITION(member_position_no,name,member_email) 
values(member_position_no_seq.nextval,'회원','i@j.com');
insert into MEMBER_POSITION(member_position_no,name,member_email) 
values(member_position_no_seq.nextval,'회원','j@k.com');



--검색 키워드
create table search_keyword(
	keyword varchar2(100) primary key,
	hit number default 0
);

drop table big_category  cascade constraint;
--대분류
CREATE TABLE big_category
(
	big_category_no number primary key ,
	name varchar2(100) not null 
);
drop sequence big_category_no_seq;
create sequence big_category_no_seq nocache;

insert into big_category(big_category_no,name) values(big_category_no_seq.nextval,'취업');
insert into big_category(big_category_no,name) values(big_category_no_seq.nextval,'어학');
insert into big_category(big_category_no,name) values(big_category_no_seq.nextval,'프로그래밍');
insert into big_category(big_category_no,name) values(big_category_no_seq.nextval,'기타');


--소분류
CREATE TABLE small_category
(
	small_category_no number  primary key ,
	name varchar2(100) not null ,
	big_category_no number not null ,
	constraint fk_big_category_no foreign key(big_category_no) references big_category(big_category_no)
);
drop table small_category cascade constraint;
drop sequence small_category_no_seq
create sequence small_category_no_seq nocache;

insert into small_category(small_category_no,name,big_category_no) 
values(small_category_no_seq.nextval,'대기업','1');
insert into small_category(small_category_no,name,big_category_no) 
values(small_category_no_seq.nextval,'중소기업','1');
insert into small_category(small_category_no,name,big_category_no) 
values(small_category_no_seq.nextval,'공기업','1');
insert into small_category(small_category_no,name,big_category_no) 
values(small_category_no_seq.nextval,'기타','1');

insert into small_category(small_category_no,name,big_category_no) 
values(small_category_no_seq.nextval,'영어','2');
insert into small_category(small_category_no,name,big_category_no) 
values(small_category_no_seq.nextval,'일본어','2');
insert into small_category(small_category_no,name,big_category_no) 
values(small_category_no_seq.nextval,'중국어','2');
insert into small_category(small_category_no,name,big_category_no) 
values(small_category_no_seq.nextval,'베트남어','2');
insert into small_category(small_category_no,name,big_category_no) 
values(small_category_no_seq.nextval,'기타','2');

insert into small_category(small_category_no,name,big_category_no) 
values(small_category_no_seq.nextval,'JAVA','3');
insert into small_category(small_category_no,name,big_category_no) 
values(small_category_no_seq.nextval,'C/C++','3');
insert into small_category(small_category_no,name,big_category_no) 
values(small_category_no_seq.nextval,'Andriod','3');
insert into small_category(small_category_no,name,big_category_no) 
values(small_category_no_seq.nextval,'Python','3');
insert into small_category(small_category_no,name,big_category_no) 
values(small_category_no_seq.nextval,'기타','3');

insert into small_category(small_category_no,name,big_category_no) 
values(small_category_no_seq.nextval,'기타','4');

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
drop sequence recruit_post_no_seq
drop table recruit_post

insert into recruit_post (recruit_post_no,title,content,regdate,condition,capacity,member_email,small_category_no,location) 
values(recruit_post_no_seq.nextval,'대기업1','11111',sysdate,'모집중',6,'a@a.com',1,'강남');
insert into recruit_post (recruit_post_no,title,content,regdate,condition,capacity,member_email,small_category_no,location) 
values(recruit_post_no_seq.nextval,'대기업2','2222222',sysdate,'모집완료',4,'b@b.com',1,'종로');
insert into recruit_post (recruit_post_no,title,content,regdate,condition,capacity,member_email,small_category_no,location) 
values(recruit_post_no_seq.nextval,'중소기업1','333?33333',sysdate,'모집중',4,'a@a.com',2,'강남');
insert into recruit_post (recruit_post_no,title,content,regdate,condition,capacity,member_email,small_category_no,location) 
values(recruit_post_no_seq.nextval,'중소기업2','4444444',sysdate,'모집완료',3,'b@b.com',2,'종로');
insert into recruit_post (recruit_post_no,title,content,regdate,condition,capacity,member_email,small_category_no,location) 
values(recruit_post_no_seq.nextval,'공기업3','가나다라마바사',sysdate,'모집중',5,'c@c.com',3,'파주');
insert into recruit_post (recruit_post_no,title,content,regdate,condition,capacity,member_email,small_category_no,location) 
values(recruit_post_no_seq.nextval,'공기업4','아자차카타파하',sysdate,'모집중',7,'d@d.com',3,'분당');
insert into recruit_post (recruit_post_no,title,content,regdate,condition,capacity,member_email,small_category_no,location) 
values(recruit_post_no_seq.nextval,'해외기업','블리자드 가쉴?',sysdate,'모집중',4,'c@c.com',4,'강북');
insert into recruit_post (recruit_post_no,title,content,regdate,condition,capacity,member_email,small_category_no,location) 
values(recruit_post_no_seq.nextval,'일안하고 노실분','링가링가링',sysdate,'모집중',3,'d@d.com',4,'강남');
insert into recruit_post (recruit_post_no,title,content,regdate,condition,capacity,member_email,small_category_no,location) 
values(recruit_post_no_seq.nextval,'영어공부하실분?','Do you know Kimchi??',sysdate,'모집완료',4,'e@e.com',5,'서울역');
insert into recruit_post (recruit_post_no,title,content,regdate,condition,capacity,member_email,small_category_no,location) 
values(recruit_post_no_seq.nextval,'토스공부하실분?','토토스스토토',sysdate,'모집중',3,'f@f.com',5,'종로');
insert into recruit_post (recruit_post_no,title,content,regdate,condition,capacity,member_email,small_category_no,location) 
values(recruit_post_no_seq.nextval,'일본어 공부할래요?','엌ㅋㅋ 닝겐노 유리와 튼튼데스넼ㅋㅋ',sysdate,'모집중',3,'e@e.com',6,'종로');
insert into recruit_post (recruit_post_no,title,content,regdate,condition,capacity,member_email,small_category_no,location) 
values(recruit_post_no_seq.nextval,'재팬 빠이염','곤니치와 ',sysdate,'모집완료',3,'f@f.com',6,'잠실');
insert into recruit_post (recruit_post_no,title,content,regdate,condition,capacity,member_email,small_category_no,location) 
values(recruit_post_no_seq.nextval,'헬로 차이나','제황황샤 마샹쯔야 진짱러',sysdate,'모집중',4,'g@g.com',7,'분당');
insert into recruit_post (recruit_post_no,title,content,regdate,condition,capacity,member_email,small_category_no,location) 
values(recruit_post_no_seq.nextval,'차이나 헬로?','니 취팔러마?',sysdate,'모집완료',8,'h@h.com',7,'잠실');
insert into recruit_post (recruit_post_no,title,content,regdate,condition,capacity,member_email,small_category_no,location) 
values(recruit_post_no_seq.nextval,'베트남어 하쉴?','또이 뗀 라 유란 또이 응어이 바무어이 짬',sysdate,'모집중',4,'g@g.com',8,'정자');
insert into recruit_post (recruit_post_no,title,content,regdate,condition,capacity,member_email,small_category_no,location) 
values(recruit_post_no_seq.nextval,'헬로 베트남','또이 무언 응언 안껌',sysdate,'모집중',3,'h@h.com',8,'용인');
insert into recruit_post (recruit_post_no,title,content,regdate,condition,capacity,member_email,small_category_no,location) 
values(recruit_post_no_seq.nextval,'러시아어 하실분','러시아어 잘해여? 스파시바',sysdate,'모집중',4,'g@g.com',9,'신촌');
insert into recruit_post (recruit_post_no,title,content,regdate,condition,capacity,member_email,small_category_no,location) 
values(recruit_post_no_seq.nextval,'Java 같이하실분','자바를 자바라 자바라? 자블래?',sysdate,'모집완료',5,'j@j.com',10,'판교');
insert into recruit_post (recruit_post_no,title,content,regdate,condition,capacity,member_email,small_category_no,location) 
values(recruit_post_no_seq.nextval,'C 같이 공부하실분','c를 공부를 어쩌구저쩌구 시간은 언제구 어쩌구 저쩌구',sysdate,'모집중',4,'a@a.com',11,'홍대');
insert into recruit_post (recruit_post_no,title,content,regdate,condition,capacity,member_email,small_category_no,location) 
values(recruit_post_no_seq.nextval,'안드로이드 프로그래밍 스터디','아이폰 쓰시는 분만',sysdate,'모집중',4,'k@k.com',12,'신촌');
insert into recruit_post (recruit_post_no,title,content,regdate,condition,capacity,member_email,small_category_no,location) 
values(recruit_post_no_seq.nextval,'파이썬하실분들 구해요','파이썬~!',sysdate,'모집중',3,'b@b.com',13,'종로');
insert into recruit_post (recruit_post_no,title,content,regdate,condition,capacity,member_email,small_category_no,location) 
values(recruit_post_no_seq.nextval,'프론트엔드 공부해 보실분들구해요','프론트프론트해',sysdate,'모집중',3,'j@k.com',14,'판교');
insert into recruit_post (recruit_post_no,title,content,regdate,condition,capacity,member_email,small_category_no,location) 
values(recruit_post_no_seq.nextval,'모여서 시 낭송 하실분들구해요','시를 낭송하시면서 내면의 평화를 찾으세요',sysdate,'모집중',5,'g@g.com',15,'분당');

insert into recruit_post (recruit_post_no,title,content,regdate,condition,capacity,member_email,small_category_no,location) 
values(recruit_post_no_seq.nextval,'자바 공부해요','시를 낭송하시면서 내면의 평화를 찾으세요',sysdate,'모집중',5,'g@g.com',1,'분당');
insert into recruit_post (recruit_post_no,title,content,regdate,condition,capacity,member_email,small_category_no,location) 
values(recruit_post_no_seq.nextval,'모여서 시 낭송 하실분들구해요','시를 낭송하시면서 내면의 평화를 찾으세요',sysdate,'모집중',5,'g@g.com',2,'분당');
insert into recruit_post (recruit_post_no,title,content,regdate,condition,capacity,member_email,small_category_no,location) 
values(recruit_post_no_seq.nextval,'모여서 시 낭송 하실분들구해요','시를 낭송하시면서 내면의 평화를 찾으세요',sysdate,'모집중',5,'g@g.com',3,'강남역');
insert into recruit_post (recruit_post_no,title,content,regdate,condition,capacity,member_email,small_category_no,location) 
values(recruit_post_no_seq.nextval,'모여서 시 낭송 하실분들구해요','시를 낭송하시면서 내면의 평화를 찾으세요',sysdate,'모집중',5,'g@g.com',4,'강남역');
insert into recruit_post (recruit_post_no,title,content,regdate,condition,capacity,member_email,small_category_no,location) 
values(recruit_post_no_seq.nextval,'모여서 시 낭송 하실분들구해요','시를 낭송하시면서 내면의 평화를 찾으세요',sysdate,'모집중',5,'g@g.com',5,'분당');
insert into recruit_post (recruit_post_no,title,content,regdate,condition,capacity,member_email,small_category_no,location) 
values(recruit_post_no_seq.nextval,'모여서 시 낭송 하실분들구해요','시를 낭송하시면서 내면의 평화를 찾으세요',sysdate,'모집중',5,'g@g.com',6,'분당');
insert into recruit_post (recruit_post_no,title,content,regdate,condition,capacity,member_email,small_category_no,location) 
values(recruit_post_no_seq.nextval,'모여서 시 낭송 하실분들구해요','시를 낭송하시면서 내면의 평화를 찾으세요',sysdate,'모집중',5,'g@g.com',7,'강남역');
insert into recruit_post (recruit_post_no,title,content,regdate,condition,capacity,member_email,small_category_no,location) 
values(recruit_post_no_seq.nextval,'모여서 시 낭송 하실분들구해요','시를 낭송하시면서 내면의 평화를 찾으세요',sysdate,'모집중',5,'g@g.com',8,'분당');
insert into recruit_post (recruit_post_no,title,content,regdate,condition,capacity,member_email,small_category_no,location) 
values(recruit_post_no_seq.nextval,'모여서 시 낭송 하실분들구해요','시를 낭송하시면서 내면의 평화를 찾으세요',sysdate,'모집중',5,'g@g.com',9,'강남');
insert into recruit_post (recruit_post_no,title,content,regdate,condition,capacity,member_email,small_category_no,location) 
values(recruit_post_no_seq.nextval,'모여서 시 낭송 하실분들구해요','시를 낭송하시면서 내면의 평화를 찾으세요',sysdate,'모집중',5,'g@g.com',10,'분당');
insert into recruit_post (recruit_post_no,title,content,regdate,condition,capacity,member_email,small_category_no,location) 
values(recruit_post_no_seq.nextval,'모여서 시 낭송 하실분들구해요','시를 낭송하시면서 내면의 평화를 찾으세요',sysdate,'모집중',5,'g@g.com',11,'신촌');
insert into recruit_post (recruit_post_no,title,content,regdate,condition,capacity,member_email,small_category_no,location) 
values(recruit_post_no_seq.nextval,'모여서 시 낭송 하실분들구해요','시를 낭송하시면서 내면의 평화를 찾으세요',sysdate,'모집중',5,'g@g.com',12,'분당');
insert into recruit_post (recruit_post_no,title,content,regdate,condition,capacity,member_email,small_category_no,location) 
values(recruit_post_no_seq.nextval,'모여서 시 낭송 하실분들구해요','시를 낭송하시면서 내면의 평화를 찾으세요',sysdate,'모집중',5,'g@g.com',13,'종로');
insert into recruit_post (recruit_post_no,title,content,regdate,condition,capacity,member_email,small_category_no,location) 
values(recruit_post_no_seq.nextval,'모여서 시 낭송 하실분들구해요','시를 낭송하시면서 내면의 평화를 찾으세요',sysdate,'모집중',5,'g@g.com',14,'분당');
insert into recruit_post (recruit_post_no,title,content,regdate,condition,capacity,member_email,small_category_no,location) 
values(recruit_post_no_seq.nextval,'모여서 시 낭송 하실분들구해요','시를 낭송하시면서 내면의 평화를 찾으세요',sysdate,'모집중',5,'g@g.com',15,'판교');
commit

--모집  선택
CREATE TABLE recruit_day 
(
	recruit_day_no number primary key ,
	day varchar(50) not null, 
	recruit_post_no not null,
	constraint fk_recruit_post_no foreign key(recruit_post_no) references recruit_post(recruit_post_no)
);

create sequence recruit_day_no_seq nocache;






insert into recruit_day(recruit_day_no,day,recruit_post_no) 
values(recruit_day_no_seq.nextval,'월',1);
insert into recruit_day(recruit_day_no,day,recruit_post_no) 
values(recruit_day_no_seq.nextval,'수',1);
insert into recruit_day(recruit_day_no,day,recruit_post_no) 
values(recruit_day_no_seq.nextval,'금',1);

insert into recruit_day(recruit_day_no,day,recruit_post_no) 
values(recruit_day_no_seq.nextval,'화',2);
insert into recruit_day(recruit_day_no,day,recruit_post_no) 
values(recruit_day_no_seq.nextval,'목',2);

insert into recruit_day(recruit_day_no,day,recruit_post_no) 
values(recruit_day_no_seq.nextval,'토',3);
insert into recruit_day(recruit_day_no,day,recruit_post_no) 
values(recruit_day_no_seq.nextval,'수',3);

insert into recruit_day(recruit_day_no,day,recruit_post_no) 
values(recruit_day_no_seq.nextval,'토',4);
insert into recruit_day(recruit_day_no,day,recruit_post_no) 
values(recruit_day_no_seq.nextval,'일',4);

insert into recruit_day(recruit_day_no,day,recruit_post_no) 
values(recruit_day_no_seq.nextval,'월',5);
insert into recruit_day(recruit_day_no,day,recruit_post_no) 
values(recruit_day_no_seq.nextval,'수',5);
insert into recruit_day(recruit_day_no,day,recruit_post_no) 
values(recruit_day_no_seq.nextval,'금',5);

insert into recruit_day(recruit_day_no,day,recruit_post_no) 
values(recruit_day_no_seq.nextval,'수',6);
insert into recruit_day(recruit_day_no,day,recruit_post_no) 
values(recruit_day_no_seq.nextval,'목',6);

insert into recruit_day(recruit_day_no,day,recruit_post_no) 
values(recruit_day_no_seq.nextval,'화',7);
insert into recruit_day(recruit_day_no,day,recruit_post_no) 
values(recruit_day_no_seq.nextval,'목',7);
insert into recruit_day(recruit_day_no,day,recruit_post_no) 
values(recruit_day_no_seq.nextval,'토',7);

insert into recruit_day(recruit_day_no,day,recruit_post_no) 
values(recruit_day_no_seq.nextval,'화',8);
insert into recruit_day(recruit_day_no,day,recruit_post_no) 
values(recruit_day_no_seq.nextval,'목',8);

insert into recruit_day(recruit_day_no,day,recruit_post_no) 
values(recruit_day_no_seq.nextval,'토',9);

insert into recruit_day(recruit_day_no,day,recruit_post_no) 
values(recruit_day_no_seq.nextval,'수',10);

insert into recruit_day(recruit_day_no,day,recruit_post_no) 
values(recruit_day_no_seq.nextval,'월',11);
insert into recruit_day(recruit_day_no,day,recruit_post_no) 
values(recruit_day_no_seq.nextval,'토',11);

insert into recruit_day(recruit_day_no,day,recruit_post_no) 
values(recruit_day_no_seq.nextval,'수',12);
insert into recruit_day(recruit_day_no,day,recruit_post_no) 
values(recruit_day_no_seq.nextval,'토',12);

insert into recruit_day(recruit_day_no,day,recruit_post_no) 
values(recruit_day_no_seq.nextval,'월',13);
insert into recruit_day(recruit_day_no,day,recruit_post_no) 
values(recruit_day_no_seq.nextval,'금',13);

insert into recruit_day(recruit_day_no,day,recruit_post_no) 
values(recruit_day_no_seq.nextval,'목',14);

insert into recruit_day(recruit_day_no,day,recruit_post_no) 
values(recruit_day_no_seq.nextval,'화',15);

insert into recruit_day(recruit_day_no,day,recruit_post_no) 
values(recruit_day_no_seq.nextval,'화',3);
insert into recruit_day(recruit_day_no,day,recruit_post_no) 
values(recruit_day_no_seq.nextval,'금',16);

insert into recruit_day(recruit_day_no,day,recruit_post_no) 
values(recruit_day_no_seq.nextval,'금',17);

insert into recruit_day(recruit_day_no,day,recruit_post_no) 
values(recruit_day_no_seq.nextval,'화',18);
insert into recruit_day(recruit_day_no,day,recruit_post_no) 
values(recruit_day_no_seq.nextval,'일',18);

insert into recruit_day(recruit_day_no,day,recruit_post_no) 
values(recruit_day_no_seq.nextval,'월',19);
insert into recruit_day(recruit_day_no,day,recruit_post_no) 
values(recruit_day_no_seq.nextval,'토',19);

insert into recruit_day(recruit_day_no,day,recruit_post_no) 
values(recruit_day_no_seq.nextval,'화',20);
insert into recruit_day(recruit_day_no,day,recruit_post_no) 
values(recruit_day_no_seq.nextval,'수',20);

insert into recruit_day(recruit_day_no,day,recruit_post_no) 
values(recruit_day_no_seq.nextval,'금',21);

insert into recruit_day(recruit_day_no,day,recruit_post_no) 
values(recruit_day_no_seq.nextval,'월',22);
insert into recruit_day(recruit_day_no,day,recruit_post_no) 
values(recruit_day_no_seq.nextval,'수',22);

insert into recruit_day(recruit_day_no,day,recruit_post_no) 
values(recruit_day_no_seq.nextval,'토',23);


--모집 게시글 댓글
drop table recruit_post_comment;
CREATE TABLE recruit_post_comment
(
	recruit_comment_no number primary key ,
	content clob not null,
	member_email varchar2(100) not null,
	regdate date not null, 
	recruit_post_no number not null,
	constraint fk2_recruit_post_no foreign key(recruit_post_no) references recruit_post(recruit_post_no),
	constraint fk2member_email foreign key(member_email) references member(member_email)
);
drop sequence recruit_comment_no_seq
create sequence recruit_comment_no_seq nocache;


insert into recruit_post_comment(recruit_comment_no, content, member_email, regdate, recruit_post_no)
values(recruit_comment_no_seq.nextval, '혹시 월수만 참여해도 될까요?', 'd@d.com' ,sysdate,1);
insert into recruit_post_comment(recruit_comment_no, content, member_email, regdate, recruit_post_no)
values(recruit_comment_no_seq.nextval, '스터디 시간이 안 적혀있네요..','e@e.com' ,sysdate,1);
insert into recruit_post_comment(recruit_comment_no, content, member_email, regdate, recruit_post_no)
values(recruit_comment_no_seq.nextval, '화목 싫은데요? 에벱베베','c@c.com' ,sysdate,1);

drop table study_condition cascade constraint
--회원이 신청한 스터디 현황
CREATE TABLE study_condition
(
	study_condition_no number primary key,
	regdate date not null,
	state varchar2(100) default '미승인',
	self_appeal varchar2(100) not null,
	recruit_post_no number not null,
	member_email varchar2(100) not null,
	constraint fk3_recruit_post_no foreign key(recruit_post_no) references recruit_post(recruit_post_no),
	constraint fk3_member_email foreign key(member_email) references member(member_email)
);
create sequence study_condition_no_seq nocache;
drop sequence study_condition_no_seq

insert into study_condition(study_condition_no, regdate, state, self_appeal, member_email, recruit_post_no)
values(study_condition_no_seq.nextval, sysdate, '미승인', '열심히 할게요 ! ', 'f@f.com', 1);
insert into study_condition(study_condition_no, regdate, state, self_appeal, member_email, recruit_post_no)
values(study_condition_no_seq.nextval, sysdate, '거절', '열심히 할게요 ! ', 'd@d.com', 1); --def
insert into study_condition(study_condition_no, regdate, state, self_appeal, member_email, recruit_post_no)
values(study_condition_no_seq.nextval, sysdate, '승인', '열심히 할게요 ! ', 'e@e.com', 1); --def
insert into study_condition(study_condition_no, regdate, state, self_appeal, member_email, recruit_post_no)
values(study_condition_no_seq.nextval, sysdate, '승인', '열심히 할게요 ! ', 'h@h.com', 1); --def
insert into study_condition(study_condition_no, regdate, state, self_appeal, member_email, recruit_post_no)
values(study_condition_no_seq.nextval, sysdate, '미승인', '열심히 할게요 ! ', 'g@g.com', 1); --def

commit
