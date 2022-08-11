use SFCIB


create table Pedidos(
Id_Pedido int identity(1,1) primary key not null,
FechaPedido datetime default getdate() not null,
Id_Prov int foreign key references Proveedor(Id_Prov) not null,
SubTotalP float,
TotalP float,
EstadoPedido bit default 1 not null
)

create table Det_Pedidos(
Id_Pedido int foreign key references Pedidos(Id_Pedido) not null,
CodProd char(5) foreign key references Productos(CodProd) not null,
cantped int not null,
subtp float,
preciop float,
primary key(Id_Pedido,CodProd)
)

sp_bindrule 'NoNeg','Pedidos.SubTotalP'
sp_bindrule 'NoNeg', 'Pedidos.TotalP'
sp_bindrule 'NoNeg', 'Det_Pedidos.subtp'
sp_bindrule 'EPos', 'Det_Pedidos.subtp'
sp_bindrule 'EPos', 'Det_Pedidos.preciop'

create table Compras(
Id_Compras char(5) primary key not null,
Fecha_Compras datetime not null,
Id_Pedido int foreign key references Pedidos(Id_Pedido) not null,
subtotalc float,
totalc float

)

create table Det_Compras(
Id_Compras char(5) foreign key references Compras(Id_Compras) not null,
CodProd char(5) foreign key references Productos(CodProd) not null,
cantc int not null,
precioc float not null,
subtcom float,
primary key(Id_Compras,CodProd)
)

sp_bindrule 'NoNeg','Compras.subtotalc'
sp_bindrule 'NoNeg', 'Compras.totalc'
sp_bindrule 'EPos', 'Det_Compras.cantc'
sp_bindrule 'EPos', 'Det_Compras.precioc'
sp_bindrule 'NoNeg', 'Det_Compras.subtcom'



