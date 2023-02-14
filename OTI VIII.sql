use Northwind

select * from Employees
select * from Orders


alter procedure sp_ViewEmpleados
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

alter procedure NProduct
@NP nvarchar(40),
@QPU nvarchar(20),
@Unitprice money,
@UnitsInStock int,
@UnitsInOrder int,
@ReorderLevel int,
@Discontinued bit,

@IDS int,
@IDCat int

as
declare @IdSup as int 
set @IdSup = (select SupplierID from Suppliers where SupplierID=@IDS)
declare @IdCategory as int 
set @IdCategory = (select CategoryID from Categories where CategoryID = @IDCat)
 begin
  if(@Unitprice>0)
   begin
    if(@UnitsInStock>0)
     begin
      if(@IDS=@IdSup)
       begin
	   insert into Products(ProductName,SupplierID,CategoryID,QuantityPerUnit,UnitPrice,UnitsInStock,UnitsOnOrder,ReorderLevel,Discontinued)
	   values(@NP,@IDS,@IDCat,@QPU,@Unitprice,@UnitsInStock,@UnitsInOrder,@ReorderLevel,@Discontinued)
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



/*Estructura para Agregar Los Productos


 'ProductName - Quantityper Unit - UnitPrice  -  UnitsInStock - UnitsOnOrder - ReorderLevel - Discount - SupplierID - CategoryID' 


*/
NProduct 'Galleta','54 Und por Caja',20,10,10,10,0,1,2

select * from Products



--------------------------------------------------------------



create procedure Cantidad 
@FechaI date,
@FechaF date
as
select ProductName,Quantity,

Region=
case
when Sup.Region Is Null then 'No Region'
else
Sup.Region
end
from [Order Details]  OD 
inner join Orders O on O.OrderID = OD.OrderID
inner join Products P on P.ProductID = OD.ProductID
inner join Suppliers Sup on Sup.SupplierID = P.SupplierID
where O.OrderDate between @FechaI and @FechaF
group by ProductName,Quantity,Sup.Region

Cantidad '1996-07-03','1996-08-02'


-------------------------------------------------------------------------

create procedure Clasificacion
@FechaInicio as date,
@FechaFinal as date
as
Select E.FirstName,SUM((OD.UnitPrice*OD.Quantity*(1-OD.Discount))) as Ventas,
Estado =
case 
when SUM((OD.UnitPrice*OD.Quantity*(1-OD.Discount))) < 9000 then 'Negligente'
when SUM((OD.UnitPrice*OD.Quantity*(1-OD.Discount))) between 9000 and 20000 then 'Entrenado'
when SUM((OD.UnitPrice*OD.Quantity*(1-OD.Discount))) > 20000 then 'Eficiente'
else
'No Vendio'
end


from Employees E 
inner join Orders O on E.EmployeeID = O.EmployeeID
inner join [Order Details] OD on OD.OrderID = O.OrderID
inner join Products P on P.ProductID = OD.ProductID
where O.OrderDate between @FechaInicio and @FechaFinal
group by E.FirstName
order by E.FirstName

Clasificacion '1996-07-03','1997-08-02'


----------------------------------------------------


create procedure ProductMenosVendido
@Empleado nvarchar(10), @Territory nchar(50)
as
select top 1 with ties E.FirstName,P.ProductName,SUM(OD.Quantity) as Cantidad,
SUM(OD.UnitPrice*OD.Quantity*(1-OD.Discount)) as Ventas, T.TerritoryDescription

from Products P 
inner join [Order Details] OD on OD.ProductID = P.ProductID
inner join Orders O on O.OrderID = OD.OrderID
inner join Employees E on E.EmployeeID = O.EmployeeID
inner join EmployeeTerritories ET on ET.EmployeeID = E.EmployeeID
inner join Territories T on T.TerritoryID = ET.TerritoryID


where E.FirstName = @Empleado and T.TerritoryDescription = @Territory
group by OD.Quantity,E.FirstName,P.ProductName,T.TerritoryDescription
order by Cantidad desc

ProductMenosVendido 'Margaret','Greensboro'



-------------------------------------------------------