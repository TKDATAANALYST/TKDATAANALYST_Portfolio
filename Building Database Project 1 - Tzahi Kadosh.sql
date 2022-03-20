create database Sales;
--Executing "create database Sales;", changing owner to "sa" for handling the data types--
use Sales
--Executing "use sales"
create table CurrencyRate
(CurrencyRateID int not null primary key,
CurrencyRateDate datetime not null,
FromCurrencyCode nchar(3) not null,
ToCurrencyCode nchar(3) not null,
AverageRate money not null,
EndOfDayRate money not null,
ModifiedDate datetime not null)
create table Address
(AddressID int not null primary key,
AddressLine1 nvarchar(60) not null,
AddressLine2 nvarchar(60),
City nvarchar(30) not null,
StateProvinceID int not null,
PostalCode nvarchar(15) not null,
SpatialLocation geography,
rowguid uniqueidentifier not null,
ModifiedDate datetime not null)
create type Name
FROM nvarchar(50) not null;
go
create table ShipMethod
(ShipMethodID int not null primary key,
Name Name not null,
ShipBase money not null,
ShipRate money not null,
rowguid uniqueidentifier not null,
ModifiedDate datetime not null)
create table SpecialOfferProduct
(SpecialOfferID int not null,
ProductID int not null,
rowguid uniqueidentifier not null,
ModifiedDate datetime not null,
constraint PK_SpecialOfferProduct primary key (SpecialOfferID,ProductID))
create table CreditCard
(CreditCardID int not null primary key,
CardType nvarchar(50) not null,
CardNumber nvarchar(25) not null,
ExpMonth tinyint not null,
ExpYear smallint not null,
ModifiedDate datetime not null)
create table SalesTerritory
(TerritoryID int not null primary key,
Name Name not null,
CountryRegionCode nvarchar(3) not null,
[Group] nvarchar(50) not null,
SalesYTD money not null,
SalesLastYear money not null,
CostYTD money not null,
CostLastYear money not null,
rowguid uniqueidentifier not null,
ModifiedDate datetime not null)
create table SalesPerson
(BusinessEntityID int not null primary key,
TerritoryID int FOREIGN KEY REFERENCES SalesTerritory(TerritoryID),
SalesQuota money,
Bonus money not null,
CommissionPct smallmoney not null,
SalesYTD money not null,
SalesLastYear money not null,
rowguid uniqueidentifier not null,
ModifiedDate datetime not null)
create table Customer
(CustomerID int not null primary key,
PersonID int,
StoreID int,
TerrirotyID int FOREIGN KEY REFERENCES SalesTerritory(TerritoryID),
AccountNumber nvarchar(10) not null,
rowguid uniqueidentifier not null,
ModifiedDate datetime not null)
go
create type OrderNumber
from nvarchar(200)
create type AccountNumber
from nvarchar(200)
create type flag
from bit
go
create table SalesOrderHeader
(SalesOrderID int not null primary key,
RevisionNumber tinyint not null,
OrderDate datetime not null,
DueDate datetime not null,
ShipDate datetime,
Status tinyint not null,
OnlineOrderFlag flag not null,
SalesOrderNumber nvarchar(7) not null,
PurchaseOrderNumber OrderNumber,
AccountNumber AccountNumber,
CustomerID int not null FOREIGN KEY REFERENCES Customer(CustomerID),
SalesPersonID int FOREIGN KEY REFERENCES SalesPerson(BusinessEntityID),
TerritoryID int FOREIGN KEY REFERENCES SalesTerritory(TerritoryID),
BillToAddressID int not null FOREIGN KEY REFERENCES Address(AddressID),
ShipToAddressID int not null,
ShipMethodID int not null FOREIGN KEY REFERENCES ShipMethod(ShipMethodID),
CreditCardID int FOREIGN KEY REFERENCES CreditCard(CreditCardID),
CreditCardApprovalCode varchar(15),
CurrencyRateID int FOREIGN KEY REFERENCES CurrencyRate(CurrencyRateID),
SubTotal money not null,
TaxAmt money not null,
Freight money not null)
create table SalesOrderDetail
(SalesOrderID int not null FOREIGN KEY REFERENCES SalesOrderHeader(SalesOrderID),
SalesOrderDetailID int not null,
CarrierTrackingNumber nvarchar (25),
OrderQty smallint not null,
ProductID int not null,
SpecialOfferID int not null,
constraint FK_SpecialOfferProduct FOREIGN KEY (ProductID,SpecialOfferID) REFERENCES SpecialOfferProduct,
UnitPrice money not null,
UnitPriceDiscount money not null,
LineTotal money not null,
rowguid uniqueidentifier not null,
ModifiedDate datetime not null
constraint PK_SalesOrderDetail primary key (SalesOrderID,SalesOrderDetailID))