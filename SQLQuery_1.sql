
/*Database commands*/
Create DATABASE vitals_mgmt_db
Create DATABASE [AP]
ALTER database ap modify name=ap_new
drop database ap_new
Create database Company

/*Table commands*/
Use Company  /*if not used table created under master db */
go
create table employees (empid int primary key not null, name varchar(50), phone int not null, depid int not null) 

Exec sp_rename 'employees', 'employee'  /* stored proc*/
Drop table employee
/* 
Data types available 
-----------------------------------------------------------------
INT
Bit
DECIMAL
Datetime
CHAR
VARCHAR
BINARY


Constraints
Not NULL
Default  - provides default value to column
primary key
*/

Create table tableEmployees (
    EmployeeId int primary key not null,
    EmployeeName varchar(50) not null,
    Phone int Not NULL,
    DepID int Not Null,
    Salary DECIMAL(10,2) DEFAULT 3000.00
)
/* 
Foreign key - primary key of one table that links data in another table
*/
Create table tableDepartment (
    DepID int primary key not null,
    DepartmentName varchar(50) Not NULL
)
Create table tableEmployees1 (
    EmployeeID int primary key not null,
    employeename varchar(50) not null,
    phone int not null,
    depid int foreign key references tableDepartment(DepID) Not null
)

Alter table tableEmployees1 add CONSTRAINT u_phone unique(phone) 

Create table tableEmployees2(
    Empid int primary key not null,
    empname varchar(50) not null,
    phone int not null,
    Age int not null check(Age>=18),
    DepId int not NULL
)
Alter table tableEmployees2 Add Constraint CHK_EmployeeAge CHECK (Age>=18) /* Can add 2 constraints to same table*/

Alter table tableEmployees2 Drop Constraint CHK_EmployeeAge 

insert into tableEmployees2 (Empid,empname,phone, Age, DepId) values(3,'Mark', 433322334, 32, 3)
insert into tableEmployees2 (Empid,empname, Age, DepId) values(4,'Mark', 32, 3)
insert into tableEmployees2 values (5,'Steve',988663,23,4)

update tableEmployees2 set empname = 'Frank' where Empid = 2

update tableEmployees2 set empname = 'Frank2',Age = 43 where Empid = 3

delete tableEmployees2 where empid = 4

delete tableEmployees2 /* deletes all rows in table */

SELECT * from tableEmployees2

select empname,phone from tableEmployees2

select empname as employee, phone as Telephone from tableEmployees2 as employee /* can use table alias in part of column name*/

/* 
Logical operators
AND
OR
BETWEENIN
EXISTS
*/

Select * from tableEmployees2 where Age> 18 and Age <80 

Select * from tableEmployees2 where Age in (20,19,23) 

Select * from tableEmployees2 where Age in (20,19,23) 

select distinct empname, phone from tableEmployees2

select top 2 empname, phone from tableEmployees2

select empname from tableEmployees2 order by empname asc
select empname from tableEmployees2 order by empname desc

select distinct empname, phone from tableEmployees2

/* Using AdventureWorks2019
Download bak file from net.

docker cp 'AdventureWorks2019.bak' <Container name>:/var/opt/mssql
docker exec -it-u root  MySQLServer 'bash'
Restore db from manage tab of server in studio
*/

Use AdventureWorks2019
Go
Select * from Production.ProductInventory 
Select sum(Quantity) from Production.ProductInventory /* gives sum of all qty*/
Select Shelf,sum(Quantity) from Production.ProductInventory group by Shelf order by Shelf 
/* arange identical data into groups, 
group by follows where clause and precedes order by clause
NOTE- Orderby is always last
*/

--having clause 
select Shelf, Sum(Quantity) As Quantity, sum(Bin) as Bin from Production.ProductInventory Group By Shelf HAVING Shelf ='A' Order By Shelf


--where and having clause difference









sp_helpfile


CREATE TABLE patient (
    id int,
    name varchar(255),
    dob date,
    Address varchar(255),
    city varchar(255),
    country varchar(255)
);

Select * from patient where id=1

Select name,dob from patient where id=1 

INSERT INTO patient (id, name, address, dob, city, country)
VALUES (8, 'Tilak', 'No.42 Jayanta nagar Ram nagar', '08-12-1976','Delhi', 'India');

Update patient set city= 'Lahore' where country = 'Pakistan' 

Select name,dob from patient where country='India' order by dob asc
Select name,dob from patient where country='India' order by dob desc

/* set column names on dispay*/
Select id as PatientID, dob as dateofbirth from patient
Select PatientID=id, dateofbirth=dob from patient /*old method*/

