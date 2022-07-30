
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
-- id asc not added also it orders in asc by default

select distinct empname, phone from tableEmployees2

/* Using AdventureWorks2019
Download bak file from net.

docker cp 'AdventureWorks2019.bak' <Container name>:/var/opt/mssql
docker exec -it-u root  MySQLServer 'bash'
Restore db from manage tab of server in studio
*/

Use AdventureWorks2019
Go

select FirstName from Person.Person
select Distinct FirstName from Person.Person
select Distinct PersonType,FirstName from Person.Person


Select * from Production.ProductInventory 
Select sum(Quantity) from Production.ProductInventory /* gives sum of all qty*/
Select Shelf,sum(Quantity) from Production.ProductInventory group by Shelf order by Shelf 
/* arange identical data into groups, 
group by follows where clause and precedes order by clause
NOTE- Orderby is always last
*/

--having clause 
select Shelf, Sum(Quantity) As Quantity, sum(Bin) as Bin from Production.ProductInventory Group By Shelf HAVING Shelf ='A' Order By Shelf --index used here agregator fn can be used as grouping done
select shelf, Sum(Quantity) As Quantity , sum(Bin) as Bin from Production.ProductInventory where Shelf ='A' Group By Shelf --index not used here aggregator function like sum cant be used with where
/*
where and having clause difference

Where Clause in SQL	                    Having Clause in SQL
Applicable without GROUP BY clause	    Does not function without GROUP BY clause
Row functions	                        Column functions
Select, update and delete statements	Only select statement
Applied before GROUP BY clause	        Used after GROUP BY clause
*/

--wildcard operations

select Firstname from Person.Person where FirstName Like 'a%'
select Firstname from Person.Person where FirstName Like '%a'
select Firstname from Person.Person where FirstName Like '%inda%' -- % is multi character

select distinct Firstname from Person.Person where FirstName Like '_n_a'  -- _ is 1 character
select distinct Firstname from Person.Person where FirstName Like '[abc]%'  -- _ names starting with a,b or c
select  Firstname from Person.Person where FirstName Like '[a-c]%'  -- _ names starting with a,b or c

--Case clause

select DepID, DeptName,
    Case DeptName
        When 'IT' then 'InfoTechnology'
        when 'HR' then 'HumanResource'
        else 'Finance'
    end as 'DeptLongName'
from table tableEmployee2


--conversion function 

select CONVERT(int,5.45)
select CAST(5.45 as int)
select cast(5.45 as varchar)
select convert(datetime, '2020-01-07') as TextDate

select FirstName, LastName, ModifiedDate, Cast(ModifiedDate as varchar(13)) DateToText from Person.Person

select FirstName, LastName, ModifiedDate, CONVERT(varchar(13),ModifiedDate) DateToText from Person.Person

--Join 
Select * from Person.Person
select * from Person.EmailAddress
--inner join records with match on both table
Select FirstName, LastName, EmailAddress from Person.Person Join Person.EmailAddress On Person.BusinessEntityID=EmailAddress.BusinessEntityID --kim has 3 rows with 3 email ids

--left join  all records from left table and no match fields will be null

Select * from Production.Product
Select * from Sales.SalesOrderDetail

Select Name, SalesOrderDetailID from Production.Product as P Join Sales.SalesOrderDetail as S On P.ProductID = S.ProductID 
--only vals where both columns have values 
Select Name, SalesOrderDetailID from Production.Product as P Left Join Sales.SalesOrderDetail as S On P.ProductID = S.ProductID 
--here all products listed even those with null sales id
Select Name, SalesOrderDetailID from Production.Product as P Right Join Sales.SalesOrderDetail as S On P.ProductID = S.ProductID 

Select Name, SalesOrderDetailID from Production.Product as P  Full Join Sales.SalesOrderDetail as S On P.ProductID = S.ProductID
 --Self join for comapring rows of same table
 --get procducts with same price 
select P1.Name, P2.Name 
    from Production.Product P1 
    Join Production.Product P2 
    On P1.ListPrice =P2.ListPrice 
    and P1.ListPrice<>0
    and P1.Name<>P2.Name


/*set operators used to combine union, union all, intersect and except combine same type of data from 2 or more tables
same no.columns
column type shoulds be same
*/

--removes duplicates - 105 rows
select CurrencyCode from Sales.CountryRegionCurrency --109 rows
union
Select CurrencyCode from Sales.Currency --105 rows   


--allows duplicates 109+105 rows
select CurrencyCode from Sales.CountryRegionCurrency --109 rows
union all
Select CurrencyCode from Sales.Currency --105 rows   


--intersect 2 select statements that return results from 1st select that have values in 2nd
Use AdventureWorks2019
GO
select * from HumanResources.Employee

--Subqueries with return of subquery should be 1 field value only
select * from Sales.SalesOrderDetail 
where ProductID=(select ProductID from Production.Product where Name= 'Cable Lock')

--multiple row subquery
SELECT * from Production.Product as P
where ProductID not in (select ProductID from Sales.SalesOrderDetail)

SELECT * from Production.Product as P
    where Not Exists 
    (Select ProductID from Sales.SalesOrderDetail as S 
    where P.ProductID = S.ProductID)  --dependent on main query so can be executed independenty

--insert data with subqueries
insert into Person.StateProvince 
    SELECT StateProvinceCode, 
    Country

--where ProductID in (select ProductID from Sales.SalesOrderDetail)
--different formats of date
select convert(varchar,getdate(),1)
select convert(varchar,getdate(),2)
select convert(varchar,getdate(),4)
select convert(varchar,getdate(),5)
select convert(varchar,getdate(),6)
select convert(varchar,getdate(),7)
select convert(varchar,getdate(),10)

--string functions
select len ('ok hello')
select left ('OAK Academy fine',12)
select trim('    cccddcd     ')
select ltrim('    cccddcd     ')
select rtrim('    cccddcd     ')
select lower('ABCE')
select upper('abcd')
select reverse('abcd')
select replace('this is the string to replace oldstrng newstring','oldstrng','newstring')
select substring('OAK Academy 2020',5,12)


--math functions
select abs(-202)
select avg(ListPrice) from Production.Product
select CEILING(15.78) --16
select count(*) from Production.Product
select floor(15.7) --15
select max(ListPrice) from Production.Product
select min(ListPrice) from Production.Product
select power(2,3) --8
select rand() --returns b/w 0 and1
select rand(5)
select round(12.43322,3) --12.43300
select sqrt(4)
select square(3)
select SUM(ListPrice) from Production.Product

/*TRANSACTION commands 
   ACID atomicity-all actions completed or all fail,
        consistency-only valid data saved, 
        isolation -transactions dont affect each other, 
        durability -written data not lost
    Rollback to undo 
*/

begin tran
update Person.Person
    set FirstName = 'Terri' where BusinessEntityID = 1
Rollback
COMMIT
select * from Person.Person

Begin tran --begin tran

update Person.Person  
    set FirstName = 'Tom' where BusinessEntityID = 2  
Save tran savefirstname
update Person.Person  
    set MiddleName = 'Z' where BusinessEntityID = 2  
Save tran savemiddlename
update Person.Person  
    set LastName = 'Walker' where BusinessEntityID = 2  
Save tran saveLastname
ROLLBACK tran Savemiddlename 
COMMIT

Use AdventureWorks2019
Go
create schema TestSchema AUTHORIZATION dbo

--dbo schema is default schema
create table TestSchema.Departments(
    Id int not null,
    DepartmentName varchar not NULL
)
 
 Create Schema NewSchema
 Alter Schema NewSchema
    Transfer TestSchema.Departments
 --cant delte schema if table exists in it
 Drop Schema TestSchema

--view 
Create View VPersonWithMailAddress As  
Select FirstName, LastName, EmailAddress
from Person.Person As P 
Join Person.EmailAddress As E 
On P.BusinessEntityID = E.BusinessEntityID


Select * from VPersonWithMailAddress


create sequence SeqObj as int
Start with 1
Increment By 2
minvalue 1
maxvalue 1000
cycle --restarts seq after max value
Select Next Value for SeqObj

Select current_value from sys.sequences
where name ='SeqObj'

Alter sequence SeqObj Restart with 1
select * from Person.Person

Insert into HumanResources.Department
Values(
    Next Value for SeqObj, 'P'
)

Insert into HumanResources.Department
Values(
    Next Value for SeqObj, 'Q'
)


Insert into HumanResources.Department
Values(
    Next Value for SeqObj, 'R'
)

drop sequence SeqObj


Create database AP
Create database ProductOrders
Create database Examples

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



--Chapter 3
Use AP
Go

SELECT VendorContactFName, VendorContactLName, VendorName
FROM Vendors
ORDER BY VendorContactLName, VendorContactFName;

USE AP;

SELECT InvoiceNumber AS Number,
       InvoiceTotal AS Total,
       PaymentTotal + CreditTotal AS Credits,
       InvoiceTotal - (PaymentTotal + CreditTotal) AS Balance
FROM Invoices;

USE AP;

SELECT Number = InvoiceNumber,
       Total = InvoiceTotal,
       Credits = PaymentTotal + CreditTotal,
       Balance = InvoiceTotal - (PaymentTotal + CreditTotal)
FROM Invoices;

USE AP;

SELECT VendorContactLName + ', ' + VendorContactFName AS [Full Name]
FROM Vendors
ORDER BY VendorContactLName, VendorContactFName;

USE AP;

SELECT InvoiceTotal, InvoiceTotal / 10 AS [10%],
       InvoiceTotal * 1.1 AS [Plus 10%]
FROM Invoices
WHERE InvoiceTotal - PaymentTotal - CreditTotal > 1000
ORDER BY InvoiceTotal DESC;

USE AP;

SELECT InvoiceNumber AS Number,
       InvoiceTotal AS Total,
       PaymentTotal + CreditTotal AS Credits,
       InvoiceTotal - (PaymentTotal + CreditTotal) AS Balance
FROM Invoices
WHERE InvoiceTotal BETWEEN 500 AND 10000;
--Also acceptable:
--WHERE InvoiceTotal >= 500 AND InvoiceTotal <= 10000;

USE AP;

SELECT VendorContactLName + ', ' + VendorContactFName AS [Full Name]
FROM Vendors
WHERE VendorContactLName LIKE '[A-C,E]%'
--Also acceptable:
--WHERE VendorContactLName LIKE '[A-E]%' AND
--      VendorContactLName NOT LIKE 'D%'
ORDER BY VendorContactLName, VendorContactFName;


Select VendorContactLName+','+VendorContactFName As Fullname from Vendors order by VendorContactLName

Select InvoiceTotal, (0.01*InvoiceTotal) As '10%', (InvoiceTotal+(0.01*InvoiceTotal)) as 'Plus10%' from Invoices

USE AP;

SELECT *
FROM Invoices
WHERE ((InvoiceTotal - PaymentTotal - CreditTotal <= 0) AND
      PaymentDate IS NULL) OR
      ((InvoiceTotal - PaymentTotal - CreditTotal > 0) AND
      PaymentDate IS NOT NULL);
