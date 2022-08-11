create database SFCIB
go
use SFCIB

create table Facultad(
	Id_Facultad char(3) primary key not null,
	NombreFac nvarchar(35) not null,
	NDecano nvarchar(50) not null,
	FConst date not null
)
go
create table Bar(
	Id_Bar int primary key identity(1,1) not null,
	NombreB nvarchar(35) not null,
	Propietario nvarchar(50) not null,
	Ubicacion nvarchar(50) not null
)
go
alter table Bar add FCreacion date not null

create table Deptos(
	Id_Dptos int identity(1,1) primary key not null,
	NombreDpto nvarchar(48) not null
)

create table Municipios(
	Id_Mun int identity(1,1) primary key not null,
	NombreMun nvarchar(45) not null,
	Id_Dpto int foreign key references Deptos(Id_Dptos) not null
)

create table Empleados(
	NEmp char(4) primary key not null,
	PNEmp nvarchar(15) not null,
	SNEmp nvarchar(15),
	PAEmp nvarchar(15) not null,
	SAEmp nvarchar(15),
	DirEmp nvarchar(70) not null,
	Id_Mun int foreign key references Municipios(Id_Mun) not null,
	TelEmp char(8) check(TelEmp like '[2|5|7|8][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')
)

alter table Empleados add Id_Bar int not null

alter table Empleados add constraint fk_BE foreign key(Id_Bar) references Bar(Id_Bar)


create table Clientes(
Id_Cliente char(5) primary key not null,
PNC nvarchar(15) not null,
SNC nvarchar(15) ,
PAC nvarchar(15) not null,
SAC nvarchar(15) ,
DirC nvarchar(75) not null,
Id_Mun int foreign key references Municipios(Id_Mun) not null,
TelC char(8) check(TelC like '[2|5|7|8][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
EstadoC bit default 1 not null,
)
alter table Bar add EstadoB bit default 1 not null

alter table Empleados add EstadoEmp bit default 1 not null

alter table Clientes add Id_Facultad char(3) not null

alter table Clientes add constraint fkfc foreign key(Id_Facultad) 
references Facultad(Id_Facultad)


create table Proveedor(
Id_Prov int identity(1,1) primary key not null,
NombreProv nvarchar(35) not null,
DirProv nvarchar(70) not null,
TelProv char(8) check(TelProv like '[2|5|7|8][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
EstadoProv bit default 1 not null,

)

Create table Contactos(
Id_Contacto int identity(1,1) primary key not null,
PNCont nvarchar(15) not null,
SNCont nvarchar(15) ,
PACont nvarchar(15) not null,
SACont nvarchar(15) ,
DirCont nvarchar(75) not null,
Id_Mun int foreign key references Municipios(Id_Mun) not null,
TelCont char(8) check(TelCont like '[2|5|7|8][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
EstadoCont bit default 1 not null,
Id_Prov int foreign key references Proveedor(Id_Prov) not null
)

alter table Proveedor add Id_Mun int not null

alter table Proveedor add constraint fkpm foreign key(Id_Mun) references Municipios(Id_Mun)


create table Productos(
CodProd char (5) primary key not null,
NombreProd nvarchar(50) not null,
DescProd nvarchar(70) not null,
preciop float not null,
existp int not null,
EstadoProd bit default 1 not null,
Id_Prov int foreign key references Proveedor(Id_Prov) not null
)

create rule EPos
as 
@v>0
  
sp_bindrule 'EPos','Productos.preciop'
sp_bindrule 'EPos', 'Productos.existp'


create table Ventas(
Id_Venta int identity(1,1) primary key not null,
Fecha_Venta datetime default getdate() not null,
Id_Cliente char(5) foreign key references Clientes(Id_Cliente) not null,
TotalV float not null
)

create table Det_Ventas(
Id_Venta int foreign key references Ventas(Id_Venta) not null,
CodProd char(5) foreign key references Productos(CodProd) not null,
cantv int not null,
subtp float ,
primary key(Id_Venta,CodProd)
)

Create rule NoNeg
as
@x>= 0

sp_bindrule 'NoNeg','Ventas.Totalv'
sp_bindrule 'EPos', 'Det_Ventas.cantv'
sp_bindrule 'Epos', 'Det_Ventas.subtp'
