-- Tạo thêm thuộc tính chỉ số lương vào nhân viên. Dựa vào thời gian trong hợp đồng, cập nhật chỉ số lương là 1.2 
-- dối với nhân viên làm việc tính đến hiện tại là dưới 3 năm,1.8 là từ 3 đến 5 năm, 2.0 là trên 5 năm
DELIMITER $$
CREATE PROCEDURE createcurList ()
BEGIN
	DECLARE ngbd DATE;
	DECLARE ngkt DATE;
	DECLARE mnv VARCHAR(10);
	DECLARE finished INTEGER DEFAULT 0;
	DECLARE cur CURSOR FOR SELECT HOPDONG.NgBD,HOPDONG.NgKT,MaNV FROM HOPDONG ;
	DECLARE CONTINUE HANDLER 
	FOR NOT FOUND SET finished = 1;
	ALTER TABLE NHANVIEN ADD chisoluong FLOAT ;
	OPEN cur;
	cur: LOOP
	FETCH cur INTO ngbd,ngkt,mnv;
	IF finished = 1 THEN 
		LEAVE cur;
	END IF;
	UPDATE NHANVIEN SET chisoluong= 1.2 WHERE TIMESTAMPDIFF(YEAR,ngbd,NOW()) < 3 AND ngkt>NOW() AND mnv=MaNV;
	UPDATE NHANVIEN SET chisoluong= 1.8 WHERE (TIMESTAMPDIFF(YEAR,ngbd,NOW()) BETWEEN 3 AND 5)  AND ngkt>NOW() AND mnv=MaNV;
	UPDATE NHANVIEN SET chisoluong= 2.0 WHERE TIMESTAMPDIFF(YEAR,ngbd,NOW()) > 5 AND ngkt>NOW() AND mnv=MaNV;
	END LOOP cur;
	CLOSE cur;
END $$
DELIMITER ;
CALL createcurList();

DROP PROCEDURE createcurList;
ALTER TABLE NHANVIEN DROP COLUMN chisoluong;