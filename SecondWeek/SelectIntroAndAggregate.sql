select * from Products
select ProductName, UnitsInStock, UnitsOnOrder from Products

select*from Products
where CategoryID=6

select p.ProductName, p.UnitPrice, p.UnitsOnOrder from Products p

--Aggregate Functions

select Count(*) from Products p

--How many products are the supplier with an ID of 6?
select COUNT(*) from Products p
where p.SupplierID=6

select*from Products
where SupplierID = 6

--the most expensive product
select MAX(p.UnitPrice) from Products p

--the cheapest product
select MIN(p.UnitPrice) from Products p 

--what is the average of all product price
select AVG(p.UnitPrice) from Products p

--what is the sum of all product price
select SUM(p.UnitPrice) from Products p

--DATEDIFF
--the count of days between date order was placed and date it was sent
select o.OrderID, DATEDIFF(DAY, o.OrderDate, o.ShippedDate) as 'Day Difference', 
o.OrderDate, o.ShippedDate from Orders o

--between
-- How many products do we have prices are between 10 and 20

select COUNT(*) from Products p
where p.UnitPrice between 10 and 20

--Can you show which countries we are exporting
select distinct o.ShipCountry from Orders o 

--can you show me some categories starting with 'B'

select*from Categories c
where c.CategoryName like 'b%'

select*from Categories c
where c.CategoryName like '%s'

select*from Categories c
where c.CategoryName like '%b%'