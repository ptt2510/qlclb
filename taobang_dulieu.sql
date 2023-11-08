create database qlclb;
use qlclb;

create table CLB(
	MaCLB varchar(10) primary key,
	TenCLB varchar(30) not null,
	DiaDiem varchar(30),
	NgayLap datetime,
	CTy varchar(50),
	NVDH varchar(10)
);

create table NHANVIEN(
	MaNV varchar(10) primary key,
	Ten varchar(30) not null,
	NgVaoLam date,
	NgKetThuc date,
	DiaChi varchar(100),
	SDT varchar(10),
	NgQL varchar(10),
	CLB varchar(10),
	foreign key (NgQL) references NHANVIEN(MaNV),
	foreign key (CLB) references CLB(MaCLB)
);
alter table NHANVIEN add constraint ck_NV check (NgVaoLam<NgKetThuc);

alter table CLB
add foreign key (NVDH) references NHANVIEN(MaNV);

create table CAUTHU(
	MaNV varchar(10) primary key,
	SoAo int not null,
	DoiTruong boolean not null,
	ViTriSoTruong varchar(30),
	foreign key (MaNV) references NHANVIEN(MaNV)
);

create table HLV(
	MaNV varchar(10) primary key,
	Loai varchar(30) not null,
	KinhNghiem int, -- Số năm
	foreign key (MaNV) references NHANVIEN(MaNV)
);

create table HOPDONG(
	MaCLB varchar(10),
	MaNV varchar(10),
	VaiTro varchar(30),
	NgBD date not null,
	NgKT date not null,
	GiaTri float, -- triệu euro
	primary key (MaCLB, MaNV),
	foreign key (MaCLB) references CLB(MaCLB),
	foreign key (MaNV) references NHANVIEN(MaNV)
);
alter table HOPDONG add constraint ck_HD check (NgBD<NgKT);

create table SAN(
	MaSan varchar(10) primary key,
	TenSan varchar(30) not null,
	DiaChi varchar(30),
	SucChua int,
	CLBQLy varchar(10),
	foreign key (CLBQLy) references CLB(MaCLB)
);

create table GIAIDAU(
	MaGD varchar(10) primary key,
	TenGD varchar(30) not null,
	NgBD date,
	NgKT date,
	DiaDiem varchar(30),
	CLBVoDich varchar(10),
	foreign key (CLBVoDich) references CLB(MaCLB)
);
alter table GIAIDAU add constraint ck_GD check (NgBD<NgKT);

create table TRANDAU(
	MaTD varchar(20),
	TGThiDau datetime,
	TySo_A int not null,
	TySo_B int not null,
	CLB_A varchar(10) not null,
	CLB_B varchar(10) not null,
	MaSan varchar(10),
	MaGD varchar(10),
	primary key (MaTD),
	foreign key (CLB_A) references CLB(MaCLB),
	foreign key (CLB_B) references CLB(MaCLB),
	foreign key (MaSan) references SAN(MaSan),
	foreign key (MaGD) references GIAIDAU(MaGD)
);

create table THAMGIATRANDAU(
	MaTD varchar(20),
	MaCLB varchar(10),
	MaNV varchar(10),
	PhutVaoSan int not null,
	PhutTraSan int not null,
	PhutGhiBan int,
	ChucVu varchar(30),
	MVP boolean,
	primary key (MaTD, MaCLB, MaNV,PhutGhiBan),
	foreign key (MaTD) references TRANDAU(MaTD),
	foreign key (MaCLB) references CLB(MaCLB),
	foreign key (MaNV) references NHANVIEN(MaNV)
);

create table DANHHIEU(
	MaDH varchar(10) primary key,
	TenDH varchar(30) not null
);

create table CTDH(
	MaDH varchar(10),
	MaGD varchar(10),
	MaCLB varchar(10),
	MaNV varchar(10),
	NgTraoTang date not null,
	primary key (MaDH,MaGD,MaCLB,MaNV),
	foreign key (MaDH) references DANHHIEU(MaDH),
	foreign key (MaGD) references GIAIDAU(MaGD),
	foreign key (MaCLB) references CLB(MaCLB),
	foreign key (MaNV) references NHANVIEN(MaNV)
);



	
insert into CLB values
	('rema', 'Real Madrid', 'Madrid, Tây Ban Nha', '1902-03-06','Real Madrid Club de Fútbol', NULL),
	('barc','Barcelona', 'Barcelona, Tây Ban Nha', '1899-11-29','Futbol Club Barcelona',NULL),
	('atma','Atlético Madrid', 'Madrid, Tây Ban Nha', '1903-04-26','Club Atlético de Madrid', NULL),
	('sevi','Sevilla', 'Sevilla, Tây Ban Nha', '1890-01-25','Sevilla Fútbol Club', NULL),
	('rebe','Real Betis', 'Sevilla, Tây Ban Nha', '1907-09-12','Real Betis Balompié', NULL),
	('atbi','Athletic Bilbao', 'Bilbao, Tây Ban Nha', '1898-09-23','Athletic Club', NULL),
	('reso','Real Sociedad', 'San Sebastián, Tây Ban Nha', '1909-09-07', 'Real Sociedad de Fútbol', NULL),
	('vale','Valencia', 'Valencia, Tây Ban Nha', '1919-03-18','Valencia Club de Fútbol', NULL),
	('MCI','Manchester City', 'Anh', '1894-04-16','City Football Group Limited', NULL),
	('LIV','Liverpool', 'Anh', '1892-06-03','Tập đoàn Thể thao Fenway', NULL),
	('VIL','Villarreal', 'Tây Ban Nha', '1923-03-10','Villarreal Club de Fútbol', NULL),
	('psg','Paris Saint-Germain','Paris, Pháp', '1970-08-12','Paris Saint-Germain Football Club',NULL),
	('CHE','Chelsea','London, United Kingdom','1905-03-10','Chelsea Football Club Limited',NULL),
	('TOT','Tottenham Hotspur','London, United Kingdom','1882-09-05','Tottenham Hotspur Football Club Limited',NULL),
	('ARS','Arsenal','London, United Kingdom','1886-02-16','The Arsenal Football Club plc',NULL),
	('MUN','Manchester United','Manchester, United Kingdom','1878-03-06','Manchester United Football Club Limited',NULL);

insert into NHANVIEN values
	('ctra','Richard Arnold', '2022-01-06', NULL, 'Manchester, United Kingdom', '46168989', NULL, 'MUN'),
	('ctrm','Roman Abramovich','2003-07-01','2022-05-07','London, United Kingdom','69064619',NULL,'CHE'),
	('ctsk','Stan Kroenke', '2018-08-07', NULL, 'London, United Kingdom', '23516420', NULL, 'ARS'),
	('ctlv','Daniel Levy', '2001-02-22', NULL, 'London, United Kingdom', '61236480', NULL, 'TOT'),
	('ctjola','Joan Laporta', '2021-03-17',NULL,'25 Main Street, Barcelona, Tây Ban Nha','12645678',NULL,'barc'),
	('ctfp','Florentino Perez', '2000-01-01',NULL,'Marid, Tây Ban Nha','13145678',NULL,'rema'),
	('cttw','Tom Werner', '2012-12-01',NULL,'Liverpool, Anh','11111678',NULL,'LIV'),
	('ctkam','Khaldoon Al Mubarak', '2013-01-01',NULL,'Manchester City, Anh','11661666',NULL,'MCI'),
	('ctfra','Fernando Roig Alfonso', '2000-12-01',NULL,'Tây Ban Nha','11555252',NULL,'VIL'),
    ('hlvole','Ole Solskjaer', '2019-03-29', '2021-11-21', 'Manchester, United Kingdom', '78964881', 'ctra', 'MUN'),
    ('hlvtc','Thomas Tuchel','2021-01-26','2022-09-07','London, United Kingdom','23576320','ctrm','CHE'),
    ('hlvata','Mikel Arteta', '2019-12-20', NULL, 'London, United Kingdom', '46428989', 'ctsk', 'ARS'),
    ('hlvnuno','Nuno Espirito Santo', '2021-06-30', '2021-11-01', 'London, United Kingdom', '64767894', 'ctlv', 'TOT'),
	('hlvcaan','Carlo Ancelotti', '2021-06-01',NULL, '15 Lombardy Lane, Madrid, Tây Ban Nha', '23456789','ctfp','rema'),
	('hlvdisi','Diego Simeone', '2011-12-23',NULL, '10 Madrid Avenue, Madrid, Tây Ban Nha', '34567890',NULL,'atma'),
	('hlvjk','Jürgen Klopp', '2015-10-08',NULL,'Liverpool, Anh','14611678','cttw','LIV'),
	('hlvp','Pep Guardiola', '2016-01-02',NULL,'Manchester City, Anh','11661556','ctkam','MCI'),
	('hlvqs','Quique Setién', '2022-10-25',NULL,'Tây Ban Nha','11525252','ctfra','VIL'),
	('kabe9','Karim Benzema', '2009-07-01',NULL, '20 Bernabeu Street, Madrid, Tây Ban Nha', '45678901','hlvcaan','rema'),
	('lm10','Luka Modrić', '2012-08-27',NULL, ' khu La Moraleja, Madrid, Tây Ban Nha', '85678901','hlvcaan','rema'),
	('tk8','Toni Kroos', '2014-07-17',NULL, ' La Finca, Madrid, Tây Ban Nha', '891831','hlvcaan','rema'),
	('ms11','Mohamed Salah', '2017-06-23',NULL, ' Royal Albert Dock Liverpool, Anh', '8918121','hlvjk','LIV'),
	('al1','Alisson', '2018-07-20',NULL, ' Royal Albert Dock Liverpool, Anh', '8916121','hlvjk','LIV'),
	('gs9','Gabriel Jesus', '2016-12-02',NULL,'Manchester City, Anh','11661456','hlvp','MCI'),
	('kdb17','Kevin De Bruyne', '2015-08-30',NULL,'Manchester City, Anh','11261456','hlvp','MCI'),
	('gmb7','Gerard Moreno Balagueró', '2010-11-02',NULL,'Villareal, Tây Ban Nha','17661456','hlvqs','VIL'),
	('gr13','Gerónimo Rulli', '2010-11-02',NULL,'Villareal, Tây Ban Nha','17669456','hlvqs','VIL'),
	('vnju20','Vinícius Júnior', '2018-07-12',NULL, '40 Castellana Boulevard, Madrid, Tây Ban Nha', '56789012','hlvcaan','rema'),
	('thco1','Thibaut Courtois', '2018-08-09',NULL, '30 Gran Via Street, Madrid, Tây Ban Nha', '67890123','hlvcaan','rema'),
	('lime30','Lionel Messi', '2021-08-05',NULL, '73 Saint-Germain, Paris, Pháp', '78901234',NULL, 'psg'),
	('frjo21','Frenkie de Jong', '2019-07-01',NULL, '40 Les Corts Road, Barcelona, Tây Ban Nha', '89012345',NULL,'barc'),
	('koke6','Koke', '2008-09-01',NULL, '50 Sevilla Street, Madrid, Tây Ban Nha', '90123456','hlvdisi','atma'),
	('jaob13','Jan Oblak', '2014-07-16',NULL, '10 Madrid Avenue, Madrid, Tây Ban Nha', '01234567','hlvdisi','atma'),
	('ivra10','Ivan Rakitić', '2014-07-01',NULL, '30 Rambla Street, Seville, Tây Ban Nha', '12345678',NULL,'sevi'),
	('juan7','Juanmi', '2021-08-31',NULL, '25 Real Street, Seville, Tây Ban Nha', '23456789',NULL,'rebe'),
	('dasi21','David Silva', '2020-08-17',NULL, '15 San Sebastian Avenue, San Sebastian, Tây Ban Nha', '34567890',NULL,'reso'),
	('unsi13','Unai Simón', '2016-07-01',NULL, '5 Athletic Way, Bilbao, Tây Ban Nha', '45678901',NULL,'atbi'),
	('roma9','Roger Martí', '2013-07-01',NULL, '20 Valencia Street, Valencia, Tây Ban Nha', '56789012',NULL,'vale'),
	('edca7','Edinson Cavani', '2020-10-05',NULL, '10 Levante Boulevard, Valencia, Tây Ban Nha', '67890123',NULL,'vale'),
	('rf10','Marcus Rashford', '2016-02-25', NULL, 'Manchester, United Kingdom', '52987653', 'hlvole', 'MUN'),
    ('cr07','Cristiano Ronaldo', '2021-08-27', '2022-11-23', 'Manchester, United Kingdom', '06126456', 'hlvole', 'MUN'),
	('vd04','Virgil van Dijk', '2017-12-27', NULL, 'Liverpool, United Kingdom', '69012376', 'hlvjk', 'LIV'),
	('rf09','Roberto Firmino', '2015-07-06', NULL, 'Liverpool, United Kingdom', '20123456', 'hlvjk', 'LIV'),
	('em31','Ederson Moraes', '2017-07-01', NULL, 'Manchester, United Kingdom', '52987654', 'hlvp', 'MCI'),
	('pp47','Phil Foden', '2017-07-01', NULL, 'Manchester, United Kingdom', '34126289','hlvp', 'MCI'),
	('kepa01','Kepa Arrizabalaga', '2018-08-08', NULL, 'London, United Kingdom', '55512345', 'hlvtc', 'CHE'),
	('kai29','Kai Havertz', '2020-09-04', NULL, 'London, United Kingdom', '34123489','hlvtc', 'CHE'),
	('auba14','Pierre-Emerick Aubameyang', '2018-01-31', '2022-04-02', 'London, United Kingdom', '06123456', 'hlvata', 'ARS'),
	('gm35','Gabriel Martinelli', '2019-07-02', NULL, 'London, United Kingdom', '12157890', 'hlvata', 'ARS'),
	('son07','Heung-Min Son', '2015-08-28', NULL, 'London, United Kingdom', '34121612', 'hlvnuno', 'TOT'),
	('kane09','Harry Kane', '2009-07-01', NULL, 'London, United Kingdom', '20121778','hlvnuno', 'TOT');
	

update CLB set NVDH='ctjola' where MaCLB='barc';
update CLB set NVDH='ctra' where MaCLB='MUN';
update CLB set NVDH='ctrm' where MaCLB='CHE';
update CLB set NVDH='ctsk' where MaCLB='ARS';
update CLB set NVDH='ctlv' where MaCLB='TOT';
update CLB set NVDH='ctfp' where MaCLB='rema';
update CLB set NVDH='cttw' where MaCLB='LIV';
update CLB set NVDH='ctkam' where MaCLB='MCI';
update CLB set NVDH='ctfra' where MaCLB='VIL';


insert into CAUTHU values
	('kabe9', 9, 1,'Tiền đạo cắm'),
	('vnju20', 20, 0, 'Tiền đạo trái'),
	('thco1', 1, 0, 'Thủ môn'),
	('lime30', 30, 0, 'Tiền đạo cánh phải'),
	('frjo21', 21, 0, 'Tiền vệ trung tâm'),
	('koke6', 6, 1, 'Tiền vệ cánh phải'),
	('jaob13', 13, 0, 'Thủ môn'),
	('ivra10', 10, 0, 'Tiền vệ trung tâm'),
	('juan7', 7, 0, 'Tiền đạo cắm'),
	('dasi21', 21, 0, 'Tiền vệ trung tâm'),
	('unsi13', 13, 0, 'Thủ môn'),
	('roma9', 9, 1, 'Tiền đạo cắm'),
	('lm10', 10, 0, 'Tiền vệ phải'),
	('tk8', 8, 0, 'Tiền vệ trái'),
	('ms11', 11, 0, 'Tiền đạo phải'),
	('al1', 1, 1, 'Thủ môn'),
	('gs9', 9, 0, 'Tiền đạo trung tâm'),
	('kdb17', 17, 0, 'Tiền vệ phải'),
	('gmb7', 7, 0, 'Tiền đạo trái'),
	('gr13', 13, 1, 'Thủ môn'),
	('edca7', 7, 0, 'Tiền đạo cắm'),
	('rf10',10,0, 'Tiền đạo cánh trái'),
	('cr07',7,1, 'Tiền đạo cắm'),
	('vd04',4,0, 'Trung vệ'),
	('rf09',9,0, 'Tiền đạo cắm'),
	('em31',31,0, 'Thủ môn'),
	('pp47',47,0, 'Tiền đạo cánh trái'),
	('kepa01',1,0, 'Thủ môn'),
	('kai29',29,0, 'Tiền đạo cánh trái'),
	('auba14',14,1, 'Tiền đạo cắm'),
	('gm35',35,0, 'Tiền đạo cánh trái'),
	('son07',7,0, 'Tiền đạo cắm'),
	('kane09',9,1, 'Tiền đạo cắm');
    
insert into HLV values
	('hlvcaan','HLV chính', 30),
	('hlvjk','HLV chính', 31),
	('hlvp','HLV chính', 22),
	('hlvqs','HLV chính', 33),
	('hlvdisi','HLV chính', 10),
    ('hlvole','HLV chính',5),
	('hlvata','HLV chính',5),
	('hlvtc','HLV chính',5),
	('hlvnuno','HLV chính',5);

insert into SAN values
	('sabe','Santiago Bernabéu', 'Madrid, Tây Ban Nha','81044', 'rema'),
	('cano','Camp Nou', 'Barcelona, Tây Ban Nha','99354','barc'),
	('wame','Wanda Metropolitano', 'Madrid, Tây Ban Nha', '68000','atma'),
	('rasp','Ramón Sánchez Pizjuán', 'Sevilla, Tây Ban Nha', '43700','sevi'),
	('bevi','Benito Villamarin', 'Sevilla, Tây Ban Nha','60720','rebe'),
	('sama','San Mamés', 'Bilbao, Tây Ban Nha','53289','atbi'),
	('anoe','Anoeta', 'San Sebastián, Tây Ban Nha','32000','reso'),
	('EM','El Madrigal', 'Tây Ban Nha','23500','VIL'),
	('AF','Anfield', 'Anh','54000','LIV'),
	('ES','Etihad Stadium', 'Anh','53400','MCI'),
	('SDF','Stade de France', 'Pháp','80000',NULL),
	('mest','Mestalla', 'Valencia, Tây Ban Nha','55000','vale'),
	('OTF','Old Trafford','Manchester, Anh',74310,'MUN'),
	('THS','Tottenham Hotspur Stadium','London, Anh',62850,'TOT'),
	('EMS','Emirates Stadium','London, Anh',60704,'ARS'),
	('SB','Stamford Bridge','London, Anh',40341,'CHE');

insert into GIAIDAU values
	('EPL2122','English Premier League','2021-08-13','2022-05-22','United Kingdom','MCI'),
	('lfp2122', 'La Liga', '2021-08-14', '2022-05-23', 'Tây Ban Nha','rema'),
	('lfp1718', 'La Liga', '2017-08-19', '2018-05-21', 'Tây Ban Nha','barc'),
	('c12122', 'Champions League', '2021-06-22', '2022-05-29', 'Pháp','rema');

insert into TRANDAU values                  
	('lfp2122cano2410','2021-10-24 21:00', 1, 2,'barc','rema','cano','lfp2122'),
	('lfp2122sabe2103','2022-03-21 22:00', 0, 4, 'rema', 'barc', 'sabe','lfp2122'),
	('lfp2122rasp1804','2022-04-18 22:00', 2, 3, 'sevi', 'rema', 'rasp','lfp2122'),
	('lfp1718bevi2201','2018-01-22 18:00', 0, 5, 'rebe', 'barc', 'bevi','lfp1718'),
	('ckc12122','2022-05-29 18:00', 0, 1, 'LIV', 'rema', 'sdf','c12122'),
	('bkc12122SB0505','2022-05-05 18:00', 3, 1, 'rema', 'MCI', 'sabe','c12122'),
	('bkc12122ES2704','2022-04-27 18:00', 4, 3, 'MCI', 'rema', 'ES','c12122'),
	('bkc12122AF2804','2022-04-28 18:00', 0, 0, 'LIV', 'VIL', 'AF','c12122'),
	('bkc12122EM0405','2022-05-04 18:00', 3, 2, 'LIV', 'VIL', 'EM','c12122'),
	('lfp1718anoe2004','2018-04-20 18:00', 3, 0, 'reso', 'atma','anoe','lfp1718'),
	('304EPL2122','2022-04-10 22:30', 2, 2, 'MCI', 'LIV', 'ES','EPL2122'),
	('90EPL2122','2021-10-24 22:30', 0, 5, 'MUN', 'LIV', 'OTF','EPL2122'),
	('80EPL2122','2021-08-22 22:30', 0, 2, 'ARS', 'CHE', 'EMS','EPL2122'),
	('02EPL2122','2021-08-15 22:30', 1, 0, 'TOT', 'MCI', 'THS','EPL2122');

insert into HOPDONG values
	('barc', 'ctjola', 'Chủ tịch', '2021-03-17','2026-06-30',15),
	('rema', 'hlvcaan', 'HLV', '2021-06-01', '2024-06-30',6),
	('atma', 'hlvdisi', 'HLV', '2011-12-23', '2024-06-30',25),
	('rema', 'kabe9', 'Cầu thủ', '2009-07-01', '2023-06-30', 60),
	('rema', 'vnju20', 'Cầu thủ', '2018-07-12', '2025-06-30', 55),
	('rema', 'thco1', 'Cầu thủ', '2018-08-09', '2026-06-30', 35),
	('psg', 'lime30', 'Cầu thủ', '2021-08-05', '2023-06-30', 35),
	('barc', 'frjo21', 'Cầu thủ', '2019-07-01', '2026-06-30', 75),
	('atma', 'koke6', 'Cầu thủ', '2008-09-01', '2024-06-30', 80),
	('atma', 'jaob13', 'Cầu thủ', '2016-07-01', '2024-06-30', 30),
	('sevi', 'ivra10', 'Cầu thủ', '2014-07-01', '2021-06-30', 10),
	('rebe', 'juan7', 'Cầu thủ', '2021-08-31', '2023-06-30', 20),
	('reso', 'dasi21', 'Cầu thủ', '2020-08-17', '2022-06-30', 12),
	('atbi', 'unsi13', 'Cầu thủ', '2016-07-01', '2024-06-30', 30),
	('vale', 'roma9', 'Cầu thủ', '2013-07-01', '2023-06-30', 20),
	('rema', 'lm10', 'Cầu thủ', '2012-08-20', '2023-06-30', 30),
	('rema', 'tk8', 'Cầu thủ', '2014-07-10', '2023-09-30', 20),
	('LIV', 'hlvjk', 'HLV', '2015-10-01', '2023-05-30', 15),
	('LIV', 'ms11', 'Cầu thủ', '2017-06-20', '2024-05-30', 75),
	('LIV', 'al1', 'Cầu thủ', '2018-07-02', '2024-05-30', 55),
	('MCI', 'hlvp', 'HLV', '2015-12-01', '2025-05-30', 18),
	('MCI', 'gs9', 'Cầu thủ', '2016-10-02', '2024-09-30', 55),
	('MCI', 'kdb17', 'Cầu thủ', '2015-07-02', '2024-09-30', 52),
	('VIL', 'hlvqs', 'HLV', '2022-09-20', '2023-10-30', 10),
	('VIL', 'gmb7', 'Cầu thủ', '2010-10-02', '2024-09-30', 8),
	('VIL', 'gr13', 'Cầu thủ', '2010-09-13', '2024-09-30', 5),
	('vale', 'edca7', 'Cầu thủ', '2020-10-05', '2022-06-30', 8),
    ('MUN','rf10','Cầu thủ','2016-02-25','2023-06-30',0),
	('MUN','cr07','Cầu thủ','2021-08-27','2023-06-30',15),
	('MUN','hlvole','HLV','2019-03-28','2024-06-30',0),
	('MUN','ctra','Chủ tịch','2022-01-06','2026-06-30',0),	
	('LIV','vd04','Cầu thủ','2017-12-27','2023-06-30',84.65),	
	('LIV','rf09','Cầu thủ','2015-07-06','2023-06-30',41),	
	('MCI','em31','Cầu thủ','2017-07-01','2025-06-30',40),	
	('MCI','pp47','Cầu thủ','2017-07-01','2024-06-30',0),	
	('CHE','kepa01','Cầu thủ','2018-08-08','2025-06-30',80),	
	('CHE','kai29','Cầu thủ','2020-09-04','2025-06-30',80),
	('CHE','hlvtc','HLV','2021-01-26','2024-06-30',0),
	('CHE','ctrm','Chủ tịch','2003-07-01','2024-06-30',0),
	('ARS','auba14','Cầu thủ','2018-01-31','2023-06-30',63.75),	
	('ARS','gm35','Cầu thủ','2019-07-02','2024-06-30',7),
	('ARS','hlvata','HLV','2019-12-20','2023-06-30',0),
	('ARS','ctsk','Chủ tịch','2018-08-07','2026-06-30',0),
	('TOT','son07','Cầu thủ','2015-08-28','2023-06-30',30),
	('TOT','kane09','Cầu thủ','2009-07-01','2024-06-30',0),	
	('TOT','hlvnuno','HLV','2021-06-30','2023-06-30',0),
	('TOT','ctlv','Chủ tịch','2001-02-22','2028-06-30',0);
	
insert into THAMGIATRANDAU values
	('lfp2122cano2410','barc', 'frjo21', 0, 77, -1,'Tiền vệ cánh trái',0),
	('lfp2122cano2410','rema','kabe9', 0, 94, -1,'Tiền đạo cắm',0),
	('lfp2122cano2410','rema','tk8', 0, 94, -1,'Tiền vệ cánh trái',0),
	('lfp2122cano2410','rema','lm10', 0, 94, -1,'Tiền vệ cánh phải',0),
	('lfp2122cano2410','rema','vnju20', 0, 87, -1,'Tiền đạo cánh trái',0),
	('lfp2122cano2410','rema','thco1', 0, 94, -1,'Thủ môn',0),
	('lfp2122cano2410','rema', 'hlvcaan', -1, -1, -1,'HLV',0),
	('lfp1718bevi2201','barc', 'lime30', 0, 93, 64,'Tiền đạo cánh phải',1),
	('lfp1718bevi2201','barc', 'lime30', 0, 93, 80,'Tiền đạo cánh phải',1),
	('lfp1718bevi2201','barc', 'ivra10', 0, 93, 59,'Tiền vệ trung tâm',0),
	('lfp2122sabe2103','barc', 'frjo21', 0, 71, -1,'Tiền vệ trung tâm',0),
	('lfp2122sabe2103','rema','tk8', 0, 46, -1,'Tiền vệ trái',0),
	('lfp2122sabe2103','rema','lm10', 0, 94, -1,'Tiền đạo trái',0),
	('lfp2122sabe2103','rema','vnju20', 0, 94, -1,'Tiền đạo phải',0),
	('lfp2122sabe2103','rema','thco1', 0, 94, -1,'Thủ môn',0),
	('lfp2122sabe2103','rema', 'hlvcaan', -1, -1, -1,'HLV',0),
	('lfp1718anoe2004','reso', 'juan7', 72, 94, 80,'Tiền đạo cắm',1),
	('lfp1718anoe2004','reso', 'juan7', 72, 94, 92,'Tiền đạo cắm',1),
	('lfp1718anoe2004','atma', 'koke6', 0, 94, -1,'Tiền vệ cánh phải',1),
	('lfp1718anoe2004','atma', 'jaob13', 0, 94, -1,'Thủ môn',0),
	('lfp1718anoe2004','atma', 'hlvdisi', -1, -1, -1,'HLV',0),
	('lfp2122rasp1804','rema','kabe9', 0, 95, 92,'Tiền đạo cắm',1),
	('lfp2122rasp1804','rema','tk8', 0, 100, -1,'Tiền vệ trung tâm',0),
	('lfp2122rasp1804','rema','lm10', 0, 81, -1,'Tiền vệ cánh phải',0),
	('lfp2122rasp1804','rema','vnju20', 0, 100, -1,'Tiền đạo cánh trái',0),
	('lfp2122rasp1804','rema','thco1', 0, 100, -1,'Thủ môn',0),
	('lfp2122rasp1804','rema', 'hlvcaan', -1, -1, -1,'HLV',0),
	('lfp2122rasp1804','sevi','ivra10', 0, 100, 21,'Tiền vệ trung tâm',0),
	('ckc12122','rema','kabe9', 0, 95,-1,'Tiền đạo cắm',0),
	('ckc12122','rema','vnju20', 0, 93,59,'Tiền đạo trái',0),
	('ckc12122','rema','thco1', 0, 95,-1,'Thủ môn',1),
	('ckc12122','rema','lm10', 0, 95,-1,'Tiền vệ phải',0),
	('ckc12122','rema','tk8', 0, 95,-1,'Tiền vệ trái',0),
	('ckc12122','rema','hlvcaan', -1, -1,-1,'HLV',0),
	('ckc12122','LIV','hlvjk', -1, -1,-1,'HLV',0),
	('ckc12122','LIV','ms11', 0, 95,-1,'Tiền đạo trái',0),
	('ckc12122','LIV','al1', 0, 95,-1,'Thủ môn',0),
	('bkc12122SB0505','rema','kabe9', 0, 104,95,'Tiền đạo cắm',1),
	('bkc12122SB0505','rema','kabe9', 0, 104,90,'Tiền đạo cắm',1),
	('bkc12122SB0505','rema','kabe9', 0, 104,91,'Tiền đạo cắm',1),
	('bkc12122SB0505','rema','vnju20', 0, 130,-1,'Tiền đạo phải',0),
	('bkc12122SB0505','rema','thco1', 0, 130,-1,'Thủ môn',1),
	('bkc12122SB0505','rema','lm10', 0, 75,-1,'Tiền vệ trung tâm',0),
	('bkc12122SB0505','rema','tk8', 0, 68,-1,'Tiền vệ trái',0),
	('bkc12122SB0505','rema','hlvcaan', -1, -1,-1,'HLV',0),
	('bkc12122SB0505','MCI','hlvp', -1, -1,-1,'HLV',0),
	('bkc12122SB0505','MCI','gs9', 0, 78,72,'Tiền đạo trung tâm',0),
	('bkc12122SB0505','MCI','kdb17', 0, 72,-1,'Tiền vệ trái',0),
	('bkc12122ES2704','rema','kabe9', 0, 95,33,'Tiền đạo cắm',0),
	('bkc12122ES2704','rema','kabe9', 0, 95,82,'Tiền đạo cắm',0),
	('bkc12122ES2704','rema','vnju20', 0, 95,55,'Tiền đạo trái',0), 
	('bkc12122ES2704','rema','thco1', 0, 95,-1,'Thủ môn',1),
	('bkc12122ES2704','rema','lm10', 0, 79,-1,'Tiền vệ trái',0),
	('bkc12122ES2704','rema','tk8', 0, 95,-1,'Tiền vệ trung tâm',0),
	('bkc12122ES2704','rema','hlvcaan', -1, -1,-1,'HLV',0),
	('bkc12122ES2704','MCI','hlvp', -1, -1,-1,'HLV',0),
	('bkc12122ES2704','MCI','gs9', 0, 95,11,'Tiền đạo trung tâm',1),
	('bkc12122ES2704','MCI','gs9', 0, 95,53,'Tiền đạo trung tâm',1),
	('bkc12122ES2704','MCI','gs9', 0, 95,74,'Tiền đạo trung tâm',1),
	('bkc12122ES2704','MCI','kdb17', 0, 95,2,'Tiền vệ phải',0),
	('bkc12122EM0405','VIL','gmb7', 0, 95,3,'Tiền đạo trái',0),
	('bkc12122EM0405','VIL','gmb7', 0, 95,41,'Tiền đạo trái',0),
	('bkc12122EM0405','VIL','gr13', 0, 95,-1,'Thủ môn',0),
	('bkc12122EM0405','VIL','hlvqs', -1, -1,-1,'HLV',0),
	('bkc12122EM0405','LIV','hlvjk', -1, -1,-1,'HLV',0),
	('bkc12122EM0405','LIV','ms11', 0, 95,62,'Tiền đạo phải',1),
	('bkc12122EM0405','LIV','ms11', 0, 95,67,'Tiền đạo phải',1),
	('bkc12122EM0405','LIV','ms11', 0, 95,74,'Tiền đạo phải',1),
	('bkc12122EM0405','LIV','al1', 0, 95,-1,'Thủ môn',0),
	('bkc12122AF2804','VIL','gmb7', 0, 95,-1,'Tiền đạo trái',0),
	('bkc12122AF2804','VIL','gr13', 0, 95,-1,'Thủ môn',0),
	('bkc12122AF2804','VIL','hlvqs', -1, -1,-1,'HLV',0),
	('bkc12122AF2804','LIV','hlvjk', -1, -1,-1,'HLV',0),
	('bkc12122AF2804','LIV','ms11', 0, 95,-1,'Tiền đạo phải',0),
	('bkc12122AF2804','LIV','al1', 0, 95,-1,'Thủ môn',1),
	('304EPL2122','MCI','em31',0,91,-1,'Thủ môn',0),		
	('304EPL2122','MCI','pp47',0,91,69,'Tiền đạo cánh trái',0),
	('304EPL2122','MCI','hlvp',-1,-1,-1,'HLV',0),		
	('304EPL2122','LIV','hlvjk',-1,-1,-1,'HLV',0),
	('304EPL2122','LIV','vd04',0,91,-1,'Trung vệ',0),	
	('304EPL2122','LIV','rf09',68,91,79,'Tiền đạo cắm',0),		
	('90EPL2122','LIV','vd04',0,90,-1,'Trung vệ',0),	
	('90EPL2122','LIV','rf09',0,76,5,'Tiền đạo cắm',0),		
	('90EPL2122','LIV','hlvjk',-1,-1,-1,'HLV',0),		
	('90EPL2122','MUN','rf10',0,90,-1,'Tiền đạo cánh trái',0),		
	('90EPL2122','MUN','cr07',0,90,-1,'Tiền đạo cắm',0),		
	('90EPL2122','MUN','hlvole',-1,-1,-1,'HLV',0),	
	('80EPL2122','CHE','kai29',0,90,15,'Tiền đạo cánh trái',1),		
	('80EPL2122','CHE','kepa01',0,90,-1,'Thủ môn',0),		
	('80EPL2122','CHE','hlvtc',-1,-1,-1,'HLV',0),		
	('80EPL2122','ARS','auba14',0,90,-1,'Tiền đạo cắm',0),		
	('80EPL2122','ARS','gm35',0,90,-1,'Tiền đạo cánh trái',0),		
	('80EPL2122','ARS','hlvata',-1,-1,-1,'HLV',0),
	('02EPL2122','TOT','kane09',0,96,0,'Tiền đạo cắm',0),		
	('02EPL2122','TOT','son07',0,96,55,'Tiền đạo cắm',1),
	('02EPL2122','TOT','hlvnuno',-1,-1,-1,'HLV',0),		
	('02EPL2122','MCI','em31',0,96,-1,'Thủ môn',0),
	('02EPL2122','MCI','pp47',0,96,-1,'Tiền đạo cánh trái',0),		
	('02EPL2122','MCI','hlvp',-1,-1,-1,'HLV',0);
    
insert into DANHHIEU values
	('001','CLB vô địch'),
	('002','CLB á quân'),
	('003','Cầu thủ xuất sắc nhất'),
	('004','Cầu thủ ghi nhiều bàn nhất'),
	('005','Thủ môn ít thủng lưới nhất'),
	('006','Cầu thủ trẻ xuất sắc nhất'),
	('007','HLV xuất sắc nhất');
	
insert into CTDH values
	('001','lfp1718','barc','lime30','2018-05-20'),
	('001','lfp1718','barc','frjo21','2018-05-20'),
	('002','lfp1718','atma','koke6','2018-05-20'),
	('002','lfp1718','atma','jaob13','2018-05-20'),
	('003','lfp1718','barc','lime30','2018-11-12'),
	('004','lfp1718','barc','lime30','2018-11-12'),
	('005','lfp1718','atma','jaob13','2018-11-12'),
	('001','lfp2122','rema','kabe9','2022-05-22'),
	('001','lfp2122','rema','vnju20','2022-05-22'),
	('001','lfp2122','rema','thco1','2022-05-22'),
	('002','lfp2122','barc','frjo21','2022-05-22'),
	('003','lfp2122','rema','kabe9','2022-11-21'),
	('004','lfp2122','rema','kabe9','2022-11-21'), 
    ('007','lfp2122','rema','hlvcaan','2022-11-21'),
	('001','c12122','rema','kabe9','2022-05-29'),
	('003','c12122','rema','kabe9','2022-05-29'),
	('007','c12122','rema','hlvcaan','2022-05-29'),
	('001','c12122','rema','hlvcaan','2022-05-29'),
	('001','c12122','rema','lm10','2022-05-29'),
	('001','c12122','rema','tk8','2022-05-29'),
	('002','c12122','LIV','ms11','2022-05-29'),
	('002','c12122','LIV','al1','2022-05-29'),
	('005','lfp2122','atma','jaob13','2018-11-21'),
	('001','EPL2122','MCI','em31','2022-05-22'),
	('001','EPL2122','MCI','pp47','2022-05-22'),
	('002','EPL2122','MUN','rf10','2022-05-22'),
	('002','EPL2122','MUN','cr07','2022-05-22'),
	('005','EPL2122','MCI','em31','2022-05-22'),
	('006','EPL2122','MCI','pp47','2022-05-22'),
	('001','EPL2122','MCI','hlvp','2022-05-22'),
	('002','EPL2122','MUN','hlvole','2022-05-22'),
	('007','EPL2122','LIV','hlvjk','2022-05-22');

