--모집 완료된 스터디
create table study_group (
	sg_no number primary key,
	name varchar2(100) not null,
	recruit_post_no number not null,
	constraint fk4_recruit_post_no foreign key(recruit_post_no) references recruit_post(recruit_post_no)
)

create sequence study_group_seq nocache;
select * from study_group

insert into study_group (sg_no, name, recruit_post_no) values (study_group_seq.nextval, '대기업스터디', 1);
insert into study_group (sg_no, name, recruit_post_no) values (study_group_seq.nextval, '대기업스터디2', 2);
insert into study_group (sg_no, name, recruit_post_no) values (study_group_seq.nextval, '중소기업1', 3);
insert into study_group (sg_no, name, recruit_post_no) values (study_group_seq.nextval, '중소기업2', 4);
insert into study_group (sg_no, name, recruit_post_no) values (study_group_seq.nextval, '공기업1', 5);
insert into study_group (sg_no, name, recruit_post_no) values (study_group_seq.nextval, '공기업2', 6);
insert into study_group (sg_no, name, recruit_post_no) values (study_group_seq.nextval, '해외기업', 7);
insert into study_group (sg_no, name, recruit_post_no) values (study_group_seq.nextval, '링가링가', 8);
insert into study_group (sg_no, name, recruit_post_no) values (study_group_seq.nextval, 'DYKK', 9);
insert into study_group (sg_no, name, recruit_post_no) values (study_group_seq.nextval, '토스토', 10);
insert into study_group (sg_no, name, recruit_post_no) values (study_group_seq.nextval, '일본어뽀개기', 11);
insert into study_group (sg_no, name, recruit_post_no) values (study_group_seq.nextval, '가자 일본', 12);
insert into study_group (sg_no, name, recruit_post_no) values (study_group_seq.nextval, '헬로 차이나', 13);
insert into study_group (sg_no, name, recruit_post_no) values (study_group_seq.nextval, '고고차', 14);
insert into study_group (sg_no, name, recruit_post_no) values (study_group_seq.nextval, '시진핑', 15);
insert into study_group (sg_no, name, recruit_post_no) values (study_group_seq.nextval, '탑 오브 하노이', 16);
insert into study_group (sg_no, name, recruit_post_no) values (study_group_seq.nextval, '스파시바', 17);
insert into study_group (sg_no, name, recruit_post_no) values (study_group_seq.nextval, '자블라니', 18);
insert into study_group (sg_no, name, recruit_post_no) values (study_group_seq.nextval, '씨뿌리기', 19);
insert into study_group (sg_no, name, recruit_post_no) values (study_group_seq.nextval, '알파고님 충성충성', 20);
insert into study_group (sg_no, name, recruit_post_no) values (study_group_seq.nextval, '쏀빠이', 21);
insert into study_group (sg_no, name, recruit_post_no) values (study_group_seq.nextval, '프론트엔드', 22);
insert into study_group (sg_no, name, recruit_post_no) values (study_group_seq.nextval, '시낭송', 23);


--모집 완료된 스터디 구성원
create table sg_member(
	sg_member_no number primary key,
	sg_no number not null,
	email varchar2(100) not null,
	position varchar2(100) not null,
	state varchar2(100) not null,
	constraint fk_sg_no foreign key(sg_no) references study_group(sg_no)
) 
select*from sg_member
create sequence sg_member_seq nocache;
insert into sg_member (sg_member_no, sg_no, email, position, state) values(sg_member_seq.nextval, 1, 'a@a.com', '팀장', '활동중');
insert into sg_member (sg_member_no, sg_no, email, position, state) values(sg_member_seq.nextval, 2, 'b@b.com', '팀장', '활동중');
insert into sg_member (sg_member_no, sg_no, email, position, state) values(sg_member_seq.nextval, 3, 'a@a.com', '팀장', '활동중');
insert into sg_member (sg_member_no, sg_no, email, position, state) values(sg_member_seq.nextval, 4, 'b@b.com', '팀장', '활동중');
insert into sg_member (sg_member_no, sg_no, email, position, state) values(sg_member_seq.nextval, 5, 'c@c.com', '팀장', '활동중');
insert into sg_member (sg_member_no, sg_no, email, position, state) values(sg_member_seq.nextval, 6, 'd@d.com', '팀장', '활동중');
insert into sg_member (sg_member_no, sg_no, email, position, state) values(sg_member_seq.nextval, 7, 'c@c.com', '팀장', '활동중');
insert into sg_member (sg_member_no, sg_no, email, position, state) values(sg_member_seq.nextval, 8, 'd@d.com', '팀장', '활동중');
insert into sg_member (sg_member_no, sg_no, email, position, state) values(sg_member_seq.nextval, 9, 'e@e.com', '팀장', '활동중');
insert into sg_member (sg_member_no, sg_no, email, position, state) values(sg_member_seq.nextval, 10, 'f@f.com', '팀장', '활동중');
insert into sg_member (sg_member_no, sg_no, email, position, state) values(sg_member_seq.nextval, 11, 'e@e.com', '팀장', '활동중');
insert into sg_member (sg_member_no, sg_no, email, position, state) values(sg_member_seq.nextval, 12, 'f@f.com', '팀장', '활동중');
insert into sg_member (sg_member_no, sg_no, email, position, state) values(sg_member_seq.nextval, 13, 'g@g.com', '팀장', '활동중');
insert into sg_member (sg_member_no, sg_no, email, position, state) values(sg_member_seq.nextval, 14, 'h@h.com', '팀장', '활동중');
insert into sg_member (sg_member_no, sg_no, email, position, state) values(sg_member_seq.nextval, 15, 'g@g.com', '팀장', '활동중');
insert into sg_member (sg_member_no, sg_no, email, position, state) values(sg_member_seq.nextval, 16, 'h@h.com', '팀장', '활동중');
insert into sg_member (sg_member_no, sg_no, email, position, state) values(sg_member_seq.nextval, 17, 'i@i.com', '팀장', '활동중');
insert into sg_member (sg_member_no, sg_no, email, position, state) values(sg_member_seq.nextval, 18, 'a@b.com', '팀장', '활동중');
insert into sg_member (sg_member_no, sg_no, email, position, state) values(sg_member_seq.nextval, 19, 'i@i.com', '팀장', '활동중');
insert into sg_member (sg_member_no, sg_no, email, position, state) values(sg_member_seq.nextval, 20, 'a@b.com', '팀장', '활동중');
insert into sg_member (sg_member_no, sg_no, email, position, state) values(sg_member_seq.nextval, 21, 'b@c.com', '팀장', '활동중');
insert into sg_member (sg_member_no, sg_no, email, position, state) values(sg_member_seq.nextval, 22, 'b@c.com', '팀장', '활동중');
insert into sg_member (sg_member_no, sg_no, email, position, state) values(sg_member_seq.nextval, 23, 'g@g.com', '팀장', '활동중');


select sg.name, m.name, sgm.position
from study_group sg, sg_member sgm, member m
where sg.sg_no=sgm.sg_no and sgm.email=m.member_email

--모집 완료된 스터디 일정
create table sg_schedule(
	sg_schedule_no number primary key,
	sg_no number not null,
	start_date date not null,
	end_date date not null,
	name varchar2(100) not null,
	content varchar2(100) not null,
	constraint fk2_sg_no foreign key(sg_no) references study_group(sg_no)
)

create sequence sg_schedule_seq nocache;
insert into sg_schedule(sg_schedule_no, sg_no, start_date, end_date, content, name) 
values(sg_schedule_seq.nextval, 1, to_date('2018-05-30','YYYY-MM-DD'), to_date('2018-05-31','YYYY-MM-DD'), '면접 대비', '아이유');

select sg.name, s.start_date, s.end_date, s.content
from study_group sg, sg_schedule s
where sg.sg_no=s.sg_no

--모집 완료된 스터디 게시글
create table sg_post(
	sg_post_no number primary key,
	sg_no number not null,
	title varchar2(100) not null,
	content clob not null,
	regdate date not null,
	hit number  default 0,
	name varchar2(100) not null,
	constraint fk3_sg_no foreign key(sg_no) references study_group(sg_no)
)
select * from SG_POST


create sequence sg_post_seq nocache;
insert into sg_post(sg_post_no, sg_no, title,  content, regdate, hit, name) 
values(sg_post_seq.nextval, 1, '첫글이네요', '다들 성공하세요', sysdate, 1, '아이유');

--모집 완료된 스터디 게시글 댓글
drop table sg_post_comment;
create table sg_post_comment(
	sg_comment_no number primary key,
	content clob not null,
	sg_post_no number not null,
	member_email varchar2(100) not null,
	regdate date not null,
	constraint fk_sg_post_no foreign key(sg_post_no) references sg_post(sg_post_no),
	constraint fk12member_email foreign key(member_email) references member(member_email)
)
drop sequence sg_post_comment_seq;
create sequence sg_post_comment_seq nocache;

insert into sg_post_comment(sg_comment_no, content, sg_post_no, member_email, regdate)
values (sg_post_comment_seq.nextval, '첫 모임', 1, 'a@a.com', sysdate);

select p.title, c.content
from sg_post p, sg_post_comment c
where p.sg_post_no=c.sg_post_no

--모집 완료된 스터디 게시글 사진
create table sg_post_pic (
	sg_post_pic_no number primary key,
	path varchar2(100) not null,
	sg_post_no number not null,
	constraint fk2_sg_post_no foreign key(sg_post_no) references sg_post(sg_post_no)
);

create sequence sg_post_pic_seq nocache;
insert into sg_post_pic(sg_post_pic_no, path, sg_post_no) values(sg_post_pic_seq.nextval, 'image.png', 1);
