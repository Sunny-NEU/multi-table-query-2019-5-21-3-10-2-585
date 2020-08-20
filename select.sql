# 1.查询同时存在1课程和2课程的情况
select t1.studentId,t1.score score_1,t2.score score_2
  from 
	(select *
	  from student_course 
	 where courseId=1) t1
	 ,
	 (select *
	  from student_course 
	 where courseId=2) t2
  where t1.studentId=t2.studentId
 ;
# 2.查询同时存在1课程和2课程的情况
-- 同第一题
# 3.查询平均成绩大于等于60分的同学的学生编号和学生姓名和平均成绩
select s.id,
       s.name,
	   t2.avg_score
  from student s
 inner join 
	(select t.studentId,
		   avg(t.score) as avg_score
	  from student_course t 
	  left join student t1 
		on t.studentId=t1.id
	 group by t.studentId
	having avg(t.score)>=60) t2
    on s.id=t2.studentId;
# 4.查询在student_course表中不存在成绩的学生信息的SQL语句
select t2.id
	  ,t2.name
	  ,t2.age
	  ,t2.sex
  from
   (select * from student t
	  left join student_course t1
		on t.id=t1.studentId) t2
	where t2.studentId is null;
# 5.查询所有有成绩的SQL
select distinct t.id
	  ,t.name
	  ,t.age
	  ,t.sex
  from student t
  inner join student_course t1
	 on t.id=t1.studentId;
# 6.查询学过编号为1并且也学过编号为2的课程的同学的信息
select t3.*
  from 
	(select studentId
	  from student_course
	  where courseId=1) t1
  inner join student_course t2
  on t1.studentId=t2.studentId and t2.courseId=2
  left join student t3
    on t1.studentId=t3.id

# 7.检索1课程分数小于60，按分数降序排列的学生信息
select t1.id,t1.name,t1.age,t1.sex
  from
	(select * 
	  from student_course
	 where courseId=1 and score<60) t
  left join student t1
    on t1.id=t.studentId
 order by score desc;
# 8.查询每门课程的平均成绩，结果按平均成绩降序排列，平均成绩相同时，按课程编号升序排列
select courseId,
       avg(score) avg_score
  from student_course
 group by courseId
 order by avg_score desc, courseId asc;
# 9.查询课程名称为"数学"，且分数低于60的学生姓名和分数
select t2.name,t1.score
  from
	(select id 
	  from course
	 where name='数学') t
   left join student_course t1
     on t.id=t1.courseId and t1.score<60
   left join student t2
     on t1.studentId=t2.id
;
