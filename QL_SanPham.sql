USE MASTER
GO
IF EXISTS (SELECT * FROM SYSDATABASES WHERE NAME = 'QL_BanHang')
	DROP DATABASE QL_BanHang
GO
----Tạo database: QL_BanHang
CREATE DATABASE QL_BanHang
GO
USE QL_BanHang
GO
SET DATEFORMAT DMY
GO
-- Bảng KHÁCH HÀNG
CREATE TABLE KHACHHANG
(
	MaKH		INT IDENTITY(1,1),
	HoTen		NVARCHAR(50)		NOT NULL,
	TaiKhoan	VARCHAR(50)			UNIQUE,
	MatKhau		VARCHAR(50)			NOT NULL,
	Email		VARCHAR(100)		UNIQUE,
	DiaChiKH	NVARCHAR(200),
	DienThoaiKH CHAR(12),
	Ngaysinh	DATETIME
	CONSTRAINT PK_KHACHHANG PRIMARY KEY (MaKH)
)

-- Bảng LOẠI SP
CREATE TABLE LOAI
(
	MaL			INT IDENTITY(1,1),
	TenLoai		NVARCHAR(50)		NOT NULL,
	CONSTRAINT PK_LOAI PRIMARY KEY(MaL)
)

-- Bảng NHÀ SẢN XUẤT
CREATE TABLE NHASANXUAT
(
	MaNSX		INT IDENTITY(1,1),
	TenNSX		NVARCHAR(50)		NOT NULL,
	DiaChi		NVARCHAR(200),
	DienThoai	VARCHAR(50),
	CONSTRAINT PK_NHASANXUAT PRIMARY KEY(MaNSX)
)

-- Bảng SÁCH
CREATE TABLE SANPHAM
(
	MASP		INT IDENTITY(1,1),
	TENSP		NVARCHAR(100)		NOT NULL,
	GIABAN		DECIMAL(18,0)		CHECK(GIABAN>=0),
	MOTA		NVARCHAR(MAX),
	ANHBIA		VARCHAR(50),
	NGAYCAPNHAT DATETIME,
	SOLUONGTON	INT,
	MAL			INT,
	MANSX		INT,
	CONSTRAINT PK_SANPHAM PRIMARY KEY(MASP),
	CONSTRAINT FK_LOAI FOREIGN KEY (MaL) REFERENCES LOAI(MaL),
	CONSTRAINT FK_NHASX FOREIGN KEY (MANSX) REFERENCES NHASANXUAT(MANSX)
)

-- Bảng ĐƠN ĐẶT HÀNG:
CREATE TABLE DONHANG
(
	MADH		INT IDENTITY(1,1),
	DATHANHTOAN BIT,
	TINHTRANGGIAOHANG BIT,
	NGAYDAT		DATETIME,
	NGAYGIAO	DATETIME,
	MAKH		INT,
	CONSTRAINT PK_DONDATHANG PRIMARY KEY (MADH),
	CONSTRAINT FR_KHACHHANG FOREIGN KEY (MAKH)
	REFERENCES KHACHHANG(MAKH)
)

-- Bảng CHI TIẾT ĐƠN HÀNG
CREATE TABLE CTDONHANG
(
	MADH		INT,
	MASP		INT,
	SOLUONG		INT				CHECK(SOLUONG>=0),
	DONGIA		DECIMAL(18,0)	CHECK (DONGIA>=0),
	CONSTRAINT PK_CTDONHANG PRIMARY KEY(MADH,MASP),
	CONSTRAINT FK_DONHANG FOREIGN KEY (MADH) REFERENCES	DONHANG(MADH),
	CONSTRAINT FK_SANPHAM FOREIGN KEY (MASP) REFERENCES SANPHAM(MASP)
)

-- Bảng ADMIN
CREATE TABLE ADMIN
(
	USERADMIN		VARCHAR(30)		PRIMARY KEY,
	PASSADMIN		VARCHAR(30)		NOT NULL,
	HOTEN			NVARCHAR(50)
)


----------------------
--THEM KHACHHANG
INSERT INTO KHACHHANG VALUES (N'Nguyễn Văn Tài','NGUYENVANTAI','123456','nvtai@gmail.com',N'33/6 Hai Bà Trưng, Quận 1, TPHCM','0903648212','1/05/1972')
INSERT INTO KHACHHANG VALUES (N'Nguyễn Thị Bông','NGUYENTHIBONG','123132','ntbong@gmail.com',N'5/2 Lý Thường Kiệt, Hiệp Tân, Tân Bình, TPHCM','0903665112','2/09/1995')
INSERT INTO KHACHHANG VALUES (N'Lý Thị Hoa','LYTHIHOA','789789','lthoa@gmail.com',N'99/1 Lạc Long Quân, Quận 11, HCM','0903648298','01/8/1969')
INSERT INTO KHACHHANG VALUES (N'Chu Nguyên Chương','CHUNGUYENCHUONG','987654','chuongkute@gmail.com',N'35/7 Nguyễn Tri Phương, Phú Nhuận, TPHCM','0903644568','08/9/1996')

-- Them NSX
INSERT INTO NHASANXUAT(TenNSX) VALUES (N'Kingsport')
INSERT INTO NHASANXUAT(TenNSX) VALUES (N'OSUN')
INSERT INTO NHASANXUAT(TenNSX) VALUES (N'Zasami')

--Them LOAI
INSERT INTO LOAI VALUES (N'Máy chạy bộ')
INSERT INTO LOAI VALUES (N'Giàn tạ tập thể hình')
INSERT INTO LOAI VALUES (N'Xe đạp tập')
INSERT INTO LOAI VALUES (N'Ghế Massage')


--Them SP
INSERT INTO SANPHAM VALUES(N'GIÀN TẠ ĐA NĂNG KINGSPORT BK-1998 NEW 2021',8850000,N'Giàn tạ đa năng Kingsport BK-1998 NEW 2021 được ra mắt vào tháng 9, là bản nâng cấp của giàn tạ BK-1998 cũ, BK-1998 new 2021 thừa hưởng những đặc điểm nổi bật của model trước đó kèm theo những thiết kế được tối ưu hơn, Giàn tạ đa năng Kingsport BK-1998 NEW 2021 có thiết kế hiện đại, tích hợp các chức năng tập luyện chuyên nghiệp như một gymer thực thụ, sở hữu Giàn tạ đa năng Kingsport BK-1998 New 2021 sẽ giúp bạn sở hữu một thân hình săn chắc và vóc dáng như mơ tại ngôi nhà của bạn.','1.jpg','11/4/2021',10,2,1)
INSERT INTO SANPHAM VALUES(N'GIÀN TẠ ĐA NĂNG KINGSPORT BK-399 PRO',22400000,N'Giàn tập đa năng Kingsport BK 399 Pro là giàn tập tổng hợp nhiều chức năng giúp rèn luyện và nâng cao thể lực rất hiệu quả chính vì thế, là một gymer mới bắt đầu hay chuyên nghiệp thì giàn tạ đa năng Kingsport BK-399 là một lựa chọn không thể thiếu. Được thiết kế đa năng, có kết cấu từ ống thép dày 3 ly đảm bảo độ bền chắc, chịu được tải trọng lớn, hỗ trợ đầy đủ các bài tập cơ bản của gym như: cơ ngực, cơ đùi, cơ tay, hay cơ vai, bụng, chân...sẵn sàng cùng bạn mở ra phòng gym tại ngôi nhà của bạn, giúp bạn thoải mái luyện tập mà không lo ngại đến vấn đề mưa, nắng, khói bụi bên ngoài nữa nhé!','2.jpg','11/4/2021',10,2,1)
INSERT INTO SANPHAM VALUES(N'GIÀN TẠ ĐA NĂNG KINGSPORT BK-1999 PRO',17500000,N'Hội tụ hơn 15 bài tập giàn tạ BK-1999 PRO sẵn sàng cùng bạn mang lại một thân hình lý tưởng, một vóc dáng như mơ chỉ với 1 cổ máy đa năng Kingsport BK-1999 Pro. Bạn đã sẵn sàng cho lịch trình tìm kiếm vóc dáng đẹp tại ngôi nhà của mình chưa nhỉ? Lướt ngay xuống bên dưới, để cùng Kingsport tìm hiểu chi tiết hơn những tính năng cũng như những đặc điểm của giàn tạ đa năng Kingsport BK-1999 Pro bạn nhé!','3.jpg','11/4/2021',10,2,1)
INSERT INTO SANPHAM VALUES(N'GHẾ TẠ ĐA NĂNG KINGSPORT BK-799',10300000,N'Luyện tập với ghế tạ đa năng là phương pháp rèn luyện sức khỏe cơ bắp toàn thân được nhiều người lựa chọn với các ưu điểm như tiết kiệm chi phí, tích hợp nhiều bài tập phù hợp với mọi lứa tuổi dùng khác nhau. Với hơn 12 bài tập giúp bạn và gia đình có thêm nhiều trải nghiệm tuyệt vời với chiếc ghế đa năng này:Tập ngực ngang-Tập ngực trên-Tập ngực dưới-Hít xà đơn-Tập đẩy ngực trên-Tập đẩy ngực ngang-Tập đẩy ngực dưới-Tập cầu vai-Tập tay trước-Tập tay sau-Tập đá đùi-Tập cơ chân','4.jpg','10/4/2021',1000,2,1)
INSERT INTO SANPHAM VALUES(N'GIÀN TẠ ĐA NĂNG KINGSPORT BK-899 PRO',9000000,N'Giàn tạ Kingsport BK 899 Pro được mệnh danh là dòng sản phẩm dành cho thể hình được bán chạy nhất hiện nay tại Kingsport, giàn tạ được thiết kế tinh tế và tích hợp hơn 15 động tác dành cho gymer chuyên nghiệp trong giàn tạ đa năng Kingsport BK-899 cho bạn những phút giây luyện tập tuyệt vời và mang lại vóc dáng hoàn mỹ chuẩn sao. Lựa chọn giàn tạ đa năng Kingsport BK-899 Pro được thiết kế bởi chuyên gia hàng đầu tại Kingsport, có khung sườn nguyên khối vô cùng cứng cáp và bền bỉ khả năng chịu tải trọng lên đến 150Kg. Thiết kế ghế ngồi tách biệt giúp bạn dễ dàng luyện tập. Mang về giàn tạ Kingsport BK-899 Pro về ngôi nhà của bạn chắc chắn sẽ là quyết định đúng đắn bởi giàn tạ BK-899 không chỉ mang đến cho bạn một thân hình chuẩn sao mà còn mang về cho bạn một sức khỏe vượt trội, cường tráng với nguồn năng lượng tươi mới nhất.','5.jpg','10/4/2021',10,2,1)
INSERT INTO SANPHAM VALUES(N'GIÀN TẬP ĐA NĂNG KINGSPORT BK999',84000000,N'Giàn tập đa năng Kingsport BK-999 là giàn tập tổng hợp nhiều chức năng kết hợp với huấn luyện viên cá nhân. Thích hợp cho các phòng tập có sử dụng gói tập PT. Tập luyện với Giàn tập đa năng Kingsport BK-999 giúp rèn luyện và nâng cao thể lực hiệu quả nhất.','6.jpg','10/4/2021',1000,2,1)

INSERT INTO SANPHAM VALUES(N'Ghế Massage Toàn Thân Cao Cấp OSUN SK-69',68900000,N'Kết thúc một ngày làm việc, bỏ lại những stress ngoài kia còn gì tuyệt vời hơn được ngả người vào ghế massage cao cấp OSUN SK-69. Với thiết kế trang nhã, tính năng xứng tầm hoàng gia, OSUN SK-69 được ví như đẳng cấp của giới thượng lưu.','7.jpg','10/8/2021',10,4,2)
INSERT INTO SANPHAM VALUES(N'Ghế Massage Toàn Thân OSUN SK-66',48900000,N'GHẾ MASSAGE OSUN SK-66 - ÊM ÁI DU DƯƠNG NHƯ VÒNG TAY CỦA MẸ','8.jpg','10/8/2021',10,4,2)

INSERT INTO SANPHAM VALUES(N'Máy Chạy Bộ Điện Zasami Felice KZ-G3460',16500000,N'Bạn tự ti về ngoại hình của mình với một thân hình quá khổ, nặng nề, thừa mỡ,…Và ở ngoài kia không ít những ánh mắt soi mói khiến bạn phải thu mình lại, ngại tiếp xúc với mọi người, nghiêm trọng hơn có thể dẫn đến trầm cảm.','9.jpg','10/8/2021',10,1,3)
INSERT INTO SANPHAM VALUES(N'Máy Chạy Bộ Điện Zasami KZ-S180',9990000,N'Cuộc sống bận rộn, nhu cầu tăng cường thể lực, giảm béo phì ngày càng trở nên cấp thiết. Thông thường, để tiết kiệm thời gian, chúng ta hay tìm đến những phương thuốc giảm cân quảng cáo tràn lan trên mạng hay qua người quen giới thiệu. Hiệu quả thì chưa thấy đâu nhưng hậu quả thì đã rất rõ ràng. Không ít người suy gan, thận chỉ vì cả tin sử dụng thuốc giảm cân không rõ nguồn gốc, xuất xứ.','10.jpg','10/8/2021',10,1,3)
INSERT INTO SANPHAM VALUES(N'Máy Chạy Bộ Điện Zasami KZ-559',23990000,N'Không phải ngẫu nhiên mà Zasami KZ-559 là dòng sản phẩm được rất nhiều khách hàng kỹ tính ưa chuộng. Thiết bị này có trang bị những công nghệ mới nhất, được thiết kế bởi đội ngũ chuyên nghiệp và có nhiều năm kinh nghiệm. Phải mất nhiều năm mới có thể cho ra đời một sản phẩm ấn tượng về tính năng, đột phá về thiết kế như máy chạy bộ zasami KZ 559. Máy mang đến sự hài lòng cho người sử dụng và điểm nhấn sang trọng cho ngôi nhà của bất cứ ai sở hữu nó.','11.jpg','10/8/2021',10,1,3)
INSERT INTO SANPHAM VALUES(N'Máy Chạy Bộ Zasami KZ-T6700A',41900000,N'Máy chạy bộ zasami KZ T6700A là dòng sản phẩm cao cấp mang thương hiệu Zasami. Máy có thiết kế kiểu dáng sang trọng, lịch lãm kết hợp với tính năng vượt trội, bền bỉ mang lại hiệu quả cao trong quá trình luyện tập.','12.jpg','10/8/2021',10,1,3)

INSERT INTO SANPHAM VALUES(N'Xe đạp tập thể dục Zasami KZ-6511',3590000,N'Xe đạp tập thể dục Zasami KZ-6511 là thiết bị thể dục thể thao tại nhà hỗ trợ tập toàn thân, mang lại nhiều lợi ích cho sức khỏe, tăng cường sức mạnh, sự dẻo dai, linh hoạt cho đôi chân, cải thiện sức khỏe tim mạch.','13.jpg','10/8/2021',10,3,3)
INSERT INTO SANPHAM VALUES(N'Xe Đạp Tập Thể Dục Zasami KZ-6417',7390000,N'Xe đạp tập thể dục KZ 6417 – Dòng thiết bị độc quyền chỉ có duy nhất tại Daiviet Sport, được thiết kế cực bền, kiểu dáng đẹp màu sắc kết hợp ấn tượng phù hợp với không gian và nhu cầu tập luyện tại gia đình, phòng tập gym.','14.jpg','5/8/2021',1000,3,3)
INSERT INTO SANPHAM VALUES(N'Xe Đạp Tập Thể Dục Zasami KZ-6411',2990000,N'Xe đạp tập thể dục Zasami KZ-6411 là dòng xe đạp tập thể dục được các gia đình quan tâm trong thời gian gần đây. Máy tập đạp xe này thường được sử dụng để luyện tập lấy lại vóc dáng, giúp cơ thể săn chắc và thon gọn hơn. Không những vậy, KZ-6411 còn là sản phẩm chuyên dụng hỗ trợ tập phục hồi chức năng cho người tai biến, cải thiện các khớp của chân, chống thoái hóa khớp đầu gối, giúp cho người tập duy trì thể chất hằng ngày.','15.jpg','5/8/2021',1000,3,3)
INSERT INTO SANPHAM VALUES(N'Xe Đạp Tập Thể Dục Zasami KZ606EA',6990000,N'Trong thời đại khoa học công nghệ ngày càng phát triển thì việc áp dụng những phát minh vào phục vụ cho cuộc sống của con người không còn là điều gì quá xa lạ. Và Xe đạp tập liên hoàn tay chân KZ606EA là một trong số đó.','16.jpg','5/8/2021',1000,3,3)

--Them DONHANG
INSERT INTO DONHANG VALUES(1,0,'11/08/2021','12/08/2021',1)
INSERT INTO DONHANG VALUES(1,0,'12/08/2021','13/08/2021',2)
INSERT INTO DONHANG VALUES(1,1,'10/08/2021','11/08/2021',1)
INSERT INTO DONHANG VALUES(0,0,'19/08/2021','20/08/2021',3)

--Them CTDONHANG
INSERT INTO CTDONHANG VALUES(1,6,1,84000000)
INSERT INTO CTDONHANG VALUES(1,1,1,8850000)
INSERT INTO CTDONHANG VALUES(2,7,2,137800000)
INSERT INTO CTDONHANG VALUES(3,12,1,41900000)
INSERT INTO CTDONHANG VALUES(4,15,1,2990000)

--Them ADMIN
INSERT INTO ADMIN VALUES ('admin','123456',N'ĐẶNG QUANG THỊNH')

-------------------
SELECT * FROM KHACHHANG
SELECT * FROM LOAI
SELECT * FROM NHASANXUAT
SELECT * FROM SANPHAM
SELECT * FROM DONHANG
SELECT * FROM CTDONHANG
SELECT * FROM ADMIN