use SFCIB

--Proveedor 
--agregar

create procedure CreateProv
@IDM int,
@NP nvarchar(35),
@DP nvarchar(70),
@TEL char(8)
as
declare @idd as int
set @idd=(select Id_Prov from Proveedor where Id_Prov=@IDM)
if(@NP='' or @DP='' or @TEL='')
begin
  print 'No puede ser nulo'
end
else
begin
  if(@IDM=@idd)
  begin
    insert into Proveedor values(@NP,@DP,@TEL,1,@IDM)
  end
  else
  begin
    print 'Proveedor no registrado'
  end
end

CreateProv 2,'Dianas','Carretera Norte','22222222'

select * from Proveedor

--Dar Baja

create procedure BProv
@ID int
as
declare @iddept as int
set @iddept=(select Id_Prov from Proveedor where Id_Prov=@ID)
if(@iddept=@ID)
begin
  update Proveedor set EstadoProv=0 where Id_Prov=@ID
end
else
begin
  print 'Proveedor no encontrado'
end

BProv 2

select * from Proveedor






--Productos
--Agregar
Create procedure Nprod
@CP char(5),
@NP nvarchar(50),
@DP nvarchar(70),
@pp float,
@e int,
@IDP int
as
declare @idprov as int 
set @idprov=(select Id_prov from Proveedor where Id_Prov=@IDP)
declare @codp as char (5)
set @codp=(select CodProd from Productos where CodProd=@CP)
if(@CP='' or @NP='' or @DP='')
begin
 print 'No puede ser Null'
end
else
begin
 if(@CP=@codp)
 begin
  print 'No puede estar duplicado'
 end
 else
 begin
  if(@pp>0)
   begin
    if(@e>0)
     begin
      if(@IDP=@idprov)
       begin
	   insert into Productos values(@CP,@NP,@DP,@pp,@e,1,@IDP)
	   end
	   else
	   begin
	   print 'Proveedor No Registrado'
	   end
	  end
	 else
	begin
   print'Existencia No puede ser menor a 0'
  end
  end
  else
  begin
 print 'Precio No puede ser menor a 0'
end
end
end


NProd '05','Principe','galleta',10,9,1

select * from Productos