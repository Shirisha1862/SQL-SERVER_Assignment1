
drop table if exists Employee;
create table Employee(emp_id int primary key identity(1,1),emp_name varchar(30),emp_salary decimal,dept_id int,location varchar(30),dob date);
insert into Employee (emp_name,emp_salary,dept_id,location,dob)
			values('Shirisha Mangali',300000,1,'medak','2003-08-15'),
			('Vilva Priya Koma',300000,2,'kavali','2004-02-21'),
			('Srinivas Ryakala',300000,3,'mancheryal','2003-06-26'),
			('Saketh Macha',300000,3,'Siddippet','2002-06-03'),
			('Laxmi Swaroopa Bandaru',300000,1,'vizag','2003-07-21');
insert into Employee (emp_name, emp_salary, dept_id, location, dob)
values
('Anusha Reddy', 280000, 2, 'Hyderabad', '2001-11-12'),
('Rohit Sharma', 350000, 1, 'Mumbai', '1999-04-25'),
('Kiran Kumar', 400000, 3, 'Warangal', '2000-12-30'),
('Meghana Goud', 270000, 2, 'Karimnagar', '2002-05-10'),
('Sathvik Raju', 320000, 1, 'Chennai', '2001-09-18'),
('Divya Sree', 295000, 3, 'Nizamabad', '2000-07-07'),
('Vamshi Krishna', 310000, 2, 'Vijayawada', '1999-10-14'),
('Harika Yadav', 260000, 1, 'Nellore', '2002-03-29'),
('Sai Teja', 380000, 3, 'Rajahmundry', '2001-01-05'),
('Pooja Sharma', 330000, 2, 'Delhi', '2000-08-20');

select * from Employee;
select emp_id from Employee;
select sum(emp_name) from Employee;
create table department(dept_id int primary key identity(1,1),dept_name varchar(30),dept_head varchar(30));
insert into department(dept_name,dept_head) values
			('delivery','Sumith Vyasa'),
			('network','xyz'),
			('hr','chaithanya');
use [311];
select * from department;
SELECT * FROM sys.tables;  
Select * from sysdiagrams;
SELECT * FROM sys.objects; 

SELECT * FROM sys.columns WHERE object_id = OBJECT_ID('dbo.employee');

select emp_id,emp_name,dept_name from employee join department on employee.dept_id=department.dept_id;



drop table if exists temp;
create table temp(
    id int identity(1,1),
    name varchar(30),
    age int check(age>=18),
    status char(4) default 'pend',
    primary key(id,name)
);

insert into temp(name, age, status)
values ('xyz', 22, 'pend'),
('abc',21,'comp'),
('dss',18,''),
('aswq',29,'comp');

update temp set status='pend' where status='';
select * from temp;

--copy structure+data
select * into temp1 from temp;
select * from temp1;

--copy only structure
select * into temp3 from temp where 1=0;
select * from temp3;

create table ident(id int identity(1,1) primary key,val int identity(2,2));
--Multiple identity columns specified for table 'ident'. Only one identity column per table is allowed.

create table ident1(id int primary key,name varchar(30) identity(a,2));
--Incorrect syntax near 'a'.


select DB_NAME() as currDB;
use [311];--Database names that are purely numeric (like 311) need to be enclosed in square brackets because SQL Server will otherwise think it’s a number

create table identit(num int identity(1,1) primary key,val int);

--removing identity -we cant directly identity directly -->create a new col without identity,copy data, drop old col,rename new one
alter table identit add xtra int;
update identit set xtra=num;
alter table identit drop constraint PK__identit__DF908D65EDDAEB9B;
alter table identit drop column num;
select * from identit;
insert into identit (val) values(20);


--we cant add IDENTITY to existing column
alter table identit alter column val int identity(1,2);

--adding identity -you can add a new column as identity
alter table identit add num int identity(1,1);
insert into identit(val,xtra,num) values(30,24,3);
--Cannot insert explicit value for identity column in table 'identit' when IDENTITY_INSERT is set to OFF.
-- we can update using IDENTITY_INSERT


insert into identit(val,xtra) values(25,35);

--changing the seed/increment 
dbcc checkident('identit',reseed,20);
insert into identit(val,xtra) values(30,38);

--inserting our own values into identity-> IDENTITY_INSERT
set identity_insert identit on;
insert into identit(val,xtra,num) values(10,20,999);
set identity_insert identit off;

--getting the last identity value
insert into identit(val,xtra) values(20,30);
select SCOPE_IDENTITY();
select * from identit;

set identity_insert identit on;
insert into identit(val,xtra,num) values(10,20,90);
set identity_insert identit off;

insert into identit(val,xtra) values(10,20);

dbcc checkident('identit',reseed,30);
insert into identit(val,xtra) values(43,35);

set identity_insert identit on;
insert into identit(val,xtra,num) values(10,20,99);
set identity_insert identit off;

insert into identit(val,xtra) values(12,13);

SELECT DB_NAME() AS CurrentDatabase;
use [311];
--drop table comput;
create table comput(id int primary key,price int,qnty int,total as (price*qnty),perc as (price*qnty*100) persisted);
insert into comput (id,price,qnty) values (1,20,10);

--non deterministic functions can be computed if they are not persisted 
alter table comput add datefunc as(getdate());

--non deterministic functions can't be persisted
alter table comput add datefunc1 as(getdate()) persisted;

update comput set price=100 where price=20;

--drop table alias;
create table alias(id int,fstname varchar(20),lastname varchar(20),sal int);
create view empFullname as 
select fstname+' '+lastname as fullname from alias;

exec sp_help 'empFullname';

create schema dept;
create table dept.delivery(empId int primary key identity(1,1),name varchar(30));
insert into dept.delivery(name) values('xyz'),('abc'),('cbdh'),('dejd');
select * from dept.delivery;

--create user User5 for login User5;

select * from sys.schemas;
SELECT * FROM INFORMATION_SCHEMA.SCHEMATA;

--scalar functions
select upper('hello ');
select upper(null);
select upper('&');
SELECT UPPER('ß'); -- German sharp S becomes "SS" in some collations
select upper(123);

select lower('Hello');

select len('gsidgsdiuf');
select len('gdsh cdu');
select len('hello     ');--doesnot count trainling zeros

select datalength('hwllo ');--5 one byte per char
select datalength(N'helo ');--8 2 bytes per char also includes 
select len('bsd   '),datalength('dvdg ');--one byte per char also counting tainling zeros
select datalength(122 ),datalength(133);--4 bytes
select len(122),len(123   );--3
select len(12.333),datalength(12.334    );
select len(getdate());
select datalength(getdate());
select len(null),datalength(null);

select datalength(123);
select datalength(123.22);--5
select datalength(getdate());--8

select coalesce(null,null,getdate());
select coalesce(null,null,'dbebh',getdate(),'dh');
select coalesce(null,null,getdate(),123.33);--returns the datatype of leftmost datatype
select coalesce(null,null,123,124.43,'gshgd');
select COALESCE(NULL, 10, 9.75) AS Result;
select COALESCE(NULL, 123, 'Hello') AS Result;
select COALESCE(NULL, '2024-01-01', GETDATE()) AS Result;--date precedence > varchar so varchar will get converted to date
select COALESCE(NULL, 5000, CAST(1500 AS MONEY)) AS Result;--money>int 

--character/string functions
select ascii('a');
select ascii('dbfj');
select ascii(null);
select unicode(N'abc');
select ascii(N'abc');
select ASCII('é') AS Asciie, UNICODE(N'é') AS Unicodee;
select ASCII(N'అ') AS AsciiTelugu, UNICODE(N'అ') AS UnicodeTelugu;--Since emoji is outside the ASCII/code page range, SQL Server cannot map it so it replaces with ? --63
select ascii(SUBSTRING('Hello',2,4));
SELECT ASCII(CHAR(10));
select ascii(getdate());--It converts the datetime to a string,Aug 18 2025 8:30PM ,fst char A so 65
select ascii('A') , CHAR(65) AS Char65;
SELECT @@LANGUAGE AS CurrentLanguage; --us_english -mdy format 
EXEC sp_helplanguage;--lists all installed languages and their date formats.

SELECT LTRIM('     Hello World   ') AS Res;
SELECT RTRIM('     Hello World   ') AS Res;
SELECT TRIM('     Hello World   ') AS Res;
SELECT len(LTRIM('     Hello World   ')) AS Res;
SELECT len(RTRIM('     Hello World   ')) AS Res;
SELECT len(TRIM('     Hello World   ')) AS Res;
select trim('!' from '!hello World!!!');
select '[' + LTRIM('    hello   ') + ']' AS LTRIM_Result,
    '[' + RTRIM('    hello   ') + ']' AS RTRIM_Result,
    '[' + TRIM('    hello   ') + ']' AS TRIM_Result;


select charindex('lo','hello world',4);
select charindex('ll','hello world',1);
select charindex('0;','hello world',4);
select charindex('li','hello world',4);--0
select charindex(N'lo',N'hello world',1);

select patindex('%abc%','xyzabcdef') as pos;  
select patindex('abc%','abcdef') as pos;  
select patindex('%def','abcdef') as pos;  
select patindex('%zzz%','abcdef') as pos;  
select patindex('%abc%','ABCDEF') as pos;-- if default collation is case-insensitive → returns 1,if case-sensitive collation → returns 0
select patindex('%a_c%','abc ac adc aec') as pos;
select patindex('%[0-9]%','abc123') as pos;  
select patindex('%[A-Z]%','helloSQL') as pos; --1 since by default it is case-insensitive
select patindex('%[^a-zA-Z0-9]%','hello@world123') as pos;

use [311];
create table sample(txt varchar(50));
insert into sample values('hello world'), ('sql server'), ('pattern search');
select txt, patindex('%or%', txt) as position
from sample;


select concat('hello',' ', 'world');
select concat('emp id: ',101,',sal: ', 5000);
select concat('today''s date',getdate());--single quotes must b escape by doubling them
select 'abc ' + null + 'xyz';
select concat('abc',null,'xyz');

select concat_ws('-','2025','08','18') as x;
select concat_ws('-','abc', null, 'shirisha', 'sqlserver') as skipnulls;
select concat_ws('-','today is',getdate()) as datetoday;
select concat_ws(' ','today is',convert(varchar, getdate())) as datetoday;
select concat_ws(' | ','id:', 101, 'amount:', 500.75, 'date:', convert(varchar, getdate(), 106)) as mixeddatatypes;

select left('svdchsgdvc',3);--fst 3 chars
select right('chhfjbjdfv',2);--last 2 chars
select left('',2);
select left('vchj',6);--returning entire string 
select right('cvdhcv',-3);--err
select right(null,1);--null

select replace('sql server','sql','database');  
select replace('hello world from sql',' ','-');  
select replace('123-456-7890','-',''); 
select replace('abc abc abc','abc','xyz'); 
select replace('Sql sql SQL','sql','server'); --default collation is caseinsensetive
select replace(null,'a','b');  
select replace(replace('2025/08/18','/','-'),'2025','year2025');  
select replace('aaaaaa','aa','b');

select replicate('sql',3);
select 'id:'+replicate('*',10)
select '['+replicate(' ',5)+'hello]';
select replicate('X',len('9346175868')-4)+right('9346175868',4);

select format(getdate(),'dd-MM-yyyy') as day_month_year,
       format(getdate(),'MMMM dd, yyyy') as month_name,
       format(getdate(),'hh:mm tt') as time_12hr,
       format(getdate(),'HH:mm:ss') as time_24hr;

select format(1234567,'N0') as number_with_commas,
       format(1234567.89,'N2') as number_with_two_decimals,
       format(1234567.89,'C') as currency_default,
       format(1234567.89,'C','en-IN') as currency_india,
       format(0.756,'P2') as percentage;

select format(getdate(),'ddd,MM,yy');--if u use mm it will give mins

select 
    format(1234567.89,'N0') as NoDecimals,
    format(1234567.89,'N2') as TwoDecimals,
    format(1234567.89,'C') as CurrencyDefault,
    format(0.756,'P2') as Percentage;

select reverse('sql server');
select reverse('reverse');
select reverse(12234);
select reverse(123.34);
select emp_name,reverse(emp_name) from Employee;
select reverse(N'😀❤️👍') as reversed;

select stuff('abcdef',4,2,'***');
select stuff('abcdef',6,0,'*');
select stuff('abcdef',9,0,'*');
select stuff('abcdef',0,0,'*');
select stuff('abcdef',-2,0,'*');
select stuff(null,6,0,'*');
select stuff('abcdef',1,len('abccdef'),'*');
select stuff('hello ',len('hello')+1,0,' world');
--select stuff('hello', len('hello')+1, 0, ' world');
--select stuff('hello', len('hello')+1, 0, ' world');

--Assignment
--1.numeric from alphanumeric
use [311];
create table dbo.alpha(id int primary key identity(1,1),alphaNum varchar(30));
go

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
use [311];
select emp_id , emp_name ,dbo.getAge(dob) as age from Employee ;

select * from Employee;


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
(1, 'alice', null),       -- top manager / CEO
(2, 'bob', 1),            -- reports to alice
(3, 'charlie', 2),        -- reports to bob
(4, 'david', 2),          -- reports to bob
(5, 'eve', 3),            -- reports to charlie
(6, 'frank', 3),          -- reports to charlie
(7, 'grace', 4),          -- reports to david
(8, 'heidi', 5);          -- reports to eve
select * from emp;
insert into emp(empid,empname,managerid) values(17,'Vilva Priya Koma',6),(18,'Saketh Macha',6);
use [311];
;with hierarchy as(
    
    select empid,empname,managerid ,empname as managername,1 as hierarchylevel from emp where managerid is null 

union all

select e.empid,e.empname,e.managerid,eh.empname as managername,eh.hierarchylevel+1 as hierarchylevel from emp e join hierarchy eh on e.managerid=eh.empid
)
select * from hierarchy;



--Assigment -2
--1)Write a query to find the all the names which are similar in pronouncing as suresh, sort the result in the order of similarity
insert into emp(empid, empname, managerid) values
(9, 'Suresh bobbili', 1),       
(10, 'munavath Suresh', 1),
(11, 'Suresh xyz', 2),        
(12, 'f Suresh sab', 3),          
(13, 'suresh bdh', 3),            
(14, 'a suresh b', 5),          
(15, 'grace suresh', 6);
select * from emp;
select empid,empname from emp where lower(empname) like '%suresh%' order by empname;

select empid,empname,soundex(empname) as pronoun,difference(empname,'suresh') as similarity from emp where difference(empname,'suresh')>=3;

--2)write a query to find second highest salary in organisation without using subqueries and top
with cte as(
select emp_id,emp_name,emp_salary, dense_rank() over(order by emp_salary desc) as rnk from Employee
)
select emp_id,emp_name,emp_salary from cte where rnk=2; 




--3)write a query to find max salary and dep name from all the dept with out using top and limit

select d.dept_name,e.emp_name, max(e.emp_salary) over(partition by d.dept_id) as max_salary from Employee e join department d on e.dept_id=d.dept_id; --this query retrives all the people with higest salary in each dept

select d.dept_name,e.emp_name, e.emp_salary from Employee e join department d on e.dept_id=d.dept_id where e.emp_salary=(select max(emp_salary) from Employee where dept_id=e.dept_id);


--4)Write a SQL query to maximum number from a table without using MAX or MIN aggregate functions.Consider the numbers as mentioned below:
--7859
--6897
--9875
--8659
--7600
--7550

create table numbers(num int);
insert into numbers(num) values (10),(20),(30),(2),(3),(45),(1000),(2423),(0);

select 'mx' as t,num  from numbers where num=(select top 1 num from numbers order by num desc) 
union all
select 'mn' as t,num  from numbers where num=(select top 1 num from numbers order by num asc) ;



--5) Write an SQL query to fetch all the Employees who are also managers from the Employee Details table.
select * from emp;

select distinct e2.empid,e2.empname from emp e1 join emp e2 on e1.managerid=e2.empid ;



create table t (id int primary key identity(1,1),num int);
insert into t(num) values(3),(3),(3),(4),(2),(2),(3),(4);
select * from t;

with cte as(
select id,num,lag(num,1) over(order by id) as lg,lead(num,1) over(order by id) as ld from t
)
select id,num from cte where num=lg and num=ld;



--group by & having 
use [311];
select * from Employee;
select * from department;

select emp_name,emp_salary from Employee where emp_salary >avg(emp_salary) ;--An aggregate may not appear in the WHERE clause
select emp_name,emp_salary,avg(emp_salary) from Employee having emp_salary >avg(emp_salary) ;--HAVING clause because it is not contained in either an aggregate function or the GROUP BY clause.
select emp_name,emp_salary from Employee where emp_salary >(select avg(emp_salary) from Employee) ;

CREATE TABLE Sales (
    sale_id INT PRIMARY KEY,
    region VARCHAR(50),
    product VARCHAR(50),
    year INT,
    amount DECIMAL(10,2)
);

INSERT INTO Sales (sale_id, region, product, year, amount) VALUES
(1, 'North', 'Laptop', 2023, 1000),
(2, 'North', 'Mobile', 2023, 1500),
(3, 'South', 'Laptop', 2023, 1200),
(4, 'South', 'Mobile', 2023, 1300),
(5, 'East',  'Laptop', 2023, 900),
(6, 'East',  'Mobile', 2023, 700),
(7, 'North', 'Laptop', 2024, 1100),
(8, 'North', 'Mobile', 2024, 1700),
(9, 'South', 'Laptop', 2024, 1250),
(10,'South', 'Mobile', 2024, 1600),
(11,'East',  'Laptop', 2024, 1000),
(12,'East',  'Mobile', 2024, 800);
--group by roll up
SELECT region, product, SUM(amount) AS total_sales
FROM Sales
GROUP BY ROLLUP(region, product);

--group by cube
SELECT region, product, SUM(amount) AS total_sales
FROM Sales
GROUP BY CUBE(region, product);

--grouping sets
SELECT region, product, SUM(amount) AS total_sales
FROM Sales
GROUP BY GROUPING SETS (
    (region, product),
    (region),
    (product),
    ()
);

--having without group by 
select sum(emp_salary) from Employee having sum(emp_salary)>500000;

--having without group by and aggregates -> error
select dept_name from department having dept_name='hr';
select emp_name from Employee having emp_name like '%suresh%';


--ranking functions 

select top 50 percent emp_id,emp_name,dept_id,emp_salary,row_number() over(partition by dept_id order by emp_salary desc) as row_num,
    rank() over(partition by dept_id order by emp_salary desc) as rnk,
    dense_rank() over(partition by dept_id order by emp_salary desc) as d_rnk,ntile(3) over(partition by dept_id order by emp_salary desc) as nt from Employee;

select top 7 * from Employee order by emp_salary desc;
--use WITH TIES to retrieve top n if 2 ppl having same salaries 
select top 7 with ties * from Employee order by emp_salary desc;


--type conversion in union --error
select emp_salary from Employee
union
select emp_id from Employee;
--explicit conversion
select cast(emp_id as varchar),emp_name from Employee
union
select emp_name,cast(dob as varchar)from Employee;

--intersect
select emp_name from Employee --cannot use order by for the first stmnt 
intersect
select empname from emp order by emp_name;

SELECT NULL AS Col1
INTERSECT
SELECT NULL AS Col1;


select emp_name, emp_salary,dept_id,avg(emp_salary) over(partition by dept_id ) as avg from Employee;
select emp_name, emp_salary,dept_id,avg(emp_salary) over(partition by dept_id order by emp_salary ) as avg from Employee;--calculating cumulative avg
--to caluclate avg for each dept instead of running avg mention->rows between unbounded preceding and unbounded following
select emp_name, emp_salary,dept_id,avg(emp_salary) over(partition by dept_id order by emp_salary rows between unbounded preceding and unbounded following) as avg from Employee;

select emp_name, emp_salary,dept_id,cume_dist() over(partition by dept_id order by emp_salary) as cum,PERCENT_RANK() over(partition by dept_id order by emp_salary) as perc from Employee;

--fetch without offset
SELECT emp_id, emp_name
FROM Employee
ORDER BY emp_id
FETCH NEXT 5 ROWS ONLY;   -- Error: OFFSET is required
go

--cross apply
DROP FUNCTION IF EXISTS dept_top;
go
create function dept_top(@dept_id int)
returns table
as return(
        select top 1 emp_id,emp_name,emp_salary from Employee where dept_id=@dept_id  order by emp_salary desc
        );
go
select d.dept_id,d.dept_name,e.emp_name from department d cross apply dept_top(d.dept_id) e;

--inner join 
select d.dept_id,d.dept_name,e.emp_name from department d inner join dept_top(d.dept_id) e;

--cte
--you can use CTE for INSERT / UPDATE / DELETE: When CTE directly references a base table
WITH EmpCTE AS (
    SELECT emp_id, emp_name, emp_salary
    FROM Employee
    WHERE dept_id = 1
)
--select * from EmpCTE;
UPDATE EmpCTE
SET emp_salary = emp_salary * 5.1;   -- 10% hike

select * from Employee;


--we cannot use insert/update/delete inside cte
with temp as(
update Employee set emp_salary=emp_salary*2;
)

--u can only use a cte 
with temp as(
select emp_id,emp_name,dept_id,emp_salary,dense_rank() over(partition by dept_id order by emp_salary) as rnk from Employee
)
--select * from temp;
select  top 10 dept_id,emp_name,emp_salary,rnk from temp;

--You can define multiple CTEs in a single WITH clause, and each subsequent CTE can reference the ones defined before it.This is called chained CTEs.
WITH
CTE1 AS (
    SELECT emp_id, emp_name, dept_id, emp_salary
    FROM Employee
),
CTE2 AS (
    SELECT dept_id, AVG(emp_salary) AS avg_salary
    FROM CTE1
    GROUP BY dept_id
),
CTE3 AS (
    SELECT CTE1.emp_name, CTE1.emp_salary, CTE2.avg_salary
    FROM CTE1
    JOIN CTE2 ON CTE1.dept_id = CTE2.dept_id
)
SELECT * FROM CTE3;


--subqueries practice 
CREATE TABLE students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(50),
    age INT,
    city VARCHAR(50)
);

INSERT INTO students VALUES
(1, 'Krishna', 20, 'Hyderabad'),
(2, 'Shirisha', 22, 'Chennai'),
(3, 'Ravi', 21, 'Hyderabad'),
(4, 'Anjali', 23, 'Bangalore'),
(5, 'Manoj', 22, 'Chennai');
INSERT INTO students VALUES
(6, 'degd', 22, 'Chennai');

CREATE TABLE courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(50),
    student_id INT
);

INSERT INTO courses VALUES
(101, 'Mathematics', 1),
(102, 'Science', 2),
(103, 'English', 1),
(104, 'History', 3),
(105, 'Mathematics', 5);

CREATE TABLE results (
    result_id INT PRIMARY KEY,
    student_id INT,
    marks INT
);

INSERT INTO results VALUES
(1, 1, 88),
(2, 2, 92),
(3, 3, 76),
(4, 4, 81),
(5, 5, 92);
INSERT INTO results VALUES (6, NULL, 85);

--single row
SELECT student_name
FROM students
WHERE student_id = (
    SELECT student_id
    FROM results
    WHERE marks = (SELECT MAX(marks) FROM results)
);
SELECT student_name
FROM students
WHERE student_id = (
    SELECT top 1 student_id
    FROM results
    order by marks desc
);
--multi row->IN
SELECT student_name
FROM students
WHERE student_id IN (
    SELECT student_id
    FROM results
    WHERE marks = (SELECT MAX(marks) FROM results)
);
--multi row->ANY
SELECT student_name
FROM students
WHERE age > ANY (
    SELECT age FROM students WHERE city = 'Chennai'
);
--multi row ->ALL
SELECT student_name
FROM students
WHERE age > ALL (
    SELECT age FROM students WHERE city = 'Chennai'
);

--correlated subwuery
--Students who scored above average marks
SELECT student_name
FROM students s
WHERE EXISTS (
    SELECT 1
    FROM results r
    WHERE r.student_id = s.student_id
      AND r.marks > (SELECT AVG(marks) FROM results)
);
--Students who enrolled in multiple courses
SELECT student_name
FROM students s
WHERE (
    SELECT COUNT(*)
    FROM courses c
    WHERE c.student_id = s.student_id
) > 1;

--How NOT IN fails with NULL
-- Find students who are NOT in the results table
SELECT student_id, student_name
FROM students
WHERE student_id NOT IN (SELECT student_id FROM results);

select * from students;
select * from results;

SELECT student_id, student_name
FROM students s
WHERE NOT EXISTS (
  SELECT 1 FROM results r
  WHERE r.student_id = s.student_id
);

--You cannot use ORDER BY inside a subquery unless you also use TOP, OFFSET/FETCH, or it’s in a CTE / derived table.
SELECT student_id
FROM (SELECT student_id FROM results ORDER BY marks ) t;
