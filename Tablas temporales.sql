-- Tablas Temporales
-- 1.- Tabla Temporal Local
use SFCIL

create table #Usuarios(
Id_Usuario int identity(1,1) primary key not null,
LoginU nvarchar(35) not null,
PassU varbinary(8000) not null
)

insert into #Usuarios values
('Ecespinoza',1101010)


select * from #Usuarios

-- 2.- Tabla Temporal Global
create table ##Usuarios(
Id_Usuario int identity(1,1) primary key not null,
LoginU nvarchar(35) not null,
PassU varbinary(8000) not null
)

insert into ##Usuarios values('Ecespinoza',1101010)


select * from ##Usuarios

-- 3.- CTE ( Common Table Expressions )

-- A diferencia de las anteriores, este tipo de tabla temporal 
-- solo puede ser utilizado durante la ejecución del bloque
-- de código y solo en una ocasión después de haber 
-- declarado el CTE.

use SFCIL

select *  from Municipios

;WITH nombreMun  ( Identificador , Nombre)
AS
(
       SELECT Id_Mun, NombreMun FROM Municipios
)
SELECT * FROM nombreMun


-- 4.- VARIABLES TIPO TABLA

-- Desde hace algunas versiones de SQL SERVER, se agregó la variable 
-- tipo TABLA, al igual que los CTE, solo están vigente durante la 
-- ejecución del bloque de código.

DECLARE @RegMun TABLE( Ident INT, Datos NVARCHAR(45) )

INSERT INTO @RegMun
SELECT Id_Mun, NombreMun FROM Municipios

SELECT * FROM @RegMun


-- 5.- tabla temporal con manejo de version del sistema
CREATE TABLE dbo.Trabajador   
(    
  [EmployeeID] int NOT NULL PRIMARY KEY CLUSTERED   
  , [Name] nvarchar(100) NOT NULL  
  , [Position] varchar(100) NOT NULL   
  , [Department] varchar(100) NOT NULL  
  , [Address] nvarchar(1024) NOT NULL  
  , [AnnualSalary] decimal (10,2) NOT NULL  
  , [ValidFrom] datetime2 (2) GENERATED ALWAYS AS ROW START  
  , [ValidTo] datetime2 (2) GENERATED ALWAYS AS ROW END  
  , PERIOD FOR SYSTEM_TIME (ValidFrom, ValidTo)  
 )    
 WITH (SYSTEM_VERSIONING = ON (HISTORY_TABLE = dbo.TrabajadorHistory));
 
 insert into Trabajador(EmployeeID, Name, Position,Department,
 Address, AnnualSalary)   values('1190',
 'Reynaldo Castaño','Docente Titular 140','Informatica','Managua',
 520000)

 select * from Trabajador

 insert into Trabajador(EmployeeID, Name, Position,Department,
 Address, AnnualSalary)   values('1184',
 'Evelyn Espinoza','Docente Titular 140','Informatica','Managua',
 550000)

 update Trabajador set AnnualSalary=600000 where EmployeeID='1190'

 select * from TrabajadorHistory

  update Trabajador set AnnualSalary=800000 where EmployeeID='1190'
