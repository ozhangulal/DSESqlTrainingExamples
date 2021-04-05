create table Employee
(
Id int primary key Identity(1,1),
Name nvarchar(50),
Surname nvarchar(50)
)

--insert into table_name(Name, Surname) values ('testName', 'testSurname')

insert into Employee(Name, Surname) values ('Kyrie', 'IRVING')
insert into Employee(Name, Surname) values ('Michael', 'JORDAN')

--phone(nvarchar) and address(ntext)
insert into Contact(Phone, Address) values ('234 56 78', 'New Jersey')

--Update example  

update Employee
set Name='Ozhan'
where Id=1

select* from Employee

delete from Employee where Id=2

