PHÂN TÍCH VÀ THIẾT KẾ CSDL QUẢN LÝ CLB BÓNG ĐÁ MySQL 
----------
Mô tả bài toán:  
Một Liên Đoàn Bóng Đá muốn thiết kế csdl để quản lý các câu clb, giải đấu, cầu thủ, 
hlv,…với các thông tin sau:
+ LĐBĐ quản lý nhiều clb bóng đá. Thông tin các clb bóng đá gồm: mã clb, tên, 
ngày lập, cty sở hữu, người qly, địa điểm. 
+ 1 clb gồm nhiều nhân viên trong đó có cầu thủ, hlv, nhân viên khác,..  Nhân viên 
thì có mã nhân viên, tên,  ngày vào làm,  ngày kết thúc, số điện thoại, địa chỉ, clb 
đang công tác .Đối với cầu thủ còn có thông tin số áo,vị trí sở trường. Vì có nhiều 
HLV có thể cùng huấn luyện đội bóng nên HLV thì có thêm loại HLV, ngoài ra 
còn có số năm kinh nghiệm hành nghề. Mỗi nhân viên đều có người quản lý. 
+ 1 nhân viên có thể ký hợp đồng với 1 hoặc nhiều clb .Thông tin hợp đồng bao 
gồm: mã clb, mã nhân viên, chức vụ, ngày bắt đầu, ngày kết thúc, giá trị hợp đồng. 
+Các clb tham gia nhiều giải đấu trong 1 năm. Thông tin giải đấu: mã giải đấu, tên 
giải đấu, ngày bắt đầu, ngày kết thúc, clb vô địch, địa điểm.Trong giải đấu có 
nhiều trận đấu, 1 trận đấu có 1 cặp clb thi đấu với nhau.Thông tin trận đấu bao 
gồm: mã trận đấu, giải đấu, thời gian thi đấu, sân thi đấu, clb A, clb B, tỷ số A,tỷ 
số B. Ngoài ra các thông tin như chức vụ khi tham gia trận đấu, phút ghi bàn, phút 
vào sân, phút ra sân, mvp trận cũng được ghi lại. 
+ Để tạo sự hấp dẫn, cạnh tranh cho giải đấu. Giải còn có các danh hiệu khác nhau. 
Thông tin danh hiệu bao gồm: mã danh hiệu,mã giải đấu, tên danh hiệu. 1 nhân 
viên có 1 hoặc nhiều danh hiệu, và 1 danh hiệu thuộc về 1 hoặc nhiều nhân viên . 
Thời gian trao tặng danh hiệu cũng được ghi lại. 
+ Sân thi đấu sẽ gồm mã sân, tên, địa điểm , clb quản lý.
-------------
Quy trình thực tế liên quan đến bài toán:
1) Liên đoàn bóng đá được thành lập để tổ chức các giải đấu và quản lý các CLB 
2) Các CLB xin phép tham gia vào Liên đoàn bóng đá : để một CLB được phép 
thành lập, được công nhận và cũng như tham gia vào các giải đấu do Liên đoàn 
bóng đá tổ chức thì các CLB phải làm đơn xin phép và đảm bảo những yêu cầu 
cũng như tuân thủ các quy luật mà 1 Liên đoàn bóng đá đặt ra. Sau khi được 
phê duyệt, chấp nhận, các CLB sẽ cung cấp thông tin mà Liên đoàn bóng đá yêu cầu để tổ chức này quản lý.
Thông tin ở đây có thể là : tên clb, ngày thành lập, người quản lý clb, nhân viên, sân quản lý,… 
3) Cá nhân tham gia vào CLB: các cá nhân tham gia vào CLB với nhiều vai trò 
khác nhau như cầu thủ, hlv, nhân viên y tế, nhân viên sân bãi,… Các vai trò 
trong CLB sẽ được quyết định bên trong bản hợp đồng giữa các cá nhân và 
CLB. Sau khi ký kết thành công đôi bên, CLB sẽ tiến hành lưu trữ thông tin 
hợp đồng cũng như thông tin các cá nhân để quản lý. Các thông tin này sẽ được 
gửi đến Liên đoàn bóng đá khi được tổ chức này yêu cầu. 
4) Liên đoàn bóng đá tổ chức và công bố giải đấu : các CLB thuộc quản lý của 
Liên đoàn bóng đá đều có tư cách tham gia các giải đấu do tổ chức này tổ chức. 
Liên đoàn bóng đá sẽ lên các kế hoạch cho giải đấu như tên, thời gian, địa 
điểm, điều luật, thể thức thi đấu,các danh hiệu,tiền thưởng,... Sau khi hoàn 
thành, Liên đoàn bóng đá sẽ công bố thông tin giải đấu và danh sách các CLB 
tham gia.  
5) Chuẩn bị các trận đấu : Liên đoàn bóng đá tiếp tục thiết kế, lên kế hoạch tổ 
chức cho các trận đấu của giải đấu. Các CLB tham gia trận đấu phải cung cấp 
thông tin cho ban tổ chức như thông tin cầu thủ, hlv, nhân viên tham gia trận 
đấu, số áo, màu áo,… trước trận đấu. 
6) Kết thúc giải đấu trao danh hiệu, lưu thông tin giải đấu : Liên đoàn bóng đá 
tiến hành trao các danh hiệu cho các CLB, cá nhân và lưu trữ thông tin giải 
đấu.
