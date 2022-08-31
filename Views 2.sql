use SFCIB

select * from Productos where preciop<30


create view EjCPT as
select * from Productos where preciop<30

select * from EjCPT


--1. Calculo de Predicado de Dominio

-- {npe | (3p)(Productos(npe) and p>1 and p<100)}

create view EjCPD as select NombreProd, preciop,existp from Productos where preciop between 1 and 100

select * from EjCPD

create procedure ProductosExist
@pinicial float,
@pFinal float
as
select NombreProd,preciop,existp from Productos where preciop between @pinicial and @pFinal


--Evaluacion Diagnostica
--Diseñar o Implementar la Consulta
--Algebra Relacional || Calculo de Predicado
--Tipo de Operacion
--Nombre de la Operacion
--Diseño de la Consulta
--Implementacion de la Consulta de TSQL

--1. Municipios x Dptos
--2. Pedidos x Proveedores
--3. Ventas x Fecha
--4. Productos con Existencias menores a 3
--5. Ventas x Clientes

select NombreProd,preciop, existp from Productos where existp<=3

create view EjProdExist
as
select NombreProd,preciop, existp from Productos where existp<=3

select * from EjProdExist



select *  NombreMun,Id_Mun ,NombreDpto from Municipios full join Deptos on Municipios.Id_Mun = Deptos.Id_Dptos 

create view MunxDptos as select NombreMun,Id_Mun ,NombreDpto from Municipios 
full join Deptos on Municipios.Id_Mun = Deptos.Id_Dptos


use SFCIB

select * from Productos
--Funciones Agregadas
--Suma,Count,Avg,Min,Max,var,stdev

select count(CodProd) as CantReg,
sum(existp) as CantP, 
AVG(preciop) as PrecioProm,
min(preciop) as PrecioMin,
max(preciop) as PrecioMax,
var (preciop) as VarianzaP,
stdev(preciop) as DesvEP from Productos


_--Funciones Standart del Sistema
--1. Fecha/Hora
--1.1 - Getdate(): Retorna la fecha y la hora del sistema
create view FAgregadas 

select GETDATE() as FechaHoraActual

--1.2 year(): Retorna el año de una fecha

select YEAR(GETDATE()) as AñoActual, year('19710619') as MiAñoNac

--1.3 Month():Retorna el mes de la fecha

select month(GETDATE()) as MesActual, month('19710619') as MiMesNac

--1.4 Day(): Retorna el dia de una fecha

select DAY(GETDATE()) as DiaActual, day('19710619') as MiDiaNac

--1.5 Datediff(): Diferenciar fechas 

select DATEDIFF(year,'19710619',GETDATE()) as EdadA,
DATEDIFF(MONTH,'19710619',GETDATE()) as EdadM,
DATEDIFF(WEEK,'19710619',GETDATE()) as EdadS,
DATEDIFF(Day,'19710619',GETDATE()) as EdadD,
DATEDIFF(HOUR,'19710619',GETDATE()) as EdadH

--1.6 DateAdd(): Sumar Fechas

select dateadd(day,10,GETDATE()) as DiezDD

--1.7 DateName()

select Datename(year,GETDATE()) as AñoActual,
Datename(MONTH,GETDATE()) as MesActual,
Datename(day,GETDATE()) as DiaActual,
Datename(DAYOFYEAR,GETDATE()) as DiaDelAño,
Datename(WEEKDAY,GETDATE()) as DiaSem


--1.8 datepart()

select datepart(year,GETDATE()) as AñoActual,
datepart(MONTH,GETDATE()) as MesActual,
datepart(day,GETDATE()) as DiaActual,
datepart(DAYOFYEAR,GETDATE()) as DiaDelAño,
datepart(WEEKDAY,GETDATE()) as DiaSem


--2. Cadena

--2.1 len(): devuelve la longitud a una cadena

select len(NombreProd) as LNP from Productos

--2.2 char(): Devuelve el caracter a partir de su codifgo ascii

select char(61) as caract

--2.3 asscii(): Devuelve el codigo de un caracter

select ascii('Ñ') as ValorA

--2.4 lower(): Transforma una cadena a minuscula

select lower('MONDONGO') as Minus

--2.5 Upper(): Transforma una cadena a Mayuscula

select upper('mondongo') as mayus

--2.6 SubString(): Abstraer una subcadena de una cadena

select SUBSTRING('001-180702-1008G',5,6) as FechaNac

--2.7 Charindex(): Coincidencia a partir de un indice

declare @document Varchar(64);
select @document = 'Reflectors are vital safety' +
                   ' components of your bicycle.';

select CHARINDEX('bicycle', @document) as indice

--2.8 concat(): concatenar cadenas

select CONCAT('Happy','Birthday','to', 11,'/',25) as result

--2.9 reverse() revertir una cadena

select reverse ('Angel') as NombreInvertido


--2.10 left() valores a partir de una posicion izquierda

select left('msc. en Computacion',8) as ParteIzq

--2.10 right() valores a partir de una posicion derecha

select right('msc. en Computacion',8) as ParteDer

--2.12 ltrim() elimina espacios en blanco de la izquierda

select ltrim('msc.en Computacion          ') as EBI

--2.12 Rtrim() elimina espacios en blanco de la derecha

select Rtrim('msc. en Computacion') as EBD


--3. Convertir

--cast,convert,parse,try_cast, try_convert,try_parse

--3.1 cast

declare @ani as int
set @ani = (select cast(SUBSTRING('001-180702-1008G',9,2) as int ) as AñoNac)  print @ani

--3.2 Convert

declare @anint as int
set @anint = (select Convert(int, SUBSTRING('001-180702-1008G',9,2)) as AñoNac)  print @anint

--3.3 Parse

select parse('monday, 13 december 2010' as datetime2 using 'en-us') as Result



