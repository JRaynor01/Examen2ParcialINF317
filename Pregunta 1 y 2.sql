---Borrar las tablas de la base de datos replicada
drop table Adventure2.dbo.Department;
drop table Adventure2.dbo.PayHistory;
delete from Adventure2.dbo.Department;
select * from Adventure2.dbo.Department;
---Crear la base de datos replicada
create database Adventure2;

use Adventure2
create table Department
(
	ID_Dep int,
	Name nvarchar(50),
	GroupName nvarchar(50),
	Modified datetime
);
use Adventure2
create table PayHistory
(
	BussinesEntity int,
	RateChange datetime,
	Rate money,
	PayFrequency tinyint,
	ModifiedDate datetime
);

-- Insertar datos en la tabla de destino desde la tabla de origen
INSERT INTO Adventure2.dbo.Department
SELECT * 
FROM AdventureWorks2012.HumanResources.Department
where not exists(
	select 1
	from Adventure2.dbo.Department
	where Adventure2.dbo.Department.ID_Dep = AdventureWorks2012.HumanResources.Department.DepartmentID
);

INSERT INTO Adventure2.dbo.PayHistory
SELECT * 
FROM AdventureWorks2012.HumanResources.EmployeePayHistory
where not exists(
	select 1
	from Adventure2.dbo.PayHistory
	where Adventure2.dbo.PayHistory.BussinesEntity = AdventureWorks2012.HumanResources.EmployeePayHistory.BusinessEntityID
);


select * from Adventure2.dbo.Department
select * from Adventure2.dbo.PayHistory
