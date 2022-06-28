create database QuanlyHanhKhach
go
use QuanlyHanhKhach
------- Part 1:CREATE DATABASE  -------

 ---- I. Create Table ----

 -- Table 4 --
create table TrangThaiTG(
MSTTTG int IDENTITY(1,1),
TenTT char(5) not null,
PhanTramTP float not null, 
primary key (MSTTTG)
)

-- Table 9 --
create table LoaiMayBay(
MSLMB int IDENTITY(1,1) not null,
HangSX char(20) not null,
Model char(20) not null,
SoGheVip int not null,
SoGhePT int not null,
TongSoGhe int not null,
primary key (MSLMB)
)

-- Table 8 --
create table MayBay(
MSMB varchar(6) not null, 
TongGioBay int not null,
NamSX int not null,
ThoiDiemSD date not null,
MSLMB int not null,
primary key (MSMB),
constraint fk_MayBay_LoaiMayBay foreign key (MSLMB) references LoaiMayBay(MSLMB)
)

-- Table 12 --
create table Ga(
MSG int IDENTITY(1,1) not null,
TenSB  nvarchar(25) not null,
ThanhPho nvarchar(25) not null,
QuocGia nvarchar(20) not null,
primary key (MSG)
) 
-- Table 11 --
create table TuyenBay(
MSTB int IDENTITY(1,1) not null,
MSG_Di  int not null,
MSG_Den int not null,
primary key (MSTB),
constraint fk_TuyenBay_Ga foreign key (MSG_Di) references Ga(MSG)
)

-- Table 6 --
create table ChuyenBay(
MSCB varchar(9) primary key,
TrangThai char(5) not null,
SoGheTrong int not null,
ThoiDiemDi datetime not null,
ThoiDiemDen datetime not null,
MSMB varchar(6) not null,
MSTB  int not null,
constraint fk_ChuyenBay_MayBay foreign key (MSMB) references MayBay(MSMB),
constraint fk_ChuyenBay_TuyenBay foreign key (MSTB) references TuyenBay(MSTB)
)

-- Table 5 --
create table PhiVCHH(
MSPHH  int IDENTITY(1,1) not null,
LoaiVe char(5) not null,
TrongLuongDM int not null,
DonGia_Kg int not null, 
ThoiDiemApDung date not null,
primary key (MSPHH)
)

-- Table 1 --
create table KhachHang(
MSKH varchar(12),
LoaiKH varchar(2),
Hoten nvarchar(30),
NgaySinh date,
GioiTinh char(5) check(GioiTinh ='Nam' or GioiTinh='Nu'),
QuocTich nvarchar(30),
SoDT char(11),
DiaChi nvarchar(50),
MSTTTG int,
MSPHH  int ,
MSCB varchar(9),
KhoiLuongVuot int ,
primary key (MSKH),
constraint fk_KhachHang_TrangThaiTG foreign key (MSTTTG) references TrangThaiTG(MSTTTG),
constraint fk_KhachHang_ChuyenBay foreign key (MSCB) references ChuyenBay(MSCB),
constraint fk_KhachHang_PhiVCHH foreign key (MSPHH) references PhiVCHH(MSPHH)
)

-- Table 2 --
create table KhachHangNL(
MSKH varchar(12),
CMND char(20) not null UNIQUE,
Passport char(20),
primary key (MSKH),
constraint fk_KhachHangNL_KhachHang foreign key (MSKH) references KhachHang(MSKH)
)

-- Table 3 --
create table KhachHangTE(
MSKH varchar(12),
ThongTinKSinh char(255),
MSNGH  char(25) not null,
primary key (MSKH),
constraint fk_KhachHangTE_KhachHang foreign key (MSKH) references KhachHang(MSKH)
)

-- Table 7 --
create table GheKhach(
MSKH varchar(12) not null,
GheSo varchar(3) not null,
Gia char(20) not null,
primary key (MSKH, GheSo),
constraint fk_GheKhach_KhachHang foreign key (MSKH) references KhachHang(MSKH)
)

-- Table 10 --
create table GheNgoi(
MSG int IDENTITY(1,1) not null,
GheSo varchar(3) not null,
LoaiGhe char(5) not null,
MSLMB int not null,
primary key (MSG),
constraint fk_GheNgoi_LoaiMayBay foreign key (MSLMB) references LoaiMayBay(MSLMB)
)

-- Table 13 --
create table ThucPham(
MSTP int IDENTITY(1,1) not null,
Ten char(25) not null UNIQUE,
MoTa char(255),
primary key (MSTP)
)

--Table 14 --
create table GiaThucPham(
MSGTP int IDENTITY(1,1) not null,
Gia char(20) not null,
NgayApDung date not null,
MSTP int not null,
primary key (MSGTP),
constraint fk_GiaThucPham_ThucPham foreign key (MSTP) references ThucPham(MSTP)
)

-- Table 15 --
create table ChuyenBayThucPham(
MSCB varchar(9),
MSTP int not null,
primary key (MSCB, MSTP),
constraint fk_ChuyenBayThucPham_ChuyenBay foreign key (MSCB) references ChuyenBay(MSCB),
constraint fk_ChuyenBayThucPham_ThucPham foreign key (MSTP) references ThucPham(MSTP)
)

--Table 16--
create table NhanVien(
MSNV varchar(12) not null,
LoaiNV varchar(2) not null CHECK(LoaiNV ='PC' OR LoaiNV ='TV' OR LoaiNV ='KT' OR LoaiNV ='DH' OR LoaiNV ='KS'),
Hoten nvarchar(35) not null,
NgaySinh date not null,
GioiTinh char(5) not null,
QuocTich nvarchar(20) not null,
CMND char(20) not null UNIQUE,
Passport char(20),
NgayVaoLam date not null,
DiaChi nvarchar(50) not null,
SoDT char(11) not null,
TienLuong char(20) not null,
primary key (MSNV)
)

-- Table 17 --
create table BangCap(
MSBC int IDENTITY(1,1) not null,
TenBangCap nvarchar(50) not null,
TruongDaoTao nvarchar(100) not null,
NamDat int not null,
MSNV varchar(12) not null, 
primary key (MSBC),
constraint fk_BangCap_NhanVien foreign key (MSNV) references NhanVien(MSNV)
)

-- Table 18 --
create table PhiCong(
MSNV varchar(12) not null,
LoaiPhiCong char(5) not null CHECK(LoaiPhiCong ='CT' or LoaiPhiCong ='PL'),
primary key (MSNV),
constraint fk_PhiCong_NhanVien foreign key (MSNV) references NhanVien(MSNV)
)

-- Table 19 --
create table TiepVien(
MSNV varchar(12) not null,
NgoaiNguThongThao char(20) not null,
primary key (MSNV),
constraint fk_TiepVien_NhanVien foreign key (MSNV) references NhanVien(MSNV)
)

-- Table 20--
create table ChiNhanh(
MSCN int IDENTITY(1,1) not null,
TenChiNhanh nvarchar(50) not null,
ThanhPho char(30) not null,
QuocGia char(30) not null,
primary Key (MSCN)
)

-- Table 21 --
create table CaLamViec(
MSCLV varchar(2) not null,
TuGio time not null,
DenGio time not null,
primary key (MSCLV)
)

-- Table 22 --
create table NhanVienMD(
MSNV varchar(12) not null,
MSCN int not null,
MSNV_Truong varchar(12) not null,
primary key (MSNV),
constraint fk_NhanVienMD_NhanVien foreign key (MSNV) references NhanVien(MSNV),
constraint fk_NhanVienMD_ChiNhanh foreign key (MSCN) references ChiNhanh(MSCN)
)

-- Table 23 --
create table NVMatDat_CaLV(
MSNV varchar(12) not null,
MSCLV varchar(2) not null,
NgayBatDau date not null,
primary key (MSNV, MSCLV),
constraint fk_NVMatDat_CaLV_NhanVien foreign key (MSNV) references NhanVienMD(MSNV),
constraint fk_NVMatDat_CaLV_CaLamViec foreign key (MSCLV) references CaLamViec(MSCLV)
)

-- Table 24 --
create table VanHanh(
MSNV varchar(12),
MSCB varchar(9),
primary key (MSNV, MSCB),
constraint fk_VanHanh_NhanVien foreign key (MSNV) references NhanVien(MSNV),
constraint fk_VanHanh_KhachHang foreign key (MSCB) references ChuyenBay(MSCB)
)

-- Table 25 --
create table Lai(
MSNV varchar(12),
MSLMB int,
primary key (MSNV, MSLMB),
constraint fk_Lai_NhanVien foreign key (MSNV) references NhanVien(MSNV),
constraint fk_Lai_MayBay foreign key (MSLMB) references LoaiMayBay(MSLMB)
)

-- Table 26 --
create table KiemTra(
MSNV varchar(12),
MSCB varchar(9),
primary key (MSNV, MSCB),
constraint fk_KiemTra_NhanVien foreign key (MSNV) references NhanVien(MSNV),
constraint fk_KiemTra_KhachHang foreign key (MSCB) references ChuyenBay(MSCB)
)

-- Table 27 --
create table ChuyenMonBD(
MSNV varchar(12),
MSLMB int,
primary key (MSNV, MSLMB),
constraint fk_ChuyenMonBD_NhanVien foreign key (MSNV) references NhanVien(MSNV),
constraint fk_ChuyenMonBD_LoaiMayBay foreign key (MSLMB) references LoaiMayBay(MSLMB)
)

go
-- Input KhachHang with full automatic MSKH --
CREATE PROC InputCus(@LoaiKH varchar(2),@Hoten nvarchar(30),@NgaySinh date,@GioiTinh char(5),@QuocTich nvarchar(20),@SoDT char(11),@DiaChi nvarchar(50),@MSTTTG int,@MSPHH int,@MSCB char(20),@KhoiLuongVuot char(10))
AS
BEGIN
	DECLARE @MSKH varchar(12)
	SELECT @MSKH = (MAX(RIGHT(MSKH, 10))) FROM KhachHang
	DECLARE @COUNT int
	SET @COUNT = CAST(@MSKH as int) + 1
		SELECT @MSKH = CASE
			WHEN @COUNT >= 0 and @COUNT < 10 THEN  @LoaiKH + '000000000' + CAST(@COUNT as varchar(1))
			WHEN @COUNT >= 10 THEN @LoaiKH + '00000000' + CAST(@COUNT as varchar(2))
			WHEN @COUNT > 99  THEN @LoaiKH + '0000000' + CAST(@COUNT as varchar(3))
			WHEN @COUNT > 999  THEN @LoaiKH + '000000' + CAST(@COUNT as varchar(4))
			WHEN @COUNT > 9999  THEN @LoaiKH + '00000' + CAST(@COUNT as varchar(5))
			WHEN @COUNT > 99999  THEN @LoaiKH + '0000' + CAST(@COUNT as varchar(6))
			WHEN @COUNT > 999999  THEN @LoaiKH + '000' + CAST(@COUNT as varchar(7))
			WHEN @COUNT > 9999999  THEN @LoaiKH + '00' + CAST(@COUNT as varchar(8))
			WHEN @COUNT > 99999999  THEN @LoaiKH + '0' + CAST(@COUNT as varchar(9))

		END
	Insert into KhachHang values (@MSKH,@LoaiKH,@Hoten,@NgaySinh,@GioiTinh,@QuocTich,@SoDT,@DiaChi,@MSTTTG,@MSPHH,@MSCB,@KhoiLuongVuot)
END

go
-- Input NhanVien with full automatic MSNV --
CREATE PROC InputStaff(@LoaiNV varchar(2),@Hoten nvarchar(30),@NgaySinh date,@GioiTinh char(5),@QuocTich nvarchar(20),@CMND char(20),@Passport char(20),@NgayVaoLam date,@DiaChi nvarchar(50),@SoDT char(11),@TienLuong char(20))
AS
BEGIN
	DECLARE @MSNV varchar(12)
	SELECT @MSNV = (MAX(RIGHT(MSNV, 10))) FROM NhanVien
	DECLARE @COUNT int
	SET @COUNT = CAST(@MSNV as int) + 1
		SELECT @MSNV = CASE
			WHEN @COUNT >= 0 and @COUNT < 10 THEN  @LoaiNV + '000000000' + CAST(@COUNT as varchar(1))
			WHEN @COUNT >= 10 THEN @LoaiNV + '00000000' + CAST(@COUNT as varchar(2))
			WHEN @COUNT > 99  THEN @LoaiNV + '0000000' + CAST(@COUNT as varchar(3))
			WHEN @COUNT > 999  THEN @LoaiNV + '000000' + CAST(@COUNT as varchar(4))
			WHEN @COUNT > 9999  THEN @LoaiNV + '00000' + CAST(@COUNT as varchar(5))
			WHEN @COUNT > 99999  THEN @LoaiNV + '0000' + CAST(@COUNT as varchar(6))
			WHEN @COUNT > 999999  THEN @LoaiNV + '000' + CAST(@COUNT as varchar(7))
			WHEN @COUNT > 9999999  THEN @LoaiNV + '00' + CAST(@COUNT as varchar(8))
			WHEN @COUNT > 99999999  THEN @LoaiNV + '0' + CAST(@COUNT as varchar(9))

		END
	Insert into NhanVien values (@MSNV,@LoaiNV,@Hoten,@NgaySinh,@GioiTinh,@QuocTich,@CMND,@Passport,@NgayVaoLam,@DiaChi,@SoDT,@TienLuong)
END

go
 ---- II. Create Index ----
CREATE INDEX ChuyenBayTrong
ON ChuyenBay(MSCB, SoGheTrong, ThoiDiemDi, ThoiDiemDen, MSTB);

go
CREATE INDEX GheTrong
ON ChuyenBay(MSCB, SoGheTrong);


------- Part 2 : CREATE STORE PROCEDURE, FUNCTION, TRIGGER -------

 ---- I. Create Trigger ----
 go
 --- Request 1 ---
 create trigger KT_GHE 
ON LoaiMayBay
FOR INSERT
AS
BEGIN
	Declare @TongSoGhe int,@SoGhePT int,@SoGheVip int
	Set @TongSoGhe = (Select TongSoGhe from inserted)
	Set @SoGhePT = (Select SoGhePT from inserted)
	Set @SoGheVip = (Select SoGheVip from inserted)
	if (@SoGhePT + @SoGheVip != @TongSoGhe)
	begin
		print 'Du lieu khong hop le'
		ROLLBACK TRAN
	end
END
go
 ---Trigger_câu2---
create trigger KT_GIOBAY
ON ChuyenBay
FOR INSERT
AS
BEGIN
	Declare @TongGioBay int ,@ThoiDiemDi datetime,@ThoiDiemDen datetime,@TrangThai char(5),@MSMB varchar(6)
	set @MSMB = (Select MSMB from inserted)
	Set @ThoiDiemDi = (Select ThoiDiemDi from inserted)
	Set @ThoiDiemDen = (Select ThoiDiemDen from inserted)
	Set @TrangThai = (select TrangThai from inserted)
	Set @TongGioBay = (Select TongGioBay from MayBay an where MSMB = '@MSMB')
	If (@TrangThai = 'DB' and Datediff(hh,@ThoiDiemDi,@ThoiDiemDen) != @TongGioBay)
			begin
				print 'Error'
				ROLLBACK TRAN
			end
	END
 --- Request 2 ---


  ---- II. Create STORE PROCEDURE & FUNCTION ----

 --- Request 1 ---
go
CREATE PROC UpdatePhiVCHH(@MSKH varchar(12),@MSPHH int)
AS 
Begin
if @MSKH in (select MSKH from KhachHang)
	if @MSPHH in (select MSPHH from PhiVCHH)
		Begin
		 insert into KhachHang(MSPHH) values (@MSPHH)
		 print'Phi VCHH Da Duoc Cap Nhat Thanh Cong!'
		end
	else 
		print'Loi, ma so phieu hang hoa nay khong hop le!'
else
		print'Loi, Khong tim thay thong tin khach hang trong database.'
End

--- Request 2 ---

	--- 2.a ---
go
CREATE PROC UpdateKLHHVuotMuc(@KLcanduoc int,@MSKH varchar(12))
AS
Begin
	Declare @TrongLuongDM int
	Declare @KhoiLuongVuot int

	Select @TrongLuongDM =TrongluongDM from PhiVCHH phi, KhachHang cus where @MSKH = MSKH and phi.MSPHH = cus.MSPHH
		
	if(@KLcanduoc > @TrongluongDM)
		Set @KhoiLuongVuot = @KLcanduoc - @TrongLuongDM
	else
		Set @KhoiLuongVuot = 0

	Update KhachHang Set KhoiLuongVuot = @KhoiLuongVuot where MSKH = @MSKH
end

	--- 2.b ---

go
CREATE FUNCTION PhiShip(@KLcanduoc int,@MSKH varchar(12))
returns int
AS
Begin
	Declare @Dongia int
	Declare @PhiVC int

	Select @Dongia=DonGia_Kg from PhiVCHH val, KhachHang cus where @MSKH = MSKH and val.MSPHH = cus.MSPHH

	Set @PhiVC = @KLcanduoc * @Dongia
		
	return @PhiVC 
End

	--- 2.c ---
go
create proc capnhatKLvuotnhom(@MSCB varchar(9))
AS
Begin
	Declare @TrongLuongDM int
	Declare @KhoiLuongVuot int
	Declare @KLcanduoc int
	Declare @MSKH varchar(12) 
	 --- Sample Table test ---
	declare @MSKH_KL table (MSKH varchar(12),KLcanduoc int)
	insert @MSKH_KL values ('NL0000000001',40),
						 ('NL0000000002',40),
						 ('NL0000000003',50),
						 ('NL0000000004',30),
						 ('TE0000000005',30),
						 ('TE0000000006',40),					
						 ('TE0000000008',30)
					 
					
	Select @TrongLuongDM=Sum(TrongLuongDM),@KLcanduoc=sum(KLcanduoc)
	from KhachHang join PhiVCHH on KhachHang.MSPHH = PhiVCHH.MSPHH join @MSKH_KL a on a.MSKH = KhachHang.MSKH
	where @MSCB=MSCB
	group by KhachHang.DiaChi

	select @MSKH=a.MSKH
	from KhachHang a
	where @MSCB = a.MSCB 
		  and year(a.NgaySinh) <= all(select year (b.NgaySinh)
									from KhachHang b
									where a.DiaChi = b.DiaChi and a.MSCB = b.MSCB)
	  	
	if(@KLcanduoc > @TrongluongDM)
	Set @KhoiLuongVuot = @KLcanduoc - @TrongLuongDM
	else 
	Set @KhoiLuongVuot = 0

	Update KhachHang
	Set KhoiLuongVuot = @KhoiLuongVuot
	where MSKH = @MSKH
	end
	
------- Part 3 : Thao Tac tren co so du lieu  -------

--- I. Insert ---
go
insert into TrangThaiTG values('TG',24.5)
							 ,('TG',22.0)
							 ,('TG',27.5)
							 ,('DD',19.5)
							 ,('HH',9.5)

insert into PhiVCHH values('VIP', 50, 300000, '11/7/2018')
						 ,('PT', 30, 180000, '11/7/2018')
                         ,('PT', 60, 400000, '11/7/2018')
                         ,('PT', 20, 150000, '11/7/2018')
                         ,('VIP', 25, 180000, '10/3/2018')
                         ,('PT', 30, 150000, '12/1/2018')
                         ,('VIP', 40, 600000, '10/15/2018')
                         ,('VIP', 30, 300000, '9/7/2018')

insert into LoaiMayBay values('Airbus', 'A380-900', '200', '656', '856')
insert into LoaiMayBay values('Bombardier', 'CRJ-900', '86', '258', '344')
insert into LoaiMayBay values('Boeing', '747-400', '100', '524', '624')
insert into LoaiMayBay values('Airbus', ' A318', '50', '150', '200')
insert into LoaiMayBay values('Airbus', 'A340-500', '59', '313', '372')
insert into LoaiMayBay values('Airbus', 'A380-900', '200', '656', '856')

insert into  MayBay values('SAP001', '9', '2012', '1/1/2013', 1)
insert into  MayBay values('SAP002', '10', '2012', '1/1/2013', 2)
insert into  MayBay values('SAP003', '5', '2012', '2/2/2013', 3)
insert into  MayBay values('SAP004', '7', '2013', '7/5/2014', 4)
insert into  MayBay values('SAP005', '4', '2013', '4/3/2014', 5)
insert into  MayBay values('SAP006', '5', '2014', '6/2/2015', 5)
insert into  MayBay values('SAP007', '6', '2014', '5/1/2015', 6)

insert into Ga values(N'Tân Sơn Nhất', N'Thành phố HCM', N'Việt Nam')
					,(N'Đà Nẵng', N'Thành phố Đà Nẵng', N'Việt Nam')
					,(N'Phù Cát', N'Thành phố Quy Nhơn', N'Việt Nam')
					,(N'Nội Bài', N'Hà Nội', N'Việt Nam')

insert into TuyenBay values('1', '2')
						  ,('1', '3')
						  ,('1', '4')
						  ,('2', '1')
						  ,('2', '3')
						  ,('2', '4')
						  ,('3', '1')
						  ,('3', '2')
						  ,('3', '4')
						  ,('4', '1')
						  ,('4', '2')
						  ,('4', '3')

insert into ChuyenBay values('SA1234567', 'CB', 15, '11/7/2018 9:00:00', '11/7/2018 18:00:00', 'SAP001', 9)
insert into ChuyenBay values('SA1234568', 'CB', 15, '11/7/2018 8:00:00', '11/8/2018 12:00:00', 'SAP003', 2)
insert into ChuyenBay values('SA1234569', 'DB', 10, '11/7/2018 7:00:00', '11/8/2018 13:00:00', 'SAP004', 8)
insert into ChuyenBay values('SA1234570', 'DB', 10, '11/8/2018 12:00:00', '11/9/2018 20:00:00', 'SAP001', 7)
insert into ChuyenBay values('SA1234571', 'CB', 10, '11/9/2018 4:00:00', '11/10/2018 7:00:00', 'SAP005', 4)	
insert into ChuyenBay values('SA1234572', 'HB', 10, '12/1/2018 17:00:00', '12/2/2018 21:00:00', 'SAP004', 7)	
insert into ChuyenBay values('SA1234573', 'DB', 10, '12/2/2018 12:00:00', '12/3/2018 21:00:00', 'SAP002', 5)

						  
insert into KhachHang values('NL0000000001', 'NL', N'Bùi Nhật Tâm', '7/3/1993', 'Nam', N'Việt Nam', '0928126784', N'Xóm chiếu, Quận 4 Tp.HCM', '1', '1', 'SA1234567', '')
execute InputCus 'NL', N'Trương Bảo Hoàng', '5/17/1993', 'Nam', N'Việt Nam', '0909748965', N'Nguyễn Hữu Thọ, Tân Hưng, Quận 7, TP HCM', '1','2', 'SA1234568', '' 
execute InputCus 'NL', N'Nguyễn Toàn Thiện', '8/19/1994', 'Nam', N'Việt Nam', '0923753951' , N'Quận 8, Tp.HCM', '1', '3', 'SA1234567', '' 
execute InputCus 'NL', N'Mai Lê Trung Tín', '4/17/1993', 'Nam', N'Việt Nam', '0956789456' , N'Biên Hòa, Đồng Nai','1', '4', 'SA1234568', '' 
execute InputCus 'NL', N'Nguyễn Đình Khải', '2/2/2005', 'Nam', N'Việt Nam', '0972741963', N'Gò Vấp, Tp.HCM', '1', '5', 'SA1234568', ''
execute InputCus 'TE', N'Nguyễn Thanh Tuấn', '4/6/2005', 'Nam', N'Việt Nam', '094612325', N'Mỏ Cày Nam, Bên Tre', '1', '6', 'SA1234569', ''
execute InputCus 'TE', N'Trần Ngọc Phúc', '5/5/2005', 'Nam', N'Việt Nam', '09157496', N'Định Thủy, Bến Tre', '1', '7', 'SA1234572', ''
execute InputCus 'NL', N'Nguyễn Duy Mạnh', '12/8/2005', 'Nam', N'Việt Nam', '0975326745', N'Trần Xuân Soạn, Quận 7, Tp.HCM', '1', '3', 'SA1234573', ''

insert into KhachHangNL values ('NL0000000001', '334922174', 'B2770504') 
							  ,('NL0000000002', '335612647', 'B0774023') 
							  ,('NL0000000003', '270517233', 'B0775022')
							  ,('NL0000000004', '270527442', 'B0074041')
							  ,('NL0000000005', '225569746', 'B0742691')
							  ,('NL0000000008', '277459452', 'B0058044')

insert into KhachHangTE values('TE0000000006', '...', 'H2234'),
							  ('TE0000000007', '...', 'H3234')

insert into GheKhach values ('NL0000000001', 'A05', '6000000 vnd')
						   ,('NL0000000002', 'A06', '6000000 vnd')
						   ,('NL0000000003', 'B01', '2000000 vnd')
						   ,('NL0000000004', 'B02', '2000000 vnd')
						   ,('NL0000000005', 'B03', '2000000 vnd')
						   ,('NL0000000008', 'D09', '2000000 vnd')
						   ,('TE0000000006', 'A07', '5000000 vnd')
						   ,('TE0000000007', 'A08', '5000000 vnd')

insert into GheNgoi values ('A05', 'VIP', '1')
						  ,('A06', 'VIP', '1')
						  ,('B01', 'PT', '3')
						  ,('B02', 'PT', '3')
						  ,('B03', 'PT', '3')
						  ,('A07', 'VIP', '1')
						  ,('D09', 'PT', '4')
						  ,('A07', 'VIP', '1')

insert into ThucPham values (N'Trái Cây nhiệt đới', 'Các loại trái cây chua và ngọt')
						   ,(N'Bò xào lá ngón', 'Bò xào của mị')
						   ,(N'Bánh Mì thổ nhĩ kì', 'Bánh taco')
						   ,(N'Mì ý sốt pagetti', 'CÓ thể lựa chọn topping nhân')

insert into GiaThucPham values('250.000 vnd', '11/7/2018', '1')
							 ,('200.000 vnd', '11/7/2018', '2')
							 ,('100.000 vnd', '11/7/2018', '3')
							 ,('200.000 vnd', '11/7/2018', '4')

insert into ChuyenBayThucPham values('SA1234567', '1')
								   ,('SA1234568', '2')
                                   ,('SA1234568', '3')
                                   ,('SA1234569', '4')

insert into NhanVien values ('DH0000000001','DH',N'Trần Thị Hồng Nhung','1992/08/08','Nu',N'Việt Nam','336547599','','03/08/2011',N'Đa Kao, Quận 1, TP HCM','01110463139','10000000 VND')
exec InputStaff 'DH',N'Mai Văn Mạnh','1989/07/13','Nam',N'Việt Nam','156388729','','03/08/2011',N'Đa Kao, Quận 1, TP HCM','01914972215','10000000 VND'
exec InputStaff 'DH',N'Nguyễn Chí Thiện','1993/05/25','Nam',N'Việt Nam','527366967','4035219401','03/08/2011',N'Nguyễn Hữu Thọ, Tân Hưng, Quận 7, TP HCM','0169770263','120000000 VND'
exec InputStaff 'DH',N'Võ Đức Vĩnh','1989/10/15','Nu',N'Việt Nam','792912207','','03/08/2011',N'Nguyễn Hữu Thọ, Tân Hưng, Quận 7, TP HCM','0115654050','13000000 VND'
exec InputStaff 'KS',N'Phạm Văn Huy','1980/09/13','Nam',N'Việt Nam','	373138017','3120978841','8/8/2008',N'123, Láng Hạ, Đống Đa, Hà Nội','01315855726','20000000 VND'
exec InputStaff 'KS',N'Trần Trung Tín','1985/06/09','Nam',N'Việt Nam','601566429','7962005963','8/8/2008',N'Lộc An, Đất Đỏ, Vũng Tàu','01016986515','18000000 VND'
exec InputStaff 'KS',N'Lê An Cường','1983/09/06','Nam',N'Việt Nam','358942729','','8/8/2008',N'Lộc An, Đất Đỏ, Vũng Tàu','03928920152','20000000 VND'
exec InputStaff 'KS',N'Đặng Minh Nhật','1988/05/06','Nam',N'Việt Nam','369159329','','8/8/2008',N'Nguyễn Hữu Thọ, Tân Hưng, Quận 7, TP HCM','02241745134','1000000 VND'
exec InputStaff 'KT',N'Đặng Anh Tú','1995/03/13','Nam',N'Việt Nam','188831724','3118353218','7/1/2014',N'Ngọc Định, Định Quán, Đồng Nai','02660787759','15000000 VND'
exec InputStaff 'KT',N'Trần Thanh Phước','1990/01/30','Nam',N'Việt Nam','608138720','','7/1/2014',N'Đa Kao, Quận 1, TP HCM','01156916476','15000000 VND'
exec InputStaff 'KT',N'Lê Văn Vang','1988/09/18','Nam',N'Việt Nam','793081014','','7/1/2014',N'Đa Kao, Quận 1, TP HCM','09176459349','15000000 VND'
exec InputStaff 'KT',N'Nguyễn Thanh Hiên','1988/02/20','Nam',N'Việt Nam','441101882','1182916902','7/1/2014',N'Đa Kao, Quận 1, TP HCM','0169775125','15000000 VND'
exec InputStaff 'PC',N'Nguyễn Minh Tuấn','1979/10/08','Nam','Việt Nam','212894328','7121053462','5/17/2004','88/25 Truong Sa','08003219608','50000000 VND'
exec InputStaff 'PC',N'Phạm Ngọc Nam','1982/10/21','Nam',N'Việt Nam','	881101490','5816054015','3/1/2006',N'123, Láng Hạ, Đống Đa, Hà Nội','0162577488','30000000 VND'
exec InputStaff 'PC',N'Võ Hoàng Anh','1980/05/30','Nam',N'Việt Nam','208407948','2258425344','8/1/2001',N'Gia Canh, Định Quán, Đồng Nai','0800958652','30000000 VND'
exec InputStaff 'PC',N'John Witch','1971/05/13','Nam',N'Hoa Kỳ','608888729','5118383218','9/8/1996',N'Bahringerstad, VA 34700','01721351590','100000000 VND'
exec InputStaff 'TV',N'Tăng Nhật Tuệ','1993/04/20','Nu',N'Việt Nam','305553111','6438828904','9/8/2010',N'Đa Kao, Quận 1, TP HCM','08102496626','10000000 VND'
exec InputStaff 'TV',N'Nguyễn Dương Bảo Lam','1994/05/21','Nu',N'Việt Nam','451536233','5118383218','9/8/2010',N'Nguyễn Hữu Thọ, Tân Hưng, Quận 7, TP HCM','01721351590','10000000 VND'
exec InputStaff 'TV',N'Nguyễn Thị Ngọc Trinh','1994/05/13','Nu',N'Việt Nam','305553113','3980340341','9/8/2010',N'Đa Kao, Quận 1, TP HCM','0165691312','10000000 VND'
exec InputStaff 'TV',N'Trần Thị Thập Cẩm','1996/05/08','Nu',N'Việt Nam','606588759','1118383228','9/8/2010',N'Đa Kao, Quận 1, TP HCM','01114284405','10000000 VND'

insert into BangCap values (N'Cử Nhân',N'Hoc Viện Hàng Không',2010,'DH0000000001'),
						   (N'Thạc sĩ',N'Hoc Viện Hàng Không',2010,'DH0000000002'),
						   (N'Thạc sĩ',N'Hoc Viện Hàng Không',2010,'DH0000000003'),
						   (N'Tiến Sĩ',N'Hoc Viện Hàng Không',2009,'DH0000000004'),
						   (N'Tiến sĩ',N'Hoc Viện Hàng Không',2000,'KS0000000005'),
						   (N'Cử Nhân',N'Hoc Viện Hàng Không',1998,'KS0000000006'),
						   (N'Thạc sĩ',N'Hoc Viện Hàng Không',2000,'KS0000000007'),
						   (N'Cử Nhân',N'Đại Học Tôn Đức Thắng',2006,'KS0000000008'),
						   (N'Cử Nhân',N'Đại Học Bách Khoa',2010,'KT0000000009'),
						   (N'Cử Nhân',N'Đại Học Sư Phạm Kĩ Thuật',2013,'KT0000000010'),
						   (N'Tiến Sĩ',N'Đại Học Khoa Học Tự Nhiên',2012,'KT0000000011'),
						   (N'Thạc SĨ',N'Đại Học Tôn Đức Thắng',2010,'KT0000000012'),
						   (N'Tiến Sĩ',N'Hoc Viện Hàng Không',1998,'PC0000000013'),
						   (N'Tiến Sĩ',N'Hoc Viện Hàng Không',1996,'PC0000000014'),
						   (N'Tiến Sĩ',N'Hoc Viện Hàng Không',2000,'PC0000000015'),
						   (N'Tiến Sĩ',N'Học viện Hàng không Sierra, California, Hoa Kỳ',1993,'PC0000000016'),
						   (N'Cử Nhân',N'Hoc Viện Hàng Không',2007,'TV0000000017'),
						   (N'Cử Nhân',N'Hoc Viện Hàng Không',2008,'TV0000000018'),
						   (N'Cử Nhân',N'Đại Học Rmit',2008,'TV0000000019'),
						   (N'Cử Nhân',N'Đại Học Ngoại Thương',2009,'TV0000000020')

insert into PhiCong values ('PC0000000013','CT'),
						   ('PC0000000014','PL'),
						   ('PC0000000015','CT'),
						   ('PC0000000016','PL')

insert into TiepVien values  ('TV0000000017',N'Tiếng Pháp'),
						     ('TV0000000018',N'Tiếng Ý'),
						     ('TV0000000019',N'Tiếng Đức'),
						     ('TV0000000020',N'Tiếng Anh')

insert into ChiNhanh values  (N'Tân Sơn Nhất',N'Thành phố HCM',N'Việt Nam'),
						     (N'Đà Nẵng',N'Đà Nẵng',N'Việt Nam'),
							 (N'Phù Cát',N'Quy Nhơn',N'Việt Nam'),
							 (N'Nội Bài',N'Hà Nội',N'Việt Nam')

insert into CaLamViec values ('C1','09:00','13:30'),
						     ('C2','13:30','21:00'),
							 ('C3','21:00','05:00')

insert into NhanVienMD values ('DH0000000001','2','DH0000000001'),
						      ('DH0000000002','4','DH0000000002'),
							  ('DH0000000003','1','DH0000000003'),
							  ('DH0000000004','4','DH0000000004'),
							  ('KS0000000005','3','DH0000000001'),
							  ('KS0000000006','3','DH0000000003'),
							  ('KS0000000007','2','DH0000000004'),
							  ('KS0000000008','1','DH0000000002'),
							  ('KT0000000009','4','DH0000000001'),
							  ('KT0000000010','1','DH0000000002'),
							  ('KT0000000011','4','DH0000000004'),
							  ('KT0000000012','1','DH0000000003')

insert into NVMatDat_CaLV values ('DH0000000001','C1','12/8/2011'),
								 ('DH0000000002','C1','1/15/2011'),
							     ('DH0000000003','C2','2/7/2012'),
							     ('DH0000000004','C1','4/9/2011'),
							     ('KS0000000005','C2','4/8/2010'),
							     ('KS0000000006','C3','4/8/2009'),
							     ('KS0000000007','C1','1/8/2008'),
							     ('KS0000000008','C1','2/8/2008'),
							     ('KT0000000009','C1','12/1/2014'),
							     ('KT0000000010','C3','11/1/2015'),
							     ('KT0000000011','C2','9/1/2016'),
							     ('KT0000000012','C1','2/1/2017')

insert into VanHanh values ('PC0000000013','SA1234567'),
						   ('PC0000000014','SA1234567'),
						   ('PC0000000015','SA1234568'),
						   ('PC0000000016','SA1234568'),
						   ('TV0000000017','SA1234567'),
						   ('TV0000000018','SA1234567'),
						   ('TV0000000019','SA1234567'),
						   ('TV0000000020','SA1234568')

insert into Lai values ('PC0000000013','1'),
					   ('PC0000000014','1'),
					   ('PC0000000015','2'),
					   ('PC0000000016','2')

insert into KiemTra values ('KT0000000009','SA1234567'),
						   ('KT0000000010','SA1234568'),
						   ('KT0000000011','SA1234568'),
						   ('KT0000000012','SA1234569')

insert into ChuyenMonBD values ('KT0000000009','1'),
						       ('KT0000000010','2'),
						       ('KT0000000011','3'),
						       ('KT0000000012','4')


--- 2. Update ---
go
Update ChuyenBay
Set TrangThai = 'DB'
where TrangThai = 'CB'

--select * from VanHanh

go
Update KhachHang
Set MSTTTG = '2'
where MSTTTG = '1'

--- 3. Delete ---
Delete from ThucPham
where MSTP = '1'
-- Lỗi xóa: 
-- Ta Không thể xóa bảng ThucPham được vì bảng này liên kết đến 2 bảng ChuyenBayThucPham và GiaThucPham.
-- ta chỉ có thể xóa dữ liệu của nó khi và chỉ khi xóa dữ liệu về thực phẩm ở 2 bảng trên trước.

--- 4. Select ---
--a.--
Select NhanVien.MSNV, NhanVien.Hoten, NhanVien.SoDT, NhanVien.DiaChi
from NhanVien , VanHanh 
where NhanVien.MSNV = VanHanh.MSNV
	and VanHanh.MSCB = 'SA1234567'
GO
--b.--
Select NhanVien.MSNV, NhanVien.HoTen,CaLamViec.TuGio,CaLamViec.DenGio 
from NhanVien,CaLamViec,NVMatDat_CaLV
where NhanVien.MSNV = NVMatDat_CaLV.MSNV
  and NVMatDat_CaLV.MSCLV = CaLamViec.MSCLV	
  and NVMatDat_CaLV.MSCLV = 'C2'
--c.--
Select ChuyenBay.MSCB, ChuyenBay.SoGheTrong, ChuyenBay.ThoiDiemDi, TuyenBay.MSG_Di, TuyenBay.MSG_Den
from ChuyenBay,TuyenBay,Ga
where ChuyenBay.MSTB = TuyenBay.MSTB
and	  TuyenBay.MSG_Di = Ga.MSG	
and ChuyenBay.SoGheTrong > 0
--d.--
-- Vẫn chưa hoàn thiện

