--모집 완료된 스터디
create table study_group (
	sg_no number primary key,
	name varchar2(100) not null,
	recruit_post_no number not null,
	constraint fk4_recruit_post_no foreign key(recruit_post_no) references recruit_post(recruit_post_no)
);


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


insert into study_group (sg_no, name, recruit_post_no) values (study_group_seq.nextval, '24', 24);
insert into study_group (sg_no, name, recruit_post_no) values (study_group_seq.nextval, '25', 25);
insert into study_group (sg_no, name, recruit_post_no) values (study_group_seq.nextval, '26', 26);
insert into study_group (sg_no, name, recruit_post_no) values (study_group_seq.nextval, '27', 27);
insert into study_group (sg_no, name, recruit_post_no) values (study_group_seq.nextval, '28', 28);
insert into study_group (sg_no, name, recruit_post_no) values (study_group_seq.nextval, '29', 29);
insert into study_group (sg_no, name, recruit_post_no) values (study_group_seq.nextval, '30', 30);
insert into study_group (sg_no, name, recruit_post_no) values (study_group_seq.nextval, '31', 31);
insert into study_group (sg_no, name, recruit_post_no) values (study_group_seq.nextval, '32', 32);
insert into study_group (sg_no, name, recruit_post_no) values (study_group_seq.nextval, '33', 33);
insert into study_group (sg_no, name, recruit_post_no) values (study_group_seq.nextval, '34', 34);
insert into study_group (sg_no, name, recruit_post_no) values (study_group_seq.nextval, '35', 35);
insert into study_group (sg_no, name, recruit_post_no) values (study_group_seq.nextval, '36', 36);
insert into study_group (sg_no, name, recruit_post_no) values (study_group_seq.nextval, '37', 37);
insert into study_group (sg_no, name, recruit_post_no) values (study_group_seq.nextval, '38', 38);


--모집 완료된 스터디 구성원
create table sg_member(
	sg_member_no number primary key,
	sg_no number not null,
	member_email varchar2(100) not null,
	position varchar2(100) not null,
	state varchar2(100) default 'false',
	constraint fk_sg_no foreign key(sg_no) references study_group(sg_no),
	constraint fk22_member_email foreign key(member_email) references member(member_email)
);


select*from sg_member
create sequence sg_member_seq nocache;

insert into sg_member (sg_member_no, sg_no, member_email, position) values(sg_member_seq.nextval, 1, 'a@a.com', '팀장');
insert into sg_member (sg_member_no, sg_no, member_email, position) values(sg_member_seq.nextval, 2, 'b@b.com', '팀장');
insert into sg_member (sg_member_no, sg_no, member_email, position) values(sg_member_seq.nextval, 3, 'a@a.com', '팀장');
insert into sg_member (sg_member_no, sg_no, member_email, position) values(sg_member_seq.nextval, 4, 'b@b.com', '팀장');
insert into sg_member (sg_member_no, sg_no, member_email, position) values(sg_member_seq.nextval, 5, 'c@c.com', '팀장');
insert into sg_member (sg_member_no, sg_no, member_email, position) values(sg_member_seq.nextval, 6, 'd@d.com', '팀장');
insert into sg_member (sg_member_no, sg_no, member_email, position) values(sg_member_seq.nextval, 7, 'c@c.com', '팀장');
insert into sg_member (sg_member_no, sg_no, member_email, position) values(sg_member_seq.nextval, 8, 'd@d.com', '팀장');
insert into sg_member (sg_member_no, sg_no, member_email, position) values(sg_member_seq.nextval, 9, 'e@e.com', '팀장');
insert into sg_member (sg_member_no, sg_no, member_email, position) values(sg_member_seq.nextval, 10, 'f@f.com', '팀장');
insert into sg_member (sg_member_no, sg_no, member_email, position) values(sg_member_seq.nextval, 11, 'e@e.com', '팀장');
insert into sg_member (sg_member_no, sg_no, member_email, position) values(sg_member_seq.nextval, 12, 'f@f.com', '팀장');
insert into sg_member (sg_member_no, sg_no, member_email, position) values(sg_member_seq.nextval, 13, 'g@g.com', '팀장');
insert into sg_member (sg_member_no, sg_no, member_email, position) values(sg_member_seq.nextval, 14, 'h@h.com', '팀장');
insert into sg_member (sg_member_no, sg_no, member_email, position) values(sg_member_seq.nextval, 15, 'g@g.com', '팀장');
insert into sg_member (sg_member_no, sg_no, member_email, position) values(sg_member_seq.nextval, 16, 'h@h.com', '팀장');
insert into sg_member (sg_member_no, sg_no, member_email, position) values(sg_member_seq.nextval, 17, 'i@i.com', '팀장');
insert into sg_member (sg_member_no, sg_no, member_email, position) values(sg_member_seq.nextval, 18, 'j@j.com', '팀장');
insert into sg_member (sg_member_no, sg_no, member_email, position) values(sg_member_seq.nextval, 19, 'i@i.com', '팀장');
insert into sg_member (sg_member_no, sg_no, member_email, position) values(sg_member_seq.nextval, 20, 'k@k.com', '팀장');
insert into sg_member (sg_member_no, sg_no, member_email, position) values(sg_member_seq.nextval, 21, 'j@j.com', '팀장');
insert into sg_member (sg_member_no, sg_no, member_email, position) values(sg_member_seq.nextval, 22, 'l@l.com', '팀장');
insert into sg_member (sg_member_no, sg_no, member_email, position) values(sg_member_seq.nextval, 23, 'g@g.com', '팀장');
insert into sg_member (sg_member_no, sg_no, member_email, position) values(sg_member_seq.nextval, 24, 'g@g.com', '팀장');
insert into sg_member (sg_member_no, sg_no, member_email, position) values(sg_member_seq.nextval, 25, 'g@g.com', '팀장');
insert into sg_member (sg_member_no, sg_no, member_email, position) values(sg_member_seq.nextval, 26, 'g@g.com', '팀장');
insert into sg_member (sg_member_no, sg_no, member_email, position) values(sg_member_seq.nextval, 27, 'g@g.com', '팀장');
insert into sg_member (sg_member_no, sg_no, member_email, position) values(sg_member_seq.nextval, 28, 'g@g.com', '팀장');
insert into sg_member (sg_member_no, sg_no, member_email, position) values(sg_member_seq.nextval, 29, 'g@g.com', '팀장');
insert into sg_member (sg_member_no, sg_no, member_email, position) values(sg_member_seq.nextval, 30, 'g@g.com', '팀장');
insert into sg_member (sg_member_no, sg_no, member_email, position) values(sg_member_seq.nextval, 31, 'g@g.com', '팀장');
insert into sg_member (sg_member_no, sg_no, member_email, position) values(sg_member_seq.nextval, 32, 'g@g.com', '팀장');
insert into sg_member (sg_member_no, sg_no, member_email, position) values(sg_member_seq.nextval, 33, 'g@g.com', '팀장');
insert into sg_member (sg_member_no, sg_no, member_email, position) values(sg_member_seq.nextval, 34, 'g@g.com', '팀장');
insert into sg_member (sg_member_no, sg_no, member_email, position) values(sg_member_seq.nextval, 35, 'g@g.com', '팀장');
insert into sg_member (sg_member_no, sg_no, member_email, position) values(sg_member_seq.nextval, 36, 'g@g.com', '팀장');
insert into sg_member (sg_member_no, sg_no, member_email, position) values(sg_member_seq.nextval, 37, 'g@g.com', '팀장');
insert into sg_member (sg_member_no, sg_no, member_email, position) values(sg_member_seq.nextval, 38, 'g@g.com', '팀장');
insert into sg_member (sg_member_no, sg_no, member_email, position) values(sg_member_seq.nextval, 1, 'e@e.com', '팀원');
insert into sg_member (sg_member_no, sg_no, member_email, position) values(sg_member_seq.nextval, 1, 'h@h.com', '팀원');
insert into sg_member (sg_member_no, sg_no, member_email, position) values(sg_member_seq.nextval, 1, 'g@g.com', '팀원');
commit


insert into sg_member (sg_member_no, sg_no, member_email, position) values(sg_member_seq.nextval, 1, 'a@a.com', '팀장');
insert into sg_member (sg_member_no, sg_no, member_email, position) values(sg_member_seq.nextval, 1, 'b@b.com', '팀원');
insert into sg_member (sg_member_no, sg_no, member_email, position) values(sg_member_seq.nextval, 1, 'a@a.com', '팀원');
insert into sg_member (sg_member_no, sg_no, member_email, position) values(sg_member_seq.nextval, 1, 'b@b.com', '팀원');
insert into sg_member (sg_member_no, sg_no, member_email, position) values(sg_member_seq.nextval, 1, 'c@c.com', '팀원');
insert into sg_member (sg_member_no, sg_no, member_email, position) values(sg_member_seq.nextval, 1, 'd@d.com', '팀원');
insert into sg_member (sg_member_no, sg_no, member_email, position) values(sg_member_seq.nextval, 1, 'c@c.com', '팀원');
insert into sg_member (sg_member_no, sg_no, member_email, position) values(sg_member_seq.nextval, 1, 'd@d.com', '팀원');
insert into sg_member (sg_member_no, sg_no, member_email, position) values(sg_member_seq.nextval, 1, 'e@e.com', '팀원');
insert into sg_member (sg_member_no, sg_no, member_email, position) values(sg_member_seq.nextval, 1, 'f@f.com', '팀원');
insert into sg_member (sg_member_no, sg_no, member_email, position) values(sg_member_seq.nextval, 1, 'e@e.com', '팀원');
insert into sg_member (sg_member_no, sg_no, member_email, position) values(sg_member_seq.nextval, 1, 'f@f.com', '팀원');
insert into sg_member (sg_member_no, sg_no, member_email, position) values(sg_member_seq.nextval, 1, 'g@g.com', '팀원');
insert into sg_member (sg_member_no, sg_no, member_email, position) values(sg_member_seq.nextval, 1, 'h@h.com', '팀원');
insert into sg_member (sg_member_no, sg_no, member_email, position) values(sg_member_seq.nextval, 1, 'g@g.com', '팀원');
insert into sg_member (sg_member_no, sg_no, member_email, position) values(sg_member_seq.nextval, 1, 'h@h.com', '팀원');
insert into sg_member (sg_member_no, sg_no, member_email, position) values(sg_member_seq.nextval, 1, 'i@i.com', '팀원');
insert into sg_member (sg_member_no, sg_no, member_email, position) values(sg_member_seq.nextval, 1, 'j@j.com', '팀원');
insert into sg_member (sg_member_no, sg_no, member_email, position) values(sg_member_seq.nextval, 1, 'i@i.com', '팀원');
insert into sg_member (sg_member_no, sg_no, member_email, position) values(sg_member_seq.nextval, 1, 'k@k.com', '팀원');


select sgm.sg_member_no, sgm.position, m.name, sgm.state, sg.sg_no
	from sg_member sgm, study_group sg, member m
	where sgm.sg_no=sg.sg_no and m.member_email=sgm.member_email
	and sgm.sg_no=3

	update sg_member set position='팀원' where sg_member_no=1
	
select sgm.sg_member_no, m.name, sgm.position
from study_group sg, sg_member sgm, member m
where sg.sg_no=sgm.sg_no and sgm.member_email=m.member_email

select member_email, name, position, sg_no, sg_member_no
from(
			select row_number() over(order by sg_member_no) rnum, 
							m.member_email, m.name, sgm.position, sgm.sg_no, sgm.sg_member_no
							from member m, sg_member sgm, study_group sg
							where sgm.sg_no=sg.sg_no
							and sg.sg_no=1
							and m.member_email = sgm.member_email)
where rnum between 1 and 5 

--모집 완료된 스터디 일정
create table sg_schedule(
	sg_schedule_no number primary key,
	sg_no number not null,
	start_date date not null,
	end_date date not null,
	sg_member_no number not null,
	content varchar2(100) not null,
	constraint fk2_sg_no foreign key(sg_no) references study_group(sg_no),
	constraint fk21_sg_member_no foreign key(sg_member_no) references sg_member(sg_member_no)
);
drop table sg_schedule
drop sequence sg_schedule_seq
create sequence sg_schedule_seq nocache;
insert into sg_schedule(sg_schedule_no, sg_no, start_date, end_date, content, sg_member_no) 
values(sg_schedule_seq.nextval, 1, to_date('2018-06-04','YYYY-MM-DD'), to_date('2018-05-31','YYYY-MM-DD'), '면접 대비', 2);

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
	sg_member_no number not null,
	constraint fk33_sg_no foreign key(sg_no) references study_group(sg_no),
	constraint fk33_sg_member_no foreign key(sg_member_no) references sg_member(sg_member_no)
);
select * from SG_POST


create sequence sg_post_seq nocache;
insert into sg_post(sg_post_no, sg_no, title,  content, regdate, sg_member_no) 
values(sg_post_seq.nextval, 1, '첫글이네요', '다들 성공하세요', sysdate, 2);

--모집 완료된 스터디 게시글 댓글
drop table sg_post_comment;
create table sg_post_comment(
	sg_comment_no number primary key,
	content clob not null,
	sg_post_no number not null,
	sg_member_no number not null,
	regdate date not null,
	constraint fk_sg_post_no foreign key(sg_post_no) references sg_post(sg_post_no),
	constraint fk12_sg_member_no foreign key(sg_member_no) references sg_member(sg_member_no)
);
drop sequence sg_post_comment_seq;
create sequence sg_post_comment_seq nocache;

insert into sg_post_comment(sg_comment_no, content, sg_post_no, sg_member_no, regdate)
values (sg_post_comment_seq.nextval, '첫 모임', 1, 2, sysdate);

select p.title, c.content
from sg_post p, sg_post_comment c
where p.sg_post_no=c.sg_post_no

--모집 완료된 스터디 게시글 사진
create table sg_post_pic (
	sg_post_pic_no number primary key,
	path varchar2(100) default 'default.png',
	sg_post_no number not null,
	constraint fk2_sg_post_no foreign key(sg_post_no) references sg_post(sg_post_no)
);

create sequence sg_post_pic_seq nocache;
insert into sg_post_pic(sg_post_pic_no, sg_post_no) values(sg_post_pic_seq.nextval, 1);

commit

select * from sg_member where member_email='a@a.com'