--22280033
--Phan Van Hoang
--Postgre sql

create database csdl_HuanLuyenVatNuoi;

create table CHUONG(
	KhuVuc int,
	SoChuong int not null,
	constraint pk_sochuong primary key (SoChuong)
);

create table LOAI_VATNUOI(
	MaLoai int not null,
	TenLoai varchar(10) not null,
	constraint pk_maloai primary key (MaLoai)
);

create table VATNUOI(
	LoaiVN int,
	MaVN int not null,
   Ten varchar(30) not null,
   SoChuong int not null,
   TrongLuong float,
   constraint pk_mavn primary key (MaVN),
   constraint fk_loaivn foreign key (LoaiVN) references LOAI_VATNUOI(MaLoai),
   constraint fk_sochuong foreign key (SoChuong) references CHUONG(SoChuong)
);

create table HUANLUYENVIEN(
	MaHLV int not null,
	Ho varchar(30) not null,
	Ten varchar(15) not null,
	NgaySinh date,
	Luong int,
	SoCC char(12) not null,
	HanCC date not null,
	CapBac int check (CapBac >=1 and CapBac <=5) default 1,
	constraint pk_mahlv primary key (MaHLV)
);

create table CAHUANLUYEN(
	MaCHL int not null,
	MaHLV int not null,
	MaVN int not null,
	BatDau timestamp,
	KetThuc timestamp,
	constraint pk_machl primary key (MaCHL),
	constraint fk_mahlv foreign key (MaHLV) references HUANLLUYENVIEN(MaHLV),
	constraint fk_mavn foreign key (MaVN) references VATNUOI(MaVN)
);


insert into CHUONG values (1,10);
insert into CHUONG values (1,11);
insert into CHUONG values (2,20);
insert into CHUONG values (2,21);

insert into LOAI_VATNUOI values (1,Rottweiler);
insert into LOAI_VATNUOI values (2,Doberman);
insert into LOAI_VATNUOI values (3,Berger);

insert into VATNUOI values (2,	1,	'Kanu',	10,	25);
insert into VATNUOI values (1,	2,	'Tyson',	11,	30.5
);
insert into VATNUOI values (3	,3,	'Bill'	,20	,26.5
);
insert into VATNUOI values (2,	1,	'Kanu',	10,	25);
insert into VATNUOI values (1,	4,	'Luck',	21,	32.2
);

insert into HUANLUYENVIEN values (1,	'Tran Van',	'Chung',	1985-08-12,	50000,	387497240924,	2025-05-10,	3,

);
