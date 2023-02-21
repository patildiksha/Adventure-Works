USE adventure_works;

Create table Dept(
deptno int,
dname varchar (50),
loc varchar (50),
PRIMARY KEY (deptno)
);

Insert into Dept values(10,'OPERATIONS','BOSTON'),(20,'RESEARCH','DALLAS'),(30,'SALES','CHICAGO'),(40,'ACCOUNTING','NEW YORK');
Select * from Dept;

Create table employee (
empno int not null ,
ename varchar (50) ,
job varchar (50) DEFAULT 'Clerk',
mgr int DEFAULT NULL ,
hiredate date,
sal decimal (6,0) check(sal>0) ,
comm int DEFAULT NULL ,
deptno int DEFAULT NULL,
unique (empno),
FOREIGN KEY (deptno) REFERENCES Dept (deptno));

Insert into employee values(7369,'SMITH','CLERK',7902,'1890-12-17',800.00,NULL,20),
(7499,'ALLEN','SALESMAN',7698,'1981-02-20',1600.00,300,30),
(7521,'WARD','SALESMAN',7698,'1981-02-22',1250.00,500,30),
(7566,'JONES','MANAGER',7839,'1981-04-02',2975.00 ,NULL,20),
(7654,'MARTIN','SALESMAN',7698,'1981-09-28',1250.00 ,1400,30),
(7698,'BLAKE','MANAGER',7839,'1981-05-01',2850.00 ,NULL,30),
(7782,'CLARK','MANAGER',7839,'1981-06-09',2450.00 ,NULL,10),
(7788,'SCOTT','ANALYST',7566,'1987-04-19',3000.00 ,NULL,20),
(7839,'KING','PRESIDENT',NULL,'1981-11-17',5000.00 ,NULL,10),
(7844,'TURNER','SALESMAN',7698,'1981-09-08',1500.00 ,0,30),
(7876,'ADAMS','CLERK',7788,'1987-05-23',1100.00 ,NULL,20),
(7900,'JAMES','CLERK',7698,'1981-12-03', 950.00 ,NULL,30),
(7902,'FORD','ANALYST',7566,'1981-12-03',3000.00 ,NULL,20),
(7934,'MILLER','CLERK',7782,'1982-01-23',1300.00 ,NULL,10);

Select * from employee;

/*3.	List the Names and salary of the employee whose salary is greater than 1000 */

Select ename,sal from employee
Where sal>1000
Order By sal;

/*4.	List the details of the employees who have joined before end of September 81*/

Select * from employee
Where hiredate<"1981-09-30"
order by hiredate;

/*5.	List Employee Names having I as second character*/

Select ename AS Employee_Name
From employee
Where ename LIKE '_%I';

/*6.	List Employee Name, Salary, Allowances (40% of Sal), P.F. (10 % of Sal) and Net Salary. Also assign the alias name for the columns*/

Select ename, sal, sal*0.4 AS Allowances, sal*0.1 AS PF, (sal+sal*0.4+sal*0.1) AS Net_Salary
From employee;

/*7. List Employee Names with designations who does not report to anybody*/

Select empno,ename,job,mgr
From employee
Where mgr IS NULL;

/*8.	List Empno, Ename and Salary in the ascending order of salary*/

Select empno,ename,sal
From employee
order  by sal;

/*9.	How many jobs are available in the Organization ?*/

Select COUNT(DISTINCT job) AS Available_Jobs
From employee;

/*10. Determine total payable salary of salesman category*/

Select SUM(sal) AS payable_salary  
From employee
Where job="SALESMAN";

/*11. List average monthly salary for each job within each department   */

Select deptno, job, avg(sal)
From employee
Group By deptno;

/*12. Use the Same EMP and DEPT table used in the Case study to Display EMPNAME, SALARY and DEPTNAME in which the employee is working.*/

Select e.ename,e.sal,d.dname
From Dept d
JOIN employee e
ON d.deptno=e.deptno
Order By ename,dname;

/*13. Create the Job Grades Table as below*/

Create table job_grade (grade varchar(20) , lowest_sal int ,highest_sal int);
Insert into job_grade values ('A',0,999),('B',1000,1999),('C',2000,2999),('D',3000,3999),('E',4000,5000);
Select * from job_grade;

/*14. Display the last name, salary and  Corresponding Grade*/

Select e.ename, e.sal, g.grade
From employee e, job_grade g
Where e.sal between g.lowest_sal and g.highest_sal
order by sal;

/*15. Display the Emp name and the Manager name under whom the Employee works in the below format */

Select a.ename AS "Employee_Reporting", b.ename AS 'Mgr'
From employee a
JOIN employee b
ON a.mgr=b.empno;

/*16. Display Empname and Total sal where Total Sal (sal + Comm)*/

Select ename, (sal+comm) AS Total_sal
From employee
order By sal;

/*17. Display Empname and Sal whose empno is a odd number*/

Select empno, ename, sal
From employee
Where empno%2=1;

/*18. Display Empname , Rank of sal in Organisation , Rank of Sal in their department*/

Select e.ename,sal,dense_rank()over(partition by d.deptno order by e.sal desc) AS  'Rank of sal',d.deptno 
From employee e JOIN Dept d
ON e.deptno=d.deptno 
Order by e.sal desc;

/*19. Display Top 3 Empnames based on their Salary*/

Select ename, sal
From employee
Order by sal desc limit 3;

/*20. Display Empname who has highest Salary in Each Department.*/

Select ename, sal,deptno
From employee 
Where sal IN (Select max(sal) from employee
                      Group By deptno)
Order by deptno;
        
        
   
        























































































































