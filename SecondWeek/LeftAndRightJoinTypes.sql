create table Companies
(
CompanyId int,
CompanyName nvarchar(50)
)

create table Employee
(
EmployeeId int,
NameSurnam nvarchar(50)
)

create table Comp_Emp
(
CompEmpId int,
EmployeeId int,
Company int
)

select*from Companies
select*from Comp_Emp
select*from Employee

--we have to insert some data to companies table

insert into Companies Values(1, 'Microsoft')
insert into Companies Values(2, 'Apple')
insert into Companies Values(3, 'Facebook')
insert into Companies Values(4, 'Amazon')

--We have to insert some data to employees table

insert into Employee Values(1, 'Ozhan GULAL')
insert into Employee Values(2, 'Bill GATES')
insert into Employee Values(3, 'Steve JOBS')
insert into Employee Values(4, 'Jeff BEZOS')

--we Have to insert some data who is giving some consultant in some company

--number 2 Company has number 1 employee
insert into Comp_Emp values(1, 1, 2)

--number 2 Company has number 3 employee
insert into Comp_Emp values(2, 3, 2)

--number 1 company has number 4 employee
insert into Comp_Emp values(3, 4, 1)

--number 4 company has number 4 employee
insert into Comp_Emp values(4, 4, 4)

--Which consultant goes which company?
select c.CompanyName, e.NameSurnam from Employee e
inner join Comp_Emp ce on ce.EmployeeId = e.EmployeeId
inner join Companies c on c.CompanyId = ce.Company

--Which companies does not have any consultant?
select*from Companies c
left join Comp_Emp ce on c.CompanyId = ce.Company
where ce.Company is null

select*from Comp_Emp ce
right join Companies c on c.CompanyId = ce.Company
where ce.Company is null

--Who is not going anywhere as a consultant?

select*from Employee e
left join Comp_Emp ce on ce.EmployeeId = e.EmployeeId
where ce.EmployeeId is null

select * from Comp_Emp ce
right join Employee e on ce.EmployeeId = e.EmployeeId
where ce.EmployeeId is null
