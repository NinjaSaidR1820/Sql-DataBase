use SFCIB

--Delete Dptos
create procedure DeleteDpto
@ID int
as
declare @idd as int
set @idd=(select Id_Dptos from Deptos where Id_Dptos=@ID)
if(@ID=@idd)
begin
  delete from Deptos
  where Id_Dptos=@idd;
end
else
begin
  print 'Depto no encontrado'
end

ListarD

DeleteDpto 7

/////////////////////////////////////////////////////////////////////////////
///////////////////////////--Municipios--///////////////////////////////////

select * from Municipios

alter table Municipios add EstadoM bit default 1

update Municipios set EstadoM=1

--Dar baja
create procedure BMun
@ID int
as
declare @iddept as int
set @iddept=(select Id_Mun from Municipios where Id_Mun=@ID)
if(@iddept=@ID)
begin
  update Municipios set EstadoM=0 where Id_Mun=@ID
end
else
begin
  print 'Municipio no encontrado'
end

BMun 3

select * from Municipios

-- Buscar Municipios
create procedure BuscarMun
@ID int
as
declare @idd as int
set @idd=(select Id_Mun from Municipios where Id_Mun=@ID)
if(@ID=@idd)
begin
  select * from Municipios where Id_Mun=@ID
end
else
begin
  print 'Depto no encontrado'
end

BuscarMun 2



--listar Municipios

create procedure ListarM
as
select * from Municipios where EstadoM=1

ListarM 


-- Modificacion o Actualizacion
create procedure UpdateMun
@ID int,
@NM nvarchar(45)
as
declare @idd as int
set @idd=(select Id_Mun from Municipios where Id_Mun=@ID)
if(@idd=@ID)
begin
  if(@NM='')
  begin
    print 'No puede ser Null'
  end
  else
  begin
    update Municipios set NombreMun=@NM where Id_Mun=@ID and EstadoM=1
  end
end
else
begin
  print 'Municipio no encontrado'
end


UpdateMun 8,'Nandaime'

listarM

select * from Municipios



--Delete Dptos
create procedure DeleteMun
@ID int
as
declare @idd as int
set @idd=(select Id_Mun from Municipios where Id_Mun=@ID)
if(@ID=@idd)
begin
  delete from Municipios
  where Id_Mun=@idd;
end
else
begin
  print 'Depto no encontrado'
end

ListarM

select * from Municipios

DeleteMun 7

/////////////////////////////////////////////////////////////////////////////
///////////////////////////--Proveedores--///////////////////////////////////
--Agregar Proveedor

/////////////////////////////////////////////////////////////////////////////
///////////////////////////--Productos--////////////////////////////////////

--Agregar Produtos
