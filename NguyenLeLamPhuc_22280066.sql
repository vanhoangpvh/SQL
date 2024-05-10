use master;
go
if exists(select * from sys.databases where name='Csdl_Dondathang')
begin
	drop database Csdl_Dondathang;
end;
go
create database Csdl_Dondathang;
go

use Csdl_Dondathang;
go

create table NHACUNGCAP(
MaNCC int not null,
TenNCC varchar(40),
Email varchar(40),
ThanhPho varchar(40),
QuocGia varchar(40),
constraint PK_NHACUNGCAP primary key (MaNCC)
);

create table MATHANG(
MaMH int not null,
TenMH varchar(50),
MaNCC int not null,
DonGia decimal(12,2),
TinhTrang int, check (TinhTrang in (0,1)),
constraint PK_MATHANG primary key (MaMH),
constraint FK_MATHANG_NHACUNGCAP foreign key (MaNCC)
								 references NHACUNGCAP (MaNCC)
);

create table KHACHHANG(
MaKH int not null,
HoTen varchar(50),
DiaChi varchar(50) null,
ThanhPho varchar(40),
QuocGia varchar(40),
SoDT varchar(15),
constraint PK_KHACHHANG primary key (MaKH)
);

create table DONDATHANG(
MaDDH int not null,
NgayDatHang datetime,
MaKH int not null,
TriGia decimal(12,2)
constraint PK_DONDATHANG primary key (MaDDH),
constraint FK_DONDATHANG_KHACHHANG foreign key (MaKH)
								   references KHACHHANG (MaKH)
);

create table CHITIETDDH(
MaCT int not null,
MaDDH int not null,
MaMH int not null,
DonGia decimal(12,2),
SoLuong int,
constraint PK_CHITIETDDH primary key (MaCT, MaDDH),
constraint FK_CHITIETDDH_DONDATHANG foreign key (MaDDH)
									 references DONDATHANG (MaDDH),
constraint FK_CHITIETDDH_MATHANG foreign key (MaMH)
							     references MATHANG (MaMH)
);


insert into NHACUNGCAP values(1,'Exotic Liquids',NULL,'London','UK')
insert into NHACUNGCAP values(2,'New Orleans Cajun Delights',NULL,'New Orleans','USA')
insert into NHACUNGCAP values(3,'Grandma Kellys Homestead',NULL,'Ann Arbor','USA')
insert into NHACUNGCAP values(4,'Tokyo Traders',NULL,'Tokyo','Japan')
insert into NHACUNGCAP values(5,'Cooperativa de Quesos ''Las Cabras''',NULL,'Oviedo','Spain')
insert into NHACUNGCAP values(6,'Mayumi''s',NULL,'Osaka','Japan')
insert into NHACUNGCAP values(7,'Pavlova, Ltd.',NULL,'Melbourne','Australia')
insert into NHACUNGCAP values(8,'Specialty Biscuits, Ltd.',NULL,'Manchester','UK')
insert into NHACUNGCAP values(9,'PB Knackebrod AB',NULL,'Goteborg','Sweden')
insert into NHACUNGCAP values(10,'Refrescos Americanas LTDA',NULL,'Sao Paulo','Brazil')
insert into NHACUNGCAP values(11,'Heli Subwaren GmbH & Co. KG',NULL,'Berlin','Germany')
insert into NHACUNGCAP values(12,'Plutzer Lebensmittelgrobmarkte AG',NULL,'Frankfurt','Germany')
insert into NHACUNGCAP values(13,'Nord-Ost-Fisch Handelsgesellschaft mbH',NULL,'Cuxhaven','Germany')
insert into NHACUNGCAP values(14,'Formaggi Fortini s.r.l.',NULL,'Ravenna','Italy')
insert into NHACUNGCAP values(15,'Norske Meierier',NULL,'Sandvika','Norway')
insert into NHACUNGCAP values(16,'Bigfoot Breweries',NULL,'Bend','USA')
insert into NHACUNGCAP values(17,'Svensk Sjofoda AB',NULL,'Stockholm','Sweden')
insert into NHACUNGCAP values(18,'Aux joyeux ecclesiastiques',NULL,'Paris','France')
insert into NHACUNGCAP values(19,'New England Seafood Cannery',NULL,'Boston','USA')
insert into NHACUNGCAP values(20,'Leka Trading',NULL,'Singapore','Singapore')
insert into NHACUNGCAP values(21,'Lyngbysild',NULL,'Lyngby','Denmark')
insert into NHACUNGCAP values(22,'Zaanse Snoepfabriek',NULL,'Zaandam','Netherlands')
insert into NHACUNGCAP values(23,'Karkki Oy',NULL,'Lappeenranta','Finland')
insert into NHACUNGCAP values(24,'G''day, Mate',NULL,'Sydney','Australia')
insert into NHACUNGCAP values(25,'Ma Maison',NULL,'Montreal','Canada')
insert into NHACUNGCAP values(26,'Pasta Buttini s.r.l.',NULL,'Salerno','Italy')
insert into NHACUNGCAP values(27,'Escargots Nouveaux',NULL,'Montceau','France')
insert into NHACUNGCAP values(28,'Gai paturage',NULL,'Annecy','France')
insert into NHACUNGCAP values(29,'Forets d''erables',NULL,'Ste-Hyacinthe','Canada')


insert into KHACHHANG values(1,'Maria Anders',NULL,'Berlin','Germany','030-0074321')
insert into KHACHHANG values(2,'Ana Trujillo',NULL,'Mexico D.F.','Mexico','(5) 555-4729')
insert into KHACHHANG values(3,'Antonio Moreno',NULL,'Mexico D.F.','Mexico','(5) 555-3932')
insert into KHACHHANG values(4,'Thomas Hardy',NULL,'London','UK','(171) 555-7788')
insert into KHACHHANG values(5,'Christina Berglund',NULL,'Lulea','Sweden','0921-12 34 65')
insert into KHACHHANG values(6,'Hanna Moos',NULL,'Mannheim','Germany','0621-08460')
insert into KHACHHANG values(7,'Frederique Citeaux',NULL,'Strasbourg','France','88.60.15.31')
insert into KHACHHANG values(8,'Martin Sommer',NULL,'Madrid','Spain','(91) 555 22 82')
insert into KHACHHANG values(9,'Laurence Lebihan',NULL,'Marseille','France','91.24.45.40')
insert into KHACHHANG values(10,'Elizabeth Lincoln',NULL,'Tsawassen','Canada','(604) 555-4729')
insert into KHACHHANG values(11,'Victoria Ashworth',NULL,'London','UK','(171) 555-1212')
insert into KHACHHANG values(12,'Patricio Simpson',NULL,'Buenos Aires','Argentina','(1) 135-5555')
insert into KHACHHANG values(13,'Francisco Chang',NULL,'Mexico D.F.','Mexico','(5) 555-3392')
insert into KHACHHANG values(14,'Yang Wang',NULL,'Bern','Switzerland','0452-076545')
insert into KHACHHANG values(15,'Pedro Afonso',NULL,'Sao Paulo','Brazil','(11) 555-7647')
insert into KHACHHANG values(16,'Elizabeth Brown',NULL,'London','UK','(171) 555-2282')
insert into KHACHHANG values(17,'Sven Ottlieb',NULL,'Aachen','Germany','0241-039123')
insert into KHACHHANG values(18,'Janine Labrune',NULL,'Nantes','France','40.67.88.88')
insert into KHACHHANG values(19,'Ann Devon',NULL,'London','UK','(171) 555-0297')
insert into KHACHHANG values(20,'Roland Mendel',NULL,'Graz','Austria','7675-3425')
insert into KHACHHANG values(21,'Aria Cruz',NULL,'Sao Paulo','Brazil','(11) 555-9857')
insert into KHACHHANG values(22,'Diego Roel',NULL,'Madrid','Spain','(91) 555 94 44')
insert into KHACHHANG values(23,'Martine Rance',NULL,'Lille','France','20.16.10.16')
insert into KHACHHANG values(24,'Maria Larsson',NULL,'Bracke','Sweden','0695-34 67 21')
insert into KHACHHANG values(25,'Peter Franken',NULL,'Munchen','Germany','089-0877310')
insert into KHACHHANG values(26,'Carine Schmitt',NULL,'Nantes','France','40.32.21.21')
insert into KHACHHANG values(27,'Paolo Accorti',NULL,'Torino','Italy','011-4988260')
insert into KHACHHANG values(28,'Lino Rodriguez',NULL,'Lisboa','Portugal','(1) 354-2534')
insert into KHACHHANG values(29,'Eduardo Saavedra',NULL,'Barcelona','Spain','(93) 203 4560')
insert into KHACHHANG values(30,'Jose Pedro Freyre',NULL,'Sevilla','Spain','(95) 555 82 82')
insert into KHACHHANG values(31,'Andre Fonseca',NULL,'Campinas','Brazil','(11) 555-9482')
insert into KHACHHANG values(32,'Howard Snyder',NULL,'Eugene','USA','(503) 555-7555')
insert into KHACHHANG values(33,'Manuel Pereira',NULL,'Caracas','Venezuela','(2) 283-2951')
insert into KHACHHANG values(34,'Mario Pontes',NULL,'Rio de Janeiro','Brazil','(21) 555-0091')
insert into KHACHHANG values(35,'Carlos Hernandez',NULL,'San Cristobal','Venezuela','(5) 555-1340')
insert into KHACHHANG values(36,'Yoshi Latimer',NULL,'Elgin','USA','(503) 555-6874')
insert into KHACHHANG values(37,'Patricia McKenna',NULL,'Cork','Ireland','2967 542')
insert into KHACHHANG values(38,'Helen Bennett',NULL,'Cowes','UK','(198) 555-8888')
insert into KHACHHANG values(39,'Philip Cramer',NULL,'Brandenburg','Germany','0555-09876')
insert into KHACHHANG values(40,'Daniel Tonini',NULL,'Versailles','France','30.59.84.10')

insert into MATHANG values(1,'Chai',1,18,0)
insert into MATHANG values(2,'Chang',1,19,0)
insert into MATHANG values(3,'Aniseed Syrup',1,10,0)
insert into MATHANG values(4,'Chef Anton''s''Cajun Seasoning',2,22,0)
insert into MATHANG values(5,'Chef Anton''s'' Gumbo Mix',2,21.35,1)
insert into MATHANG values(6,'Grandma''s'' Boysenberry Spread',3,25,0)
insert into MATHANG values(7,'Uncle Bob''s''Organic Dried Pears',3,30,0)
insert into MATHANG values(8,'Northwoods Cranberry Sauce',3,40,0)
insert into MATHANG values(9,'Mishi Kobe Niku',4,97,1)
insert into MATHANG values(10,'Ikura',4,31,0)
insert into MATHANG values(11,'Queso Cabrales',5,21,0)
insert into MATHANG values(12,'Queso Manchego La Pastora',5,38,0)
insert into MATHANG values(13,'Konbu',6,6,0)
insert into MATHANG values(14,'Tofu',6,23.25,0)
insert into MATHANG values(15,'Genen Shouyu',6,15.5,0)
insert into MATHANG values(16,'Pavlova',7,17.45,0)
insert into MATHANG values(17,'Alice Mutton',7,39,1)
insert into MATHANG values(18,'Carnarvon Tigers',7,62.5,0)
insert into MATHANG values(19,'Teatime Chocolate Biscuits',8,9.2,0)
insert into MATHANG values(20,'Sir Rodney''s'' Marmalade',8,81,0)
insert into MATHANG values(21,'Sir Rodney''s'' Scones',8,10,0)
insert into MATHANG values(22,'Gustaf''s'' Knackebröd',9,21,0)
insert into MATHANG values(23,'Tunnbrod',9,9,0)
insert into MATHANG values(24,'Guarana Fantastica',10,4.5,1)
insert into MATHANG values(25,'NuNuCa Nub-Nougat-Creme',11,14,0)
insert into MATHANG values(26,'Gumbar Gummibarchen',11,31.23,0)
insert into MATHANG values(27,'Schoggi Schokolade',11,43.9,0)
insert into MATHANG values(28,'Rossle Sauerkraut',12,45.6,1)
insert into MATHANG values(29,'Thuringer Rostbratwurst',12,123.79,1)
insert into MATHANG values(30,'Nord-Ost Matjeshering',13,25.89,0)
insert into MATHANG values(31,'Gorgonzola Telino',14,12.5,0)
insert into MATHANG values(32,'Mascarpone Fabioli',14,32,0)
insert into MATHANG values(33,'Geitost',15,2.5,0)
insert into MATHANG values(34,'Sasquatch Ale',16,14,0)
insert into MATHANG values(35,'Steeleye Stout',16,18,0)
insert into MATHANG values(36,'Inlagd Sill',17,19,0)
insert into MATHANG values(37,'Gravad lax',17,26,0)
insert into MATHANG values(38,'Cote de Blaye',18,263.5,0)
insert into MATHANG values(39,'Chartreuse verte',18,18,0)
insert into MATHANG values(40,'Boston Crab Meat',19,18.4,0)
insert into MATHANG values(41,'Jack''s'' New England Clam Chowder',19,9.65,0)
insert into MATHANG values(42,'Singaporean Hokkien Fried Mee',20,14,1)
insert into MATHANG values(43,'Ipoh Coffee',20,46,0)
insert into MATHANG values(44,'Gula Malacca',20,19.45,0)
insert into MATHANG values(45,'Rogede sild',21,9.5,0)
insert into MATHANG values(46,'Spegesild',21,12,0)
insert into MATHANG values(47,'Zaanse koeken',22,9.5,0)
insert into MATHANG values(48,'Chocolade',22,12.75,0)
insert into MATHANG values(49,'Maxilaku',23,20,0)
insert into MATHANG values(50,'Valkoinen suklaa',23,16.25,0)
insert into MATHANG values(51,'Manjimup Dried Apples',24,53,0)
insert into MATHANG values(52,'Filo Mix',24,7,0)
insert into MATHANG values(53,'Perth Pasties',24,32.8,1)
insert into MATHANG values(54,'Tourtiere',25,7.45,0)
insert into MATHANG values(55,'Pâté chinois',25,24,0)
insert into MATHANG values(56,'Gnocchi di nonna Alice',26,38,0)
insert into MATHANG values(57,'Ravioli Angelo',26,19.5,0)
insert into MATHANG values(58,'Escargots de Bourgogne',27,13.25,0)
insert into MATHANG values(59,'Raclette Courdavault',28,55,0)
insert into MATHANG values(60,'Camembert Pierrot',28,34,0)
insert into MATHANG values(61,'Sirop d''erable',29,28.5,0)
insert into MATHANG values(62,'Tarte au sucre',29,49.3,0)
insert into MATHANG values(63,'Vegie-spread',7,43.9,0)
insert into MATHANG values(64,'Wimmers gute Semmelknodel',12,33.25,0)
insert into MATHANG values(65,'Louisiana Fiery Hot Pepper Sauce',2,21.05,0)
insert into MATHANG values(66,'Louisiana Hot Spiced Okra',2,17,0)
insert into MATHANG values(67,'Laughing Lumberjack Lager',16,14,0)
insert into MATHANG values(68,'Scottish Longbreads',8,12.5,0)
insert into MATHANG values(69,'Gudbrandsdalsost',15,36,0)
insert into MATHANG values(70,'Outback Lager',7,15,0)
insert into MATHANG values(71,'Flotemysost',15,21.5,0)
insert into MATHANG values(72,'Mozzarella di Giovanni',14,34.8,0)
insert into MATHANG values(73,'Rod Kaviar',17,15,0)
insert into MATHANG values(74,'Longlife Tofu',4,10,0)
insert into MATHANG values(75,'Rhonbrau Klosterbier',12,7.75,0)
insert into MATHANG values(76,'Lakkalikoori',23,18,0)
insert into MATHANG values(77,'Original Frankfurter grune Sobe',12,13,0)
insert into MATHANG values(78,'Stroopwafels',22,9.75,0)


insert into DONDATHANG values(1,'07/04/2012',15,440)
insert into DONDATHANG values(2,'07/05/2012',9,1863.4)
insert into DONDATHANG values(3,'07/08/2012',34,1813)
insert into DONDATHANG values(4,'07/08/2012',14,670.8)
insert into DONDATHANG values(5,'07/09/2012',26,3730)
insert into DONDATHANG values(6,'07/10/2012',34,1444.8)
insert into DONDATHANG values(7,'07/11/2012',14,625.2)
insert into DONDATHANG values(8,'07/12/2012',38,2490.5)
insert into DONDATHANG values(9,'07/15/2012',28,517.8)
insert into DONDATHANG values(10,'07/16/2012',35,1119.9)

insert into CHITIETDDH values(1,1,11,14,12)
insert into CHITIETDDH values(2,1,42,9.8,10)
insert into CHITIETDDH values(3,1,72,34.8,5)
insert into CHITIETDDH values(4,2,14,18.6,9)
insert into CHITIETDDH values(5,2,51,42.4,40)
insert into CHITIETDDH values(6,3,31,7.7,10)
insert into CHITIETDDH values(7,3,51,42.4,35)
insert into CHITIETDDH values(8,3,65,16.8,15)
insert into CHITIETDDH values(9,4,22,16.8,6)
insert into CHITIETDDH values(10,4,57,15.6,15)
insert into CHITIETDDH values(11,4,65,16.8,20)
insert into CHITIETDDH values(12,5,20,64.8,40)
insert into CHITIETDDH values(13,5,33,2,25)
insert into CHITIETDDH values(14,5,60,27.2,40)
insert into CHITIETDDH values(15,6,31,10,20)
insert into CHITIETDDH values(16,6,39,14.4,42)
insert into CHITIETDDH values(17,6,49,16,40)
insert into CHITIETDDH values(18,7,24,3.6,15)
insert into CHITIETDDH values(19,7,55,19.2,21)
insert into CHITIETDDH values(20,7,74,8,21)
insert into CHITIETDDH values(21,8,2,15.2,20)
insert into CHITIETDDH values(22,8,16,13.9,35)
insert into CHITIETDDH values(23,8,36,15.2,25)
insert into CHITIETDDH values(24,8,59,44,30)
insert into CHITIETDDH values(25,9,53,26.2,15)
insert into CHITIETDDH values(26,9,77,10.4,12)
insert into CHITIETDDH values(27,10,27,35.1,25)
insert into CHITIETDDH values(28,10,39,14.4,6)
insert into CHITIETDDH values(29,10,77,10.4,15)

-- Q1
select MH.MaMH, MH.TenMH, NCC.MaNCC, NCC.TenNCC
from MATHANG as MH join NHACUNGCAP as NCC on MH.MaNCC=NCC.MaNCC
-- Q2
select MH.MaMH, TenMH
from MATHANG as MH join CHITIETDDH as CT on MH.MaMH=CT.MaMH
join DONDATHANG as DDH on CT.MaDDH=DDH.MaDDH and MaKH=34
-- Q3
select MH.MaMH, TenMH, count(DDH.MaKH) as 'Tong so khach hang'
from MATHANG as MH left join CHITIETDDH as CT on MH.MaMH=CT.MaMH
left join DONDATHANG as DDH on CT.MaDDH=DDH.MaDDH
group by MH.MaMH, TenMH

-- Q4
select MH.MaMH, TenMH, count(MaDDH) as 'Tong so don dat hang', coalesce(sum(SoLuong), 0) AS 'Tong so luong da ban'
from MATHANG as MH left join CHITIETDDH as CT on MH.MaMH=CT.MaMH
group by MH.MaMH, TenMH

-- Q5 
with TrungBinh (MaMH,TB_DonGia) as (
	select MaMH, avg(CT.DonGia)
	from CHITIETDDH as CT
	group by MaMH
)
select MH.MaMH, TenMH, MH.DonGia, MH.DonGia-TB_DonGia as 'Chenh lech'
from MATHANG as MH join TrungBinh on MH.MaMH=TrungBinh.MaMH
