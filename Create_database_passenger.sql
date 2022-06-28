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