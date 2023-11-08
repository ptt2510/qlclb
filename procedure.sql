use qlclb;
-- Procedure tìm CLB hơn về hiệu số đối đầu giữa 2 CLB trong giải La Liga để xếp hạng trong trường hợp bằng điểm
DELIMITER $$
create procedure PROC_HSDD(
	in TenCLBA varchar(30),
    in TenCLBB varchar(30),
    in NamBD int)
begin
	declare CLBA varchar(10);
    declare CLBB varchar(10);
    declare GDAU varchar(10);
    declare TS_A1 varchar(3);
    declare TS_B1  varchar(3);
    declare TS_A2 varchar(3);
    declare TS_B2  varchar(3);
	select MaCLB into CLBA from CLB where TenCLB=TenCLBA;
    select MaCLB into CLBB from CLB where TenCLB=TenCLBB;
    select MaGD into GDAU from GIAIDAU where TenGD='La Liga' and year(NgBD)=NamBD;
    select TySo_A, TySo_B into TS_A1, TS_B1 
    from TRANDAU where CLB_A=CLBA and CLB_B=CLBB and MaGD=GDAU;
    select TySo_A, TySo_B into TS_B2, TS_A2 
    from TRANDAU where CLB_A=CLBB and CLB_B=CLBA and MaGD=GDAU;
    if TS_A1 + TS_A2 > TS_B1 + TS_B2 then
		select concat('CLB ', TenCLBA, ' hơn về hiệu số đối đầu') as 'Kết quả';
    elseif TS_A1 + TS_A2 < TS_B1 + TS_B2 then
		select concat('CLB ', TenCLBB, ' hơn về hiệu số đối đầu') as 'Kết quả';
    else 
		if TS_A2 > TS_B1 then
			select concat('CLB ', TenCLBA, ' hơn về hiệu số đối đầu') as 'Kết quả';
        elseif TS_A2 < TS_B1 then
			select concat('CLB ', TenCLBB, ' hơn về hiệu số đối đầu') as 'Kết quả';
		else
			select 'Cần phải xét các chỉ số fairplay hay trận đấu phụ để xác định được CLB' as 'Kết quả';
        end if;
    end if;
end$$
DELIMITER ;
-- Kiểm tra
-- --Khác hiệu số
set @TenCLBA='Real Madrid', @TenCLBB='Barcelona', @NamBD='2021';
call PROC_HSDD(@TenCLBA, @TenCLBB, @NamBD);
-- --Bằng hiệu số
insert into TRANDAU values ('lfp1718atma1010', '2017-10-10 18:00', '3-0', 'atma', 'reso', 'wame', 'lfp1718');
set @TenCLBA='Atlético Madrid', @TenCLBB='Real Sociedad', @NamBD='2017';
call PROC_HSDD(@TenCLBA, @TenCLBB, @NamBD);
-- khôi phục dữ liệu
delete from TRANDAU where MaTD = 'lfp1718atma1010'


-- Store Procedure đưa vào tên giải đấu, tên clb A, tên CLB B, Ngày thi đấu, cho ra đội hình ra sân của 2 đội 
DELIMITER $$
CREATE  PROCEDURE SP_DHRaSan(
    IN TGD varchar(30),
    IN TCLBA varchar(30),
    IN TCLBB varchar(30),
    IN NgayThiDau datetime
)
BEGIN
    DECLARE MGD varchar(10);
    DECLARE MTD varchar(20);
	declare CLBA varchar(10);
    declare CLBB varchar(10);
    declare error_message varchar(255);
    select MaCLB into CLBA from CLB where TenCLB=TCLBA;
    select MaCLB into CLBB from CLB where TenCLB=TCLBB;
	SELECT MaGD INTO MGD
    FROM GIAIDAU
    WHERE TenGD = TGD AND year(NgBD) <= year(NgayThiDau) and year(NgKT) >= year(NgayThiDau);
		
    SELECT MaTD INTO MTD
    FROM TRANDAU
    WHERE CLB_A = CLBA AND CLB_B = CLBB AND MaGD = MGD AND date(TGThiDau)=NgayThiDau;
		
		if MGD is NULL then 
			set error_message = CONCAT('Giải đấu ', TGD, ' không tồn tại');
			signal sqlstate '45000' set message_text = error_message;
		ELSEIF MTD is NULL then
            set error_message = CONCAT('Trận đấu không tồn tại');
			signal sqlstate '45000' set message_text = error_message;
		else 
			
	SELECT NHANVIEN.Ten 'Tên', CAUTHU.SoAo as 'Số áo', THAMGIATRANDAU.ChucVu as 'Vị trí'
    FROM NHANVIEN
    INNER JOIN CAUTHU ON NHANVIEN.MaNV = CAUTHU.MaNV
    INNER JOIN THAMGIATRANDAU ON NHANVIEN.MaNV = THAMGIATRANDAU.MaNV
    WHERE THAMGIATRANDAU.MaTD = MTD AND THAMGIATRANDAU.PhutVaoSan = 0 AND THAMGIATRANDAU.MaCLB = CLBA ;

    SELECT NHANVIEN.Ten 'Tên', CAUTHU.SoAo as 'Số áo', THAMGIATRANDAU.ChucVu as 'Vị trí'
    FROM NHANVIEN
    INNER JOIN CAUTHU ON NHANVIEN.MaNV = CAUTHU.MaNV
    INNER JOIN THAMGIATRANDAU ON NHANVIEN.MaNV = THAMGIATRANDAU.MaNV
    WHERE THAMGIATRANDAU.MaTD = MTD AND THAMGIATRANDAU.PhutVaoSan = 0 AND THAMGIATRANDAU.MaCLB = CLBB ;
	end if;
END$$
DELIMITER ;

-- Kiểm tra
call  SP_DHRaSan ('English Premier League','Arsenal','Chelsea','2021-08-22'); -- thành công
call  SP_DHRaSan ('English ','Arsenal','Chelsea','2021-08-22'); -- giải đấu không tồn tại
call  SP_DHRaSan ('English Premier League','Ars','Chelsea','2021-08-22'); -- trận đấu không tồn tại

-- Store Procedure đưa vào tên CLB, tên giải đấu, năm, cho ra các danh hiệu đạt được
DELIMITER $$
CREATE PROCEDURE SP_DH_DatDuoc(IN ten_clb VARCHAR(30), IN ten_gd VARCHAR(30), in nambd int)
BEGIN
		declare ma_gd varchar(10);
        declare error_message varchar(255);
		select GD.MaGD into ma_gd
		from GIAIDAU GD
		where GD.TenGD=ten_gd and year(NgBD)=nambd;
		if ma_gd is null THEN
			set error_message = CONCAT('Giải đấu ', ten_gd, ' không tồn tại');
			signal sqlstate '45000' set message_text = error_message;
		ELSEIF not exists (select * from CLB where TenCLB=ten_clb) then
			set error_message = CONCAT('CLB ', ten_clb, ' không tồn tại');
			signal sqlstate '45000' set message_text = error_message;
		else 
    SELECT DISTINCT(DH.TenDH) As 'Danh hiệu đạt được'
    FROM DANHHIEU DH
    INNER JOIN CTDH ON DH.MaDH = CTDH.MaDH
    INNER JOIN GIAIDAU GD ON CTDH.MaGD = GD.MaGD
		INNER JOIN CLB on CLB.MaCLB=CTDH.MaCLB
    WHERE CLB.TenCLB = ten_clb AND GD.MaGD = ma_gd;
		end if;
END$$
DELIMITER ;
-- Kiểm tra
CALL SP_DH_DatDuoc('Manchester City','English Premier League',2021); -- Thành công
CALL SP_DH_DatDuoc('MC','English Premier League',2021); -- CLB ko tồn tại
CALL SP_DH_DatDuoc('Manchester City','EPL',2021); -- GIAIDAU ko tồn tại


-- Store Procedure đưa vào tên CLB,cho ra tổng trị giá đội hình
DELIMITER $$
CREATE PROCEDURE SP_TonggiatriHD(IN TCLB varchar(30), OUT total FLOAT)
BEGIN
	declare countCLB int;
    declare error_message varchar(255);
	set countCLB=(select count(*) from CLB where TenCLB=TCLB);
	if countCLB > 0 THEN
		select SUM(GiaTri) into total 
		from HOPDONG,CLB 
		where TCLB=TenCLB AND CLB.MaCLB=HOPDONG.MaCLB;
	else 
		set error_message = CONCAT('CLB ', TCLB, ' không tồn tại');
		signal sqlstate '45000' set message_text = error_message;
	end if;
END$$
DELIMITER ;
-- Kiểm tra
call SP_TonggiatriHD ('Manchester City', @total);
SELECT @total as Tong_Gia_Tri_Hop_Dong;
