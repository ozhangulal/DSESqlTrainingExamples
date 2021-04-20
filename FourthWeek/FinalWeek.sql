--Views--

--view is one and more table connected to the each other
--Views are not real table!!!
--They can show only datas and you can write query only to show some data to your end user
--you have to use with your view using with ONLY select query

--please show which supplier bring that to me which product

--select
--s.CompanyName, p.ProductName
--from Products p
--inner join Suppliers s on s.SupplierID=p.SupplierID

--create view vw_SupplierProduct
--as
--select
--p.ProductName, s.CompanyName
--from Products p
--inner join Suppliers s on s.SupplierID=p.SupplierID

--alter view vw_SupplierProduct
--as
--select
--p.ProductName, s.CompanyName,c.CategoryName
--from Products p
--inner join Suppliers s on s.SupplierID=p.SupplierID
--inner join Categories c on c.CategoryID=p.CategoryID

----using view with where condition

--select*from vw_SupplierProduct sp
--where sp.CategoryName like '%b%'


--alter view vw_SupplierProduct
--with encryption
--as
--select
--p.ProductName, s.CompanyName,c.CategoryName
--from Products p
--inner join Suppliers s on s.SupplierID=p.SupplierID
--inner join Categories c on c.CategoryID=p.CategoryID

--alter view vw_SupplierProduct
--as
--select
--p.ProductName, s.CompanyName,c.CategoryName
--from Products p
--inner join Suppliers s on s.SupplierID=p.SupplierID
--inner join Categories c on c.CategoryID=p.CategoryID

----bring customers that I have not sold in view 

--create view vw_NotOrderCustomer
--as
--select c.CompanyName from Orders o
--right join Customers c on o.CustomerID=c.CustomerID
--where o.CustomerID is null

--select*from vw_NotOrderCustomer


--Trigger

--create table Student
--(
--Id int primary key Identity(1,1),
--FirstName nvarchar(50),
--LastName nvarchar(50)
--)

--create table LogTable
--(
--Id int primary key Identity(1,1),
--LogName nvarchar(50),
--LogTable nvarchar(50),
--LogDate date
--)

--create trigger trg_StudentInsert
--on Student
--after insert
--as
--insert into LogTable(LogName, LogTable, LogDate)
--values
--('Insert', 'Student', GETDATE())

--insert into Student(FirstName, LastName) values ('ozhan','gulal')

--select*from Student
--select*from LogTable

--alter trigger trg_StudentUpdate
--on Student
--after update
--as
--insert into LogTable(LogName, LogTable, LogDate, UserName, RowId)
--values
--('Upate', 'Student', SYSDATETIME(), ORIGINAL_LOGIN(), (select Id from deleted))

--update Student set FirstName='Derrick'
--where Id = 1

--select*from Student
--select*from LogTable

--try catch and transaction

--begin try
--begin tran

--update Customer set Amount -= 100 where Id=1 -- 100 tl sending from Ozhan to Gokhan
--insert into LogTable(CustomerId, Date, Description)
--values
--(1, GETDATE(), 'I am sending to you 100 tl')

--declare @number int=3/0

--update Customer set Amount +=100 where Id=2 --100 tl receiving from Ozhan
--insert into LogTable(CustomerId, Date, Description)
--values
--(2, GETDATE(), 'I received your money')

--commit tran
--end try
--begin catch

--rollback tran

--end catch

--select*from Customer
--select*from LogTable

--How can I find redundant datas and delete them

create table Users
(
Id int primary key Identity(1,1),
FirstName nvarchar(50),
LastName nvarchar(50)
)

insert into Users(FirstName, LastName) values('Elvis', 'Presley')
insert into Users(FirstName, LastName) values('Red', 'Kit')
insert into Users(FirstName, LastName) values('Jane', 'Black')
insert into Users(FirstName, LastName) values('James', 'White')
insert into Users(FirstName, LastName) values('Alan', 'Anderson')
insert into Users(FirstName, LastName) values('Elvis', 'Presley')
insert into Users(FirstName, LastName) values('Jane', 'Black')
insert into Users(FirstName, LastName) values('Elvis', 'Presley')
insert into Users(FirstName, LastName) values('Alan', 'Anderson')
insert into Users(FirstName, LastName) values('Elvis', 'Presley')

select*from Users

--We need to find redundant datas

select u.FirstName,COUNT(*) from Users u
group by u.FirstName
having COUNT(*)>1

delete from Users
where Id Not in
(
select MAX(Id) from Users group by FirstName
)

select*from Users