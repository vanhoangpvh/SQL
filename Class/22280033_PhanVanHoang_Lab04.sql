--Cau 1
SELECT k.makh ,k.hoten, k.diachi ,k.thanhpho ,k.quocgia ,k.sodt 
FROM khachhang k 
JOIN dondathang d ON k.makh = d.makh 
GROUP BY k.makh , k.hoten,k.diachi ,k.thanhpho ,k.quocgia ,k.sodt  
HAVING sum(d.trigia) > 3000;

--Q1
select *
from KHACHHANG as KH
where KH.MaKH in (
   select MaKH
   from DONDATHANG as DDH
   group by DDH.MaKH
   having sum(DDH.TriGia)>3000)
   
   
SELECT * 
FROM  khachhang k 
WHERE k.makh in(
   SELECT d.makh
   FROM dondathang d
   GROUP BY d.makh
   HAVING sum(d.trigia)>3000);

--Cau 2
SELECT m.mamh, m.tenmh, m.dongia ,avg(c.dongia),sum(c.soluong) AS Tong_so_luong_don_hang
FROM mathang m 
JOIN chitietddh c ON m.mamh = c.mamh 
JOIN dondathang d ON d.maddh = c.maddh 
WHERE EXTRACT (MONTH FROM d.ngaydathang) = 7 AND EXTRACT (YEAR FROM d.ngaydathang) = 2012
GROUP BY m.mamh, m.tenmh ,m.dongia ;

--Cau 3
WITH tong_so_luong(mamh,tongsoluong) AS(
   SELECT mamh, sum(soluong)
   FROM chitietddh c
   GROUP BY mamh
)
SELECT m.mamh,m.tenmh 
FROM mathang m 
JOIN chitietddh c ON c.mamh = m.mamh 
GROUP BY m.mamh ,m.tenmh 
HAVING sum(c.soluong) = (SELECT max(tong_so_luong.tongsoluong) FROM tong_so_luong);

--Cau 4
SELECT d.maddh ,d.ngaydathang ,d.makh ,d.trigia 
FROM mathang m 
JOIN chitietddh c ON m.mamh = c.mamh 
JOIN dondathang d ON d.maddh = c.maddh 
WHERE c.soluong = (SELECT max(c2.soluong)FROM chitietddh c2);

SELECT *
FROM dondathang d
JOIN chitietddh c ON d.maddh = c.maddh

with TongMatHang (MaDDH,TongMH) as (
   select MaDDH, count(CT.MaMH)
   from CHITIETDDH as CT
   group by MaDDH
)
select DDH.MaDDH, count(CT.MaMH) as 'Tong so mat hang'
from DONDATHANG as DDH join CHITIETDDH as CT on DDH.MaDDH=CT.MaDDH
join TongMatHang as TMH on CT.MaDDH=TMH.MaDDH
group by DDH.MaDDH
having count(CT.MaMH)=
   (select max(TMH.TongMH) from TongMatHang as TMH)

--Cau 5
SELECT k.makh,k.hoten, sum(c.soluong) AS tong_so_don_hang
FROM khachhang k 
JOIN dondathang d ON k.makh = d.makh 
JOIN chitietddh c ON d.maddh = c.maddh 
GROUP BY k.makh ,k.hoten ;

--Cau 6
SELECT n.mancc ,n.tenncc ,n.email ,count(*)
FROM nhacungcap n 
JOIN mathang m ON m.mancc = n.mancc
GROUP BY n.mancc ,n.tenncc ,n.email,m.dongia
HAVING m.dongia > 30;

--Database
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
MaNCC int,
DonGia decimal(12,2),
TinhTrang int,
constraint PK_MATHANG primary key (MaMH),
constraint FK_MATHANG_NHACUNGCAP foreign key (MaNCC) references NHACUNGCAP(MaNCC),
constraint CHK_TINHTRANG check(TinhTrang in (0,1))
);

create table KHACHHANG(
MaKH int not null,
HoTen varchar(50),
DiaChi varchar(50),
ThanhPho varchar(40),
QuocGia varchar(40),
SoDT varchar(15),
constraint PK_KHACHHANG primary key(MaKH)
);

create table DONDATHANG(
MADDH int not null,
NgayDatHang timestamp,
MaKH int,
TriGia decimal(12,2),
constraint PK_DONDATHANG primary key (MaDDH),
);

alter table DONDATHANG
add constraint PK_DONDATHANG_KHACHHANG foreign key (MaKH) references KHACHHANG(MaKH);

create table CHITIETDDH(
	MACT int not null,
	MaDDH int not null,
	MaMH int,
	DonGia decimal(12,2),
	SoLuong int,
	constraint PK_CHITIETDDH primary key (MaCT, MaDDH),
);

alter table CHITIETDDH
add constraint FK_CHITIETDDH_MATHANG foreign key (MaMH) references MATHANG(MaMH);

alter table CHITIETDDH
add constraint FK_CHITIETDDH_DONDATHANG foreign key (MaDDH) references DONDATHANG(MaDDH);

insert into KHACHHANG
values
 (1,'Maria Anders',NULL,'Berlin','Germany','030-0074321');

insert into KHACHHANG 
values
(2,'Ana Trujillo',NULL,'Mexico D.F.','Mexico','(5) 555-4729'),
(3,'Antonio Moreno',NULL,'Mexico D.F.','Mexico','(5) 555-3932'),
(4,'Thomas Hardy',NULL,'London','UK','(171) 555-7788'),
(5,'Christina Berglund',NULL,'Lulea','Sweden','0921-12 34 65'),
(6,'Hanna Moos',NULL,'Mannheim','Germany','0621-08460'),
(7,'Frederique Citeaux',NULL,'Strasbourg','France','88.60.15.31'),
(8,'Martin Sommer',NULL,'Madrid','Spain','(91) 555 22 82'),
(9,'Laurence Lebihan',NULL,'Marseille','France','91.24.45.40'),
(10,'Elizabeth Lincoln',NULL,'Tsawassen','Canada','(604) 555-4729'),
(11,'Victoria Ashworth',NULL,'London','UK','(171) 555-1212'),
(12,'Patricio Simpson',NULL,'Buenos Aires','Argentina','(1) 135-5555'),
(13,'Francisco Chang',NULL,'Mexico D.F.','Mexico','(5) 555-3392'),
(14,'Yang Wang',NULL,'Bern','Switzerland','0452-076545'),
(15,'Pedro Afonso',NULL,'Sao Paulo','Brazil','(11) 555-7647'),
(16,'Elizabeth Brown',NULL,'London','UK','(171) 555-2282'),
(17,'Sven Ottlieb',NULL,'Aachen','Germany','0241-039123'),
(18,'Janine Labrune',NULL,'Nantes','France','40.67.88.88'),
(19,'Ann Devon',NULL,'London','UK','(171) 555-0297'),
(20,'Roland Mendel',NULL,'Graz','Austria','7675-3425'),
(21,'Aria Cruz',NULL,'Sao Paulo','Brazil','(11) 555-9857'),
(22,'Diego Roel',NULL,'Madrid','Spain','(91) 555 94 44'),
(23,'Martine Rance',NULL,'Lille','France','20.16.10.16'),
(24,'Maria Larsson',NULL,'Bracke','Sweden','0695-34 67 21'),
(25,'Peter Franken',NULL,'Munchen','Germany','089-0877310'),
(26,'Carine Schmitt',NULL,'Nantes','France','40.32.21.21'),
(27,'Paolo Accorti',NULL,'Torino','Italy','011-4988260'),
(28,'Lino Rodriguez',NULL,'Lisboa','Portugal','(1) 354-2534'),
(29,'Eduardo Saavedra',NULL,'Barcelona','Spain','(93) 203 4560'),
(30,'Jose Pedro Freyre',NULL,'Sevilla','Spain','(95) 555 82 82'),
(31,'Andre Fonseca',NULL,'Campinas','Brazil','(11) 555-9482'),
(32,'Howard Snyder',NULL,'Eugene','USA','(503) 555-7555'),
(33,'Manuel Pereira',NULL,'Caracas','Venezuela','(2) 283-2951'),
(34,'Mario Pontes',NULL,'Rio de Janeiro','Brazil','(21) 555-0091'),
(35,'Carlos Hernandez',NULL,'San Cristobal','Venezuela','(5) 555-1340'),
(36,'Yoshi Latimer',NULL,'Elgin','USA','(503) 555-6874'),
(37,'Patricia McKenna',NULL,'Cork','Ireland','2967 542'),
(38,'Helen Bennett',NULL,'Cowes','UK','(198) 555-8888'),
(39,'Philip Cramer',NULL,'Brandenburg','Germany','0555-09876'),
(40,'Daniel Tonini',NULL,'Versailles','France','30.59.84.10');


insert into NHACUNGCAP 
values
(1,'Exotic Liquids',NULL,'London','UK'),
(2,'New Orleans Cajun Delights',NULL,'New Orleans','USA'),
(3,'Grandma Kelly''s Homestead',NULL,'Ann Arbor','USA'),
(4,'Tokyo Traders',NULL,'Tokyo','Japan'),
(5,'Cooperativa de Quesos ''Las Cabras''',NULL,'Oviedo','Spain'),
(6,'Mayumi''s',NULL,'Osaka','Japan'),
(7,'Pavlova, Ltd.',NULL,'Melbourne','Australia'),
(8,'Specialty Biscuits, Ltd.',NULL,'Manchester','UK'),
(9,'PB Knackebrod AB',NULL,'Goteborg','Sweden'),
(10,'Refrescos Americanas LTDA',NULL,'Sao Paulo','Brazil'),
(11,'Heli Subwaren GmbH & Co. KG',NULL,'Berlin','Germany'),
(12,'Plutzer Lebensmittelgrobmarkte AG',NULL,'Frankfurt','Germany'),
(13,'Nord-Ost-Fisch Handelsgesellschaft mbH',NULL,'Cuxhaven','Germany'),
(14,'Formaggi Fortini s.r.l.',NULL,'Ravenna','Italy'),
(15,'Norske Meierier',NULL,'Sandvika','Norway'),
(16,'Bigfoot Breweries',NULL,'Bend','USA'),
(17,'Svensk Sjofoda AB',NULL,'Stockholm','Sweden'),
(18,'Aux joyeux ecclesiastiques',NULL,'Paris','France'),
(19,'New England Seafood Cannery',NULL,'Boston','USA'),
(20,'Leka Trading',NULL,'Singapore','Singapore'),
(21,'Lyngbysild',NULL,'Lyngby','Denmark'),
(22,'Zaanse Snoepfabriek',NULL,'Zaandam','Netherlands'),
(23,'Karkki Oy',NULL,'Lappeenranta','Finland'),
(24,'G''day, Mate',NULL,'Sydney','Australia'),
(25,'Ma Maison',NULL,'Montreal','Canada'),
(26,'Pasta Buttini s.r.l.',NULL,'Salerno','Italy'),
(27,'Escargots Nouveaux',NULL,'Montceau','France'),
(28,'Gai paturage',NULL,'Annecy','France'),
(29,'Forets d''erables',NULL,'Ste-Hyacinthe','Canada');

insert into MATHANG values(1,'Chai',1,18,0);
insert into MATHANG values(2,'Chang',1,19,0);
insert into MATHANG values(3,'Aniseed Syrup',1,10,0);
insert into MATHANG values(4,'Chef Anton''s''Cajun Seasoning',2,22,0);
insert into MATHANG values(5,'Chef Anton''s'' Gumbo Mix',2,21.35,1);
insert into MATHANG values(6,'Grandma''s'' Boysenberry Spread',3,25,0);
insert into MATHANG values(7,'Uncle Bob''s''Organic Dried Pears',3,30,0);
insert into MATHANG values(8,'Northwoods Cranberry Sauce',3,40,0);
insert into MATHANG values(9,'Mishi Kobe Niku',4,97,1);
insert into MATHANG values(10,'Ikura',4,31,0);
insert into MATHANG values(11,'Queso Cabrales',5,21,0);
insert into MATHANG values(12,'Queso Manchego La Pastora',5,38,0);
insert into MATHANG values(13,'Konbu',6,6,0);
insert into MATHANG values(14,'Tofu',6,23.25,0);
insert into MATHANG values(15,'Genen Shouyu',6,15.5,0);
insert into MATHANG values(16,'Pavlova',7,17.45,0);
insert into MATHANG values(17,'Alice Mutton',7,39,1);
insert into MATHANG values(18,'Carnarvon Tigers',7,62.5,0);
insert into MATHANG values(19,'Teatime Chocolate Biscuits',8,9.2,0);
insert into MATHANG values(20,'Sir Rodney''s'' Marmalade',8,81,0);
insert into MATHANG values(21,'Sir Rodney''s'' Scones',8,10,0);
insert into MATHANG values(22,'Gustaf''s'' Knackebröd',9,21,0);
insert into MATHANG values(23,'Tunnbrod',9,9,0);
insert into MATHANG values(24,'Guarana Fantastica',10,4.5,1);
insert into MATHANG values(25,'NuNuCa Nub-Nougat-Creme',11,14,0);
insert into MATHANG values(26,'Gumbar Gummibarchen',11,31.23,0);
insert into MATHANG values(27,'Schoggi Schokolade',11,43.9,0);
insert into MATHANG values(28,'Rossle Sauerkraut',12,45.6,1);
insert into MATHANG values(29,'Thuringer Rostbratwurst',12,123.79,1);
insert into MATHANG values(30,'Nord-Ost Matjeshering',13,25.89,0);
insert into MATHANG values(31,'Gorgonzola Telino',14,12.5,0);
insert into MATHANG values(32,'Mascarpone Fabioli',14,32,0);
insert into MATHANG values(33,'Geitost',15,2.5,0);
insert into MATHANG values(34,'Sasquatch Ale',16,14,0);
insert into MATHANG values(35,'Steeleye Stout',16,18,0);
insert into MATHANG values(36,'Inlagd Sill',17,19,0);
insert into MATHANG values(37,'Gravad lax',17,26,0);
insert into MATHANG values(38,'Cote de Blaye',18,263.5,0);
insert into MATHANG values(39,'Chartreuse verte',18,18,0);
insert into MATHANG values(40,'Boston Crab Meat',19,18.4,0);
insert into MATHANG values(41,'Jack''s'' New England Clam Chowder',19,9.65,0);
insert into MATHANG values(42,'Singaporean Hokkien Fried Mee',20,14,1);
insert into MATHANG values(43,'Ipoh Coffee',20,46,0);
insert into MATHANG values(44,'Gula Malacca',20,19.45,0);
insert into MATHANG values(45,'Rogede sild',21,9.5,0);
insert into MATHANG values(46,'Spegesild',21,12,0);
insert into MATHANG values(47,'Zaanse koeken',22,9.5,0);
insert into MATHANG values(48,'Chocolade',22,12.75,0);
insert into MATHANG values(49,'Maxilaku',23,20,0);
insert into MATHANG values(50,'Valkoinen suklaa',23,16.25,0);
insert into MATHANG values(51,'Manjimup Dried Apples',24,53,0);
insert into MATHANG values(52,'Filo Mix',24,7,0);
insert into MATHANG values(53,'Perth Pasties',24,32.8,1);
insert into MATHANG values(54,'Tourtiere',25,7.45,0);
insert into MATHANG values(55,'Pâté chinois',25,24,0);
insert into MATHANG values(56,'Gnocchi di nonna Alice',26,38,0);
insert into MATHANG values(57,'Ravioli Angelo',26,19.5,0);
insert into MATHANG values(58,'Escargots de Bourgogne',27,13.25,0);
insert into MATHANG values(59,'Raclette Courdavault',28,55,0);
insert into MATHANG values(60,'Camembert Pierrot',28,34,0);
insert into MATHANG values(61,'Sirop d''erable',29,28.5,0);
insert into MATHANG values(62,'Tarte au sucre',29,49.3,0);
insert into MATHANG values(63,'Vegie-spread',7,43.9,0);
insert into MATHANG values(64,'Wimmers gute Semmelknodel',12,33.25,0);
insert into MATHANG values(65,'Louisiana Fiery Hot Pepper Sauce',2,21.05,0);
insert into MATHANG values(66,'Louisiana Hot Spiced Okra',2,17,0);
insert into MATHANG values(67,'Laughing Lumberjack Lager',16,14,0);
insert into MATHANG values(68,'Scottish Longbreads',8,12.5,0);
insert into MATHANG values(69,'Gudbrandsdalsost',15,36,0);
insert into MATHANG values(70,'Outback Lager',7,15,0);
insert into MATHANG values(71,'Flotemysost',15,21.5,0);
insert into MATHANG values(72,'Mozzarella di Giovanni',14,34.8,0);
insert into MATHANG values(73,'Rod Kaviar',17,15,0);
insert into MATHANG values(74,'Longlife Tofu',4,10,0);
insert into MATHANG values(75,'Rhonbrau Klosterbier',12,7.75,0);
insert into MATHANG values(76,'Lakkalikoori',23,18,0);
insert into MATHANG values(77,'Original Frankfurter grune Sobe',12,13,0);
insert into MATHANG values(78,'Stroopwafels',22,9.75,0);


INSERT INTO DONDATHANG VALUES(1, '2012-07-04', 15, 440);
INSERT INTO DONDATHANG VALUES(2, '2012-07-05', 9, 1863.4);
INSERT INTO DONDATHANG VALUES(3, '2012-07-08', 34, 1813);
INSERT INTO DONDATHANG VALUES(4, '2012-07-08', 14, 670.8);
INSERT INTO DONDATHANG VALUES(5, '2012-07-09', 26, 3730);
INSERT INTO DONDATHANG VALUES(6, '2012-07-10', 34, 1444.8);
INSERT INTO DONDATHANG VALUES(7, '2012-07-11', 14, 625.2);
INSERT INTO DONDATHANG VALUES(8, '2012-07-12', 38, 2490.5);
INSERT INTO DONDATHANG VALUES(9, '2012-07-15', 28, 517.8);
INSERT INTO DONDATHANG VALUES(10, '2012-07-16', 35, 1119.9);


INSERT INTO CHITIETDDH VALUES(1,1,11,14,12);
INSERT INTO CHITIETDDH VALUES(2,1,42,9.8,10);
INSERT INTO CHITIETDDH VALUES(3,1,72,34.8,5);
INSERT INTO CHITIETDDH VALUES(4,2,14,18.6,9);
INSERT INTO CHITIETDDH VALUES(5,2,51,42.4,40);
INSERT INTO CHITIETDDH VALUES(6,3,31,7.7,10);
INSERT INTO CHITIETDDH VALUES(7,3,51,42.4,35);
INSERT INTO CHITIETDDH VALUES(8,3,65,16.8,15);
INSERT INTO CHITIETDDH VALUES(9,4,22,16.8,6);
INSERT INTO CHITIETDDH VALUES(10,4,57,15.6,15);
INSERT INTO CHITIETDDH VALUES(11,4,65,16.8,20);
INSERT INTO CHITIETDDH VALUES(12,5,20,64.8,40);
INSERT INTO CHITIETDDH VALUES(13,5,33,2,25);
INSERT INTO CHITIETDDH VALUES(14,5,60,27.2,40);
INSERT INTO CHITIETDDH VALUES(15,6,31,10,20);
INSERT INTO CHITIETDDH VALUES(16,6,39,14.4,42);
INSERT INTO CHITIETDDH VALUES(17,6,49,16,40);
INSERT INTO CHITIETDDH VALUES(18,7,24,3.6,15);
INSERT INTO CHITIETDDH VALUES(19,7,55,19.2,21);
INSERT INTO CHITIETDDH VALUES(20,7,74,8,21);
INSERT INTO CHITIETDDH VALUES(21,8,2,15.2,20);
INSERT INTO CHITIETDDH VALUES(22,8,16,13.9,35);
INSERT INTO CHITIETDDH VALUES(23,8,36,15.2,25);
INSERT INTO CHITIETDDH VALUES(24,8,59,44,30);
INSERT INTO CHITIETDDH VALUES(25,9,53,26.2,15);
INSERT INTO CHITIETDDH VALUES(26,9,77,10.4,12);
INSERT INTO CHITIETDDH VALUES(27,10,27,35.1,25);
INSERT INTO CHITIETDDH VALUES(28,10,39,14.4,6);
INSERT INTO CHITIETDDH VALUES(29,10,77,10.4,15);


