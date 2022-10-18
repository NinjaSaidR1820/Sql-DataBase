use SFCIB

create table ValueTable (id Int);
begin transaction
     insert into ValueTable values(1);
	 insert into ValueTable values(2);
commit;

RollBack;  --ROLLBACK: Deshacer Transaction



select * from ValueTable

use Northwind

select * from Region

insert into Region values(5, 'Atlantico Norte'),
(6, 'Caribe Sur')

begin transaction
delete from Region
 where RegionID = 5;
commit;

--Tabla Cuentas(Cordobas - Dolares), Ahorro (Cordobas - Dolares))
-- Cuenta Habiente(Natural, Juridico)
--Movimiento de Cuentas(Fecha, Tipo Movimiento(Deposito,Retiro,Pago,Debito Automatico,
--                                                            Transferencia(Al mismo banco),ACH)), Monto, Saldo)
--Consulta Estado de Cuenta
--Implementar a Parte de todo lo abordado
--Tran Explicitas.




Create Database Banco

use Banco

Create table TransaccionBanco 
(
TransactionID int IDENTITY(1,1),
N_Cuenta nvarchar(25) Not Null,
FechaTrans datetime not null Default getdate(), 
TipoTrans nvarchar(25) Not Null,
MontoTrans money Default '0',
Balance money Default '0' ,
Primary Key(TransactionID) 
);

Create table Cliente(
Id_Cliente int primary key not null,
Nombre nvarchar(15) not null,
Direccion nvarchar(30) not null,
)

Create table Cuenta(
Id_Cuenta int primary key not null,
TipoMoneda nvarchar(10) not null,
monto float not null,
Cliente int foreign key references Cliente(Id_Cliente)
)

-- Crear Transaction
Begin transaction deposito
update Cuenta
set monto = monto + 1000
where Cuenta.Cliente = 1  
save transaction P1
Rollback transaction P1
commit transaction Cuenta


-- Crear Retiro
Begin transaction Retiro
update Cuenta
set monto = monto - 1000
where Cuenta.Cliente = 1 and monto >=0
save transaction P1
Rollback transaction P1
commit transaction Retiro


insert into Cliente values (2,'Leandro-Kun','No se')
select * from Cliente


insert into Cuenta values (2,'Cordoba',35000,2)
select * from Cuenta
