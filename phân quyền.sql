-- Tạo role LienDoan và cấp các quyền cho role
-- Các quyền của role LienDoan gồm có 
-- •	Quyền select trong database 
-- •	Quyền Insert, delete, update GIAIDAU, DANHHIEU, TRANDAU,  CTDH, CLB 
-- •	Quyền thực thi procedure PROC_HSDD, SP_TonggiatriHD và function FUNC_TONGDIEM
CREATE ROLE LienDoan;
GRANT SELECT ON qlclb.* TO 'LienDoan';
grant execute on procedure PROC_HSDD to 'LienDoan';
grant execute on procedure SP_TonggiatriHD to 'LienDoan';
grant execute on function FUNC_TONGDIEM to 'LienDoan';
GRANT INSERT, DELETE, UPDATE ON qlclb.GIAIDAU TO 'LienDoan';
GRANT INSERT, DELETE, UPDATE ON qlclb.DANHHIEU TO 'LienDoan';
GRANT INSERT, DELETE, UPDATE ON qlclb.TRANDAU TO 'LienDoan';
GRANT INSERT, DELETE, UPDATE ON qlclb.CTDH TO 'LienDoan';
GRANT INSERT, DELETE, UPDATE ON qlclb.CLB TO 'LienDoan';
FLUSH PRIVILEGES;

-- Tạo role clb và cấp các quyền cho role
-- Các quyền của role clb gồm có 
-- •	Quyền select trong database 
-- •	Quyền Insert, delete, update HOPDONG, NHANVIEN, SAN,  HLV, CAUTHU, THAMGIAGIADAU
-- •	Quyền thực thi procedure SP_DH_DatDuoc, createcurList và function FUNC_hethopdong
CREATE ROLE clb;
GRANT SELECT ON qlclb.* TO 'clb';
grant execute on procedure SP_DH_DatDuoc to 'clb';
grant execute on procedure createcurList to 'clb';
GRANT INSERT, DELETE, UPDATE ON qlclb.HOPDONG TO clb;
GRANT INSERT, DELETE, UPDATE ON qlclb.NHANVIEN TO clb;
GRANT INSERT, DELETE, UPDATE ON qlclb.SAN TO clb;
GRANT INSERT, DELETE, UPDATE ON qlclb.CAUTHU TO clb;
GRANT INSERT, DELETE, UPDATE ON qlclb.HLV TO clb;
GRANT INSERT, DELETE, UPDATE ON qlclb.THAMGIATRANDAU TO clb;
FLUSH PRIVILEGES;

-- Tạo role hlv và cấp các quyền cho role  
-- Các quyền của role hlv gồm có 
-- •	Quyền select trong CAUTHU, THAMGIATRANDAU
-- •	quyền insert, delete,update THAMGIAGIADAU
-- •	Quyền thực thi fuction danhgia
create role hlv;
GRANT SELECT ON qlclb.THAMGIATRANDAU TO 'hlv';
GRANT SELECT ON qlclb.CAUTHU TO 'hlv';
GRANT INSERT, DELETE, UPDATE ON qlclb.THAMGIATRANDAU TO hlv;
grant execute on function danhgia to 'hlv';
FLUSH PRIVILEGES;

-- Tạo role cauthu và cấp các quyền cho role 
-- Các quyền của role cauthu gồm có 
-- •	Quyền select trong THAMGIATRANDAU
-- •	Quyền thực thi procedure SP_DHRaSan
create role cauthu;
use qlclb;
GRANT select ON qlclb.THAMGIATRANDAU TO cauthu;
grant execute on procedure SP_DHRaSan to cauthu;
FLUSH PRIVILEGES;


-- Store Procedure dùng để tạo user và cấp quyền của role cho user, đầu vào là tên đăng nhập, mật khẩu, tên role
DELIMITER $$
CREATE PROCEDURE SP_createuser (
    IN p_username VARCHAR(30),
    IN p_password VARCHAR(30),
    IN p_role VARCHAR(30)
)
BEGIN
    DECLARE v_host VARCHAR(100);
    SET v_host = 'localhost';
    
    SET @sql = CONCAT('CREATE USER ''', p_username, '''@''', v_host, ''' IDENTIFIED BY ''', p_password, ''';');
    PREPARE stmt FROM @sql;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;

	SET @sql = CONCAT('GRANT ', p_role, ' TO ''', p_username, '''@''', v_host, ''';');
	PREPARE stmt FROM @sql;
	EXECUTE stmt;
	DEALLOCATE PREPARE stmt;
        
	SET @default_role_query = CONCAT('SET DEFAULT ROLE ', p_role, '@''%'' TO ''', p_username, '''@''', v_host, '''');
	PREPARE default_role_stmt FROM @default_role_query;
	EXECUTE default_role_stmt;
	DEALLOCATE PREPARE default_role_stmt;
    
END;


call SP_createuser ('lm10','123456','cauthu');
call SP_createuser ('ctlv','123456','clb');
call SP_createuser ('ctfifa','123456','LienDoan');
call SP_createuser ('hlvcaan','123456','hlv');
-- Xoá SP 
drop procedure SP_createuser

-- Store Procedure dùng để xoá user và huỷ quyền của role cho user, đầu vào là tên đăng nhập, tên role
DELIMITER $$
CREATE PROCEDURE SP_deleteuser (
	IN p_username VARCHAR(30),
    IN p_role VARCHAR(30)
)
BEGIN
	DECLARE v_host VARCHAR(100);
    SET v_host = 'localhost';

	SET @revoke_query = CONCAT('REVOKE ', p_role, ' FROM ''', p_username, '''@''', v_host, '''');
	PREPARE revoke_stmt FROM @revoke_query;
	EXECUTE revoke_stmt;
	DEALLOCATE PREPARE revoke_stmt;
    
	SET @drop_user_query = CONCAT('DROP USER ''', p_username, '''@''', v_host, '''');
	PREPARE drop_user_stmt FROM @drop_user_query;
	EXECUTE drop_user_stmt;
	DEALLOCATE PREPARE drop_user_stmt;
    
END;

-- Các trường hợp khi 1 cầu thủ, hlv, quản lý clb, nhân viên liên đoàn nghỉ việc hay giải nghệ  
-- Thực thi 
call SP_deleteuser ('lm10','cauthu');
call SP_deleteuser ('ctlv','clb');
call SP_deleteuser ('ctfifa','LienDoan');
call SP_deleteuser ('hlvcaan','hlv');
-- Xoá 
drop procedure SP_deleteuser
