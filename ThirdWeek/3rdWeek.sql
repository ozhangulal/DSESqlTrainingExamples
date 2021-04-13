use Northwind

--select ProductName, UnitPrice from Products p
--order by UnitPrice -- default type of order by  ascending

--select ProductName, UnitPrice from Products p
--order by UnitPrice desc

----use order by and find the cheapest product?

--select top 1 p.ProductName, p.UnitPrice from Products p
--order by UnitPrice asc

----use order by and find the most expensive product

--select top 1 ProductName, UnitPrice from Products p
--order by UnitPrice desc

----use order by and bring here top 5 expensive products

--select top 5 ProductName, UnitPrice from Products p
--order by UnitPrice desc


--Group By and Having

--How many motorBike do we have according to years
--use DSEFirstWeek

--select mc.ModelYear, COUNT(*), mc.Brand from MotorCycles mc
--group by mc.ModelYear, mc.Brand

--select COUNT(*), Brand from MotorCycles
--group by Brand

----average of fuel consumption according to model years
--select mc.ModelYear, AVG(mc.FuelConsumption) from MotorCycles mc
--group by mc.ModelYear

----according to fuel consumption, how many motorcycle do we have same fuel consumption

--select mc.FuelConsumption, COUNT(*) from MotorCycles mc
--group by mc.FuelConsumption

----older than 2000 also only BMW
--select mc.ModelYear, AVG(FuelConsumption) from MotorCycles mc
--where mc.Brand='BMW' and mc.ModelYear>2000
--group by mc.ModelYear

--select mc.ModelYear, AVG(FuelConsumption) from MotorCycles mc
--where mc.Brand='BMW'
--group by mc.ModelYear
--having mc.ModelYear > 2000


--FUNCTIONS
--functions does not working with data completly, you can not do that insert and update
--there is a return value and return values can be table value or scalar value
--functions are database objects, you can create with create command,
--you can delete with drop command, you can update with alter command,
--if you want to use functions you have use with "select" query

--use Northwind
--create function fnc_GetProductById(@ProId int)
--returns table
--as
--return select*from Products where ProductID=@ProId


--create function fnc_GetProductWithCategoryNameByCatId(@CatId int)
--returns table
--as
--return select p.ProductName, c.CategoryName from Products p
--	   inner join Categories c on p.CategoryID = c.CategoryID
--	   where c.CategoryID=@CatId

--	   select*from fnc_GetProductWithCategoryNameByCatId(3)

--	   --scalar value
--	   create function fnc_CalculateTax(@price money)
--	   returns money
--	   as
--	   begin
--	   return(@price*0.08)
--	   end

--	   select
--	   od.OrderID, od.UnitPrice, dbo.fnc_CalculateTax(od.UnitPrice) as TaxPrice,
--	   dbo.fnc_CalculateTax(od.UnitPrice)+od.UnitPrice as GeneralPrice
--	   from [Order Details] od


--Stored Procedures
--stored procedures are dbo (database object)
--create for create command,
--update for alter command,
--drop for delete command,
--you can create one time, you can use it thousands time
--write less do more,
--compiling only one time
--less network traffic thanks to procedure

--Total earnings in one year
create proc prc_accordingToPrcTotalEarnings(@Year int)
as
select
YEAR(OrderDate), SUM(ord.Quantity*ord.UnitPrice)
from Orders o
inner join [Order Details] ord on o.OrderID = ord.OrderID
group by YEAR(OrderDate)
having YEAR(OrderDate)=@Year

exec prc_accordingToPrcTotalEarnings 1998

--Total earnings according to Customer
alter proc prc_TotalEarningsForCustomer(@CustId nchar(5))
as
select
c.CompanyName, SUM(ord.Quantity*ord.UnitPrice)
from Orders o
inner join [Order Details] ord on o.OrderID = ord.OrderID
inner join Customers c on c.CustomerID = o.CustomerID
where c.CustomerID = @CustId
group by c.CompanyName,o.OrderDate
having YEAR(o.OrderDate)=1997

exec prc_TotalEarningsForCustomer 'ALFKI'

--We are going to insert some values in Shippers table 
--if values are inside of our table do not insert anything
--if values are not inside of our table insert it!

create proc prc_InsertShipper(@name nvarchar(40), @phone nvarchar(24))
as
if not exists
(select*from Shippers where CompanyName = @name and Phone=@phone)
begin
insert into Shippers(CompanyName, Phone) values(@name, @phone)
select*from Shippers
end
else
begin
print 'already inserted' 
end

exec prc_InsertShipper 'WindShipper', '234 56 78'


