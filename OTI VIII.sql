use Northwind

select * from Employees
select * from Orders


create procedure sp_ViewEmpleados
@fechaI date,
@FechaF date,
@Ciudad nvarchar(15)
as
select E.FirstName,O.OrderDate,O.ShipCity from  Employees E
inner join Orders O on O.EmployeeID = E.EmployeeID
where O.OrderDate between @fechaI and @FechaF  and  O.ShipCity = @Ciudad
group by E.FirstName,E.FirstName,O.OrderDate,O.ShipCity
return

EXEC sp_ViewEmpleados '1996-07-01','1997-07-02','Rio de Janeiro'



------------------------------------------------------------------


select * from Suppliers
select * from Products
select * from Categories

Create procedure NProduct
@PD int,
@NP nvarchar(40),
@QPU nvarchar(20),
@Unitprice float,
@UnitsInStock int,
@UnitsInOrder int,
@ReorderLevel int,
@Discontinued bit,

@IDS int,
@IDCat int

as
declare @IdSup as int 
set @IdSup = (select SupplierID from Suppliers where SupplierID=@IDS)
declare @IdProd as int
set @IdProd = (select ProductID from Products where ProductID = @PD)
declare @IdCategory as int 
set @IdCategory = (select CategoryID from Categories where CategoryID = @IDCat)
if(@PD='' or @NP='' or @QPU='' or @IDCat='' or @IDS = '')
begin
 print 'No puede ser Null'
end
else
begin
 if(@PD=@IdProd)
 begin
  print 'No puede estar duplicado'
 end
 else
 begin
  if(@Unitprice>0)
   begin
    if(@UnitsInStock>0)
     begin
      if(@IDS=@IdSup)
       begin
	   insert into Products values(@PD,@NP,@IDS,@IDCat,@QPU,@Unitprice,@UnitsInStock,@UnitsInOrder,@ReorderLevel,0)
	   end
	   else
	   begin
	   print 'Suppliers No Registrado'
	   end
	  end
	 else
	begin
   print'UnitinStock No puede ser menor a 0'
  end
  end
  else
  begin
 print 'UnitPrice No puede ser menor a 0'
end
end
end


NProduct 78,'Galleta',7,4,'44 kg',15.50,100,10,30,0



--------------------------------------------------------------
select * from Employees
select * from Orders



create procedure sp_Clasificacion
@fechaI date,
@FechaF date
as
select  E.FirstName,Sum((OD.UnitPrice*OD.Quantity*(1-OD.Discount))) as Ventas,

 Estado =
 CASE
 WHEN sum(OD.UnitPrice*OD.Quantity*(1-OD.Discount)) < 9000 THEN 'Negligente'
 WHEN sum(OD.UnitPrice*OD.Quantity*(1-OD.Discount)) between 9000 and 20000 THEN 'Entrenado'
 WHEN sum(OD.UnitPrice*OD.Quantity*(1-OD.Discount)) > 20000 THEN 'Eficiente'
 else 'No vendio'
 END


from  Employees E
inner join Orders O on O.EmployeeID = E.EmployeeID
inner join [Order Details] OD on OD.OrderID = O.OrderID
inner join Products p on p.ProductID = OD.ProductID
Where O.OrderDate between @fechaI and @FechaF

group by E.FirstName
order by E.FirstName 


EXEC sp_Clasificacion '1996-01-01','1997-01-01'

----------------------------------------------------

create procedure CantidadMenosVendida
@FechaI date, 
@FechaF date
as
select distinct ProductName,Quantity,
Region =
case
when Sp.Region is null then 'Sin Region'
else
Sp.Region
end
from [Order Details] OD
inner join Orders O on O.OrderID = OD.OrderID
inner join Products P on Od.ProductID = P.ProductID
inner join Suppliers Sp on Sp.SupplierID = P.SupplierID
where OrderDate between @FechaI and @FechaF
group by ProductName,Quantity,Sp.Region


EXEC CantidadMenosVendida '1995-12-31','1996-12-31'


-----------------------------------------------------------

create procedure Product
@Nombre nvarchar(50),
@territory nvarchar(20)
as
select top 1 with ties P.ProductName,sum(OD.Quantity) as Cantidad, sum((OD.UnitPrice*OD.Quantity)*(1-OD.Discount)) as Monto
,T.TerritoryDescription

from Products P 
inner join [Order Details] OD on OD.ProductID = P.ProductID
inner join Orders O on O.OrderID = OD.OrderID
inner join Employees E on E.EmployeeID = O.EmployeeID
inner join EmployeeTerritories ET on ET.EmployeeID = E.EmployeeID
inner join Territories T on T.TerritoryID = ET.TerritoryID

where E.FirstName = @Nombre and T.TerritoryDescription = @territory
group by OD.Quantity,E.FirstName,P.ProductName,T.TerritoryDescription
order by Cantidad desc

select * from Employees
select * from Territories

exec Product 'Margaret','Greensboro'
