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

select NombreProd,preciop from Productos where existp<=3

create view EjProdExist
as
select NombreProd,preciop from Productos where existp<=3

select * from EjProdExist



select NombreMun,Id_Mun ,NombreDpto from Municipios full join Deptos on Municipios.Id_Mun = Deptos.Id_Dptos

create view MunxDptos as select NombreMun,Id_Mun ,NombreDpto from Municipios 
full join Deptos on Municipios.Id_Mun = Deptos.Id_Dptos




