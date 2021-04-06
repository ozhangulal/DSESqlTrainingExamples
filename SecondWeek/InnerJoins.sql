
--Please list which category with the names of which product

select
c.CategoryName, p.ProductName
from Products p
inner join Categories c on c.CategoryID = p.CategoryID

--Can you show me, Which supplier compnay bring to me which product?
select
s.CompanyName, p.ProductName
from Products p
inner join Suppliers s on s.SupplierID = p.SupplierID

--Can you show me, Which supplier company bring to me which product also I want to see category name?

select c.CategoryName, p.ProductName, s.CompanyName from Products p
inner join Categories c on c.CategoryID = p.CategoryID
inner join Suppliers s on s.SupplierID = p.SupplierID