--Assigment -2
--1)Write a query to find the all the names which are similar in pronouncing as suresh, sort the result in the order of similarity
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
