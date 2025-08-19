--Assignment
--1.numeric from alphanumeric
create table dbo.alpha(id int primary key identity(1,1),alphaNum varchar(30));

insert into alpha(alphaNum) values('bsd2872eydjb123'),
        ('hdcbh37bw6272'),('vdh172bhjjh1 1g72718'),('wdg1331414555&^');
select * from alpha;
go

create function dbo.alphaNumeric(@str varchar(30))
returns varchar(30)
as
begin
declare @index INT;
--declare @str varchar(30);
--set @str='hwklo dw1236hjjd2735';
--declare @ans varchar(30)='';
set @index=patindex('%[^0-9]%',@str);
while @index>0
    begin
    set @str=stuff(@str,@index,1,'');
    set @index=patindex('%[^0-9]%',@str);
    end
return @str
end;
go
select id,alphaNum,dbo.alphaNumeric(alphaNum) as num from alpha;
go


--2.get age from dob
create table Employee(emp_id int primary key identity(1,1),emp_name varchar(30),emp_salary decimal,dept_id int,location varchar(30),dob date);
insert into Employee (emp_name,emp_salary,dept_id,location,dob)
			values('Shirisha Mangali',300000,1,'medak','2003-08-15'),
			('Vilva Priya Koma',300000,2,'kavali','2004-02-21'),
			('Srinivas Ryakala',300000,3,'mancheryal','2003-06-26'),
			('Saketh Macha',300000,3,'Siddippet','2002-06-03'),
			('Laxmi Swaroopa Bandaru',300000,1,'vizag','2003-07-21');
go

create function getAge(@dob date) returns int
as 
    begin
        declare @today date=getdate();
        declare @years int =datediff(year,@dob,@today);
        if @years=0 return @years;
        if (month(@dob)>month(@today)) or ((month(@dob)=month(@today)) and (day(@dob)>day(@today)))
            begin 
            set @years=@years-1;
            end
return @years 
end
go

select emp_id , emp_name ,dbo.getAge(dob) as age from Employee ;




--3.Create a column in a table and that should throw an error when we do SELECT * or SELECT of that column. If we select other columns then we should see results
create table err(id int ,val int, err_col as cast('dgjhf' as int));
insert into err(id,val) values(1,10),(2,20),(3,40),(4,30);
select * from err;
select id,val from err;

create table err1(id int ,val int, err_col as (1/0));
insert into err1(id,val) values(1,10),(2,20),(3,40),(4,30);
select * from err1;
select id,val from err1;


--4. Display Calendar Table based on the input year. If I give the year 2017 then populate data for 2017 only
declare @ipdate date ='2017-04-30';
select datepart(dayofyear, @ipdate) dayOfYr;
select datepart(week, @ipdate) weekInYr;
select datepart(weekday,@ipdate) as dayOfweek;
select datepart(month,@ipdate) as mnth;
select datepart(day,@ipdate) as dayOfMonth;

select emp_id,emp_name,dob,datepart(dayofyear, dob) dayOfYr,datepart(week, dob) weekInYr,datepart(weekday,dob) as dayOfweek,datepart(month,dob) as mnth,datepart(day,dob) as dayOfMonth from Employee;


--5.employee hierarchy
create table emp (
    empid int primary key,
    empname varchar(50),
    managerid int null
);

insert into emp(empid, empname, managerid) values
(1, 'alice', null),       
(2, 'bob', 1),
(3, 'charlie', 2),        
(4, 'david', 2),          
(5, 'eve', 3),            
(6, 'frank', 3),          
(7, 'grace', 4),          
(8, 'heidi', 5);          

use [311];
;with hierarchy as(
    
    select empid,empname,managerid ,empname as managername,1 as hierarchylevel from emp where managerid is null 

union all

select e.empid,e.empname,e.managerid,eh.empname as managername,eh.hierarchylevel+1 as hierarchylevel from emp e join hierarchy eh on e.managerid=eh.empid
)
select * from hierarchy;
