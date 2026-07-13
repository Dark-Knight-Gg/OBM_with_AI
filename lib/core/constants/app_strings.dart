import 'package:easy_localization/easy_localization.dart';

class AppStrings {
  static String get openSettings => 'openSettings'.tr();
  static String get warningOTPEmpty => 'warningOTPEmpty'.tr();
  static String get warningOTPSix => 'warningOTPSix'.tr();
  static String get contentLoading => 'contentLoading'.tr();
  static String get notification => 'notification'.tr();
  static String get close => 'close'.tr();
  static String get noData => 'noData'.tr();
  static String get done => 'done'.tr();
  static String get warningExpiredLogin => 'warningExpiredLogin'.tr();
  static String get warningNotConnectInternet =>
      'warningNotConnectInternet'.tr();
  static String get warningTimeConnect => 'warningTimeConnect'.tr();
  static String get warningNotFound => 'warningNotFound'.tr();
  static String get warningLogin => 'warningLogin'.tr();
  static String get warningLoginPassword => 'warningLoginPassword'.tr();
  static String get refreshData => 'refreshData'.tr();
  static String get downloadDataSuccess => 'downloadDataSuccess'.tr();
  static String get downloadDataFail => 'downloadDataFail'.tr();
  static String get dragLoadMore => 'dragLoadMore'.tr();
  static String get loadMore => 'loadMore'.tr();
  static String get noMoreData => 'noMoreData'.tr();
  static String get ngayThangNam => 'ngayThangNam'.tr();
  static String get vuiLongKhongDeTrong => 'vuiLongKhongDeTrong'.tr();
  static String vuiLongNhapHanXuLyKhongBeHonNgayHienTai(String date) =>
      'vuiLongNhapHanXuLyKhongBeHonNgayHienTai'.tr(namedArgs: {'date': date});
  static String get nhapDungDinhDangNgayThangNam =>
      'nhapDungDinhDangNgayThangNam'.tr();
  static String get thangKhongHopLe => 'thangKhongHopLe'.tr();
  static String get ngayKhongHopLe => 'ngayKhongHopLe'.tr();
  static String get namKhongHopLe => 'namKhongHopLe'.tr();
  static String get thang2ChiCo28Hoac29Ngay => 'thang2ChiCo28Hoac29Ngay'.tr();
  static String thangChiCo30ngay(int thang) =>
      'thangChiCo30ngay'.tr(namedArgs: {'thang': thang.toString()});
  static String namChiCo28ngay(int nam) =>
      'namChiCo28ngay'.tr(namedArgs: {'nam': nam.toString()});
  static String get chooseDay => 'chooseDay'.tr();
  static String get chooseTime => 'chooseTime'.tr();
  static String get typingDay => 'typingDay'.tr();
  static String get reloadStr => 'reloadStr'.tr();
  static String get continueStr => 'continueStr'.tr();
  static String get huy => 'huy'.tr();
  static String get xacNhan => 'xacNhan'.tr();
  static String get xoa => 'xoa'.tr();
  static String get tatCa => 'tatCa'.tr();
  static String get khongCoHopDong => 'khongCoHopDong'.tr();
  static String get timKiemHopDong => 'timKiemHopDong'.tr();
  static String hienThiSoHopDong(int count) =>
      'hienThiSoHopDong'.tr(namedArgs: {'count': count.toString()});
  static String get xacNhanXoa => 'xacNhanXoa'.tr();
  static String xoaHopDongThanhCong(String name) =>
      'xoaHopDongThanhCong'.tr(namedArgs: {'name': name});
  static String banCoChacChanMuonXoaHopDong(String name) =>
      'banCoChacChanMuonXoaHopDong'.tr(namedArgs: {'name': name});
  static String get soHd => 'soHd'.tr();
  static String get ngayKy => 'ngayKy'.tr();
  static String get loai => 'loai'.tr();
  static String get lienKet => 'lienKet'.tr();
  static String get giaTri => 'giaTri'.tr();
  static String get hopDong => 'hopDong'.tr();

  static String get welcome => 'welcome'.tr();
  static String get titleMiniApp => 'titleMiniApp'.tr();
  static String get recentServices => 'recentServices'.tr();
  static String get recommentServices => 'recommentServices'.tr();
  static String get seeMore => 'seeMore'.tr();
  static String get seeAll => 'seeAll'.tr();
  static String get proccesing => 'proccesing'.tr();
  static String get titleBottomHome => 'titleBottomHome'.tr();
  static String get titleBottomSearch => 'titleBottomSearch'.tr();
  static String get titleBottomUser => 'titleBottomUser'.tr();
  static String get partyPublicServices => 'partyPublicServices'.tr();
  static String get welcomeTo => 'welcomeTo'.tr();
  static String get recentService => 'recentService'.tr();
  static String get viewAll => 'viewAll'.tr();

  static String get loginTitle => 'loginTitle'.tr();
  static String get loginUsernameLabel => 'loginUsernameLabel'.tr();
  static String get loginUsernameHint => 'loginUsernameHint'.tr();
  static String get loginPasswordLabel => 'loginPasswordLabel'.tr();
  static String get loginPasswordHint => 'loginPasswordHint'.tr();
  static String get loginRememberAccount => 'loginRememberAccount'.tr();
  static String get loginButton => 'loginButton'.tr();
  static String get loginWithFace => 'loginWithFace'.tr();
  static String get loginFooterAttribution => 'loginFooterAttribution'.tr();
  static String get loginSuccessDemo => 'loginSuccessDemo'.tr();
  static String get loginBiometricComingSoon => 'loginBiometricComingSoon'.tr();

  // Event strings
  static String get eventTitle => 'eventTitle'.tr();
  static String get eventOngoing => 'eventOngoing'.tr();
  static String get eventUpcoming => 'eventUpcoming'.tr();
  static String get eventPast => 'eventPast'.tr();
  static String get eventGuest => 'eventGuest'.tr();
  static String get eventPeople => 'eventPeople'.tr();
  static String get eventAttendees => 'eventAttendees'.tr();

  // Splash screen strings
  static String get splashTagline => 'splashTagline'.tr();
  static String get splashLoading => 'splashLoading'.tr();

  // Login screen strings
  static String get brandName => 'brandName'.tr();
  static String get brandTagline => 'brandTagline'.tr();
  static String get loginSubtitle => 'loginSubtitle'.tr();
  static String get logoutMessage => 'logoutMessage'.tr();
  static String get loginEmailLabel => 'loginEmailLabel'.tr();
  static String get loginEmailHint => 'loginEmailHint'.tr();
  static String get loginProcessing => 'loginProcessing'.tr();
  static String get loginSuccess => 'loginSuccess'.tr();
  static String get loginDemoAccount => 'loginDemoAccount'.tr();
  static String get loginDemoCredentials => 'loginDemoCredentials'.tr();
  static String get loginFooterSystem => 'loginFooterSystem'.tr();
  static String get loginSupport => 'loginSupport'.tr();
  static String get loginPrivacyPolicy => 'loginPrivacyPolicy'.tr();

  // Provider-level strings
  static String get vuiLongNhapEmail => 'vuiLongNhapEmail'.tr();
  static String get emailKhongDungDinhDang => 'emailKhongDungDinhDang'.tr();
  static String get vuiLongNhapMatKhau => 'vuiLongNhapMatKhau'.tr();
  static String get emailHoacMatKhauKhongChinhXac =>
      'emailHoacMatKhauKhongChinhXac'.tr();
  static String get khongTheKetNoiMauChu => 'khongTheKetNoiMauChu'.tr();
  static String get dangNhapThanhCong => 'dangNhapThanhCong'.tr();

  // Contract Detail screen strings
  static String get chiTietHopDong => 'chiTietHopDong'.tr();
  static String get lienKetVaPhanLoai => 'lienKetVaPhanLoai'.tr();
  static String get thongTinHopDong => 'thongTinHopDong'.tr();
  static String get mocThoiGian => 'mocThoiGian'.tr();
  static String get dieuKhoanVaGhiChu => 'dieuKhoanVaGhiChu'.tr();
  static String get spDvCungCap => 'spDvCungCap'.tr();
  static String get diaBan => 'diaBan'.tr();
  static String get duAn => 'duAn'.tr();
  static String get soHopDong => 'soHopDong'.tr();
  static String get loaiHopDong => 'loaiHopDong'.tr();
  static String get nhanSuChuyenQuan => 'nhanSuChuyenQuan'.tr();
  static String get thoiGianThueBhThang => 'thoiGianThueBhThang'.tr();
  static String get ngayKyHd => 'ngayKyHd'.tr();
  static String get ngayNghiemThuVaoSd => 'ngayNghiemThuVaoSd'.tr();
  static String get hetHanHdBhbt => 'hetHanHdBhbt'.tr();
  static String get giaTriHd => 'giaTriHd'.tr();
  static String get giaTriVeVnpt => 'giaTriVeVnpt'.tr();
  static String get tiLeVeIt => 'tiLeVeIt'.tr();
  static String get tongGiaTriVnptIt => 'tongGiaTriVnptIt'.tr();
  static String get dieuKhoanRangBuoc => 'dieuKhoanRangBuoc'.tr();
  static String get dashDash => 'dashDash'.tr();
  static String get hopDongKhongTonTai => 'hopDongKhongTonTai'.tr();

  // Splash screen strings
  static String get dasObm => 'dasObm'.tr();
  static String get heThongQuanTriCoHoiDieuHanhKinhDoanh =>
      'heThongQuanTriCoHoiDieuHanhKinhDoanh'.tr();
  static String get slogan => 'slogan'.tr();
  static String get poweredByTrungTamDas => 'poweredByTrungTamDas'.tr();
  static String get enterpriseEdition => 'enterpriseEdition'.tr();
  static String get hoTro => 'hoTro'.tr();
  static String get chinhSachBaoMat => 'chinhSachBaoMat'.tr();

  // Dashboard strings
  static String get dashboardTitle => 'dashboardTitle'.tr();
  static String get dashboardSubtitle => 'dashboardSubtitle'.tr();
  static String get totalRevenue => 'totalRevenue'.tr();
  static String get totalOrders => 'totalOrders'.tr();
  static String get expectedRevenue => 'expectedRevenue'.tr();
  static String get totalResources => 'totalResources'.tr();
  static String get openRisks => 'openRisks'.tr();
  static String get revenueTrend => 'revenueTrend'.tr();
  static String get filterReports => 'filterReports'.tr();
  static String get hideFilters => 'hideFilters'.tr();
  static String get showFilters => 'showFilters'.tr();
  static String get filterResults => 'filterResults'.tr();
  static String get year => 'year'.tr();
  static String get priceType => 'priceType'.tr();
  static String get unit => 'unit'.tr();
  static String get department => 'department'.tr();
  static String get productService => 'productService'.tr();
  static String get all => 'all'.tr();
  static String get revenueNote => 'revenueNote'.tr();
  static String get revenueReportLink => 'revenueReportLink'.tr();
  static String get opportunity => 'opportunity'.tr();
  static String get production => 'production'.tr();
  static String get resourceManage => 'resourceManage'.tr();
  static String get searchResource => 'searchResource'.tr();
  static String get projectManagement => 'projectManagement'.tr();
  static String get contracts => 'contracts'.tr();
  static String get focus => 'focus'.tr();
  static String get productsServices => 'productsServices'.tr();
  static String get revenueTracking => 'revenueTracking'.tr();
  static String get annualRevenueReport => 'annualRevenueReport'.tr();
  static String get annualRevenuePlanReport => 'annualRevenuePlanReport'.tr();
  static String get serverInfrastructure => 'serverInfrastructure'.tr();
  static String get infrastructureDashboard => 'infrastructureDashboard'.tr();
  static String get revenueExpense => 'revenueExpense'.tr();
  static String get logout => 'logout'.tr();
  static String get dashboardOverview => 'dashboardOverview'.tr();
  static String get businessSection => 'businessSection'.tr();
  static String get operationRevenue => 'operationRevenue'.tr();
  static String get resourceSection => 'resourceSection'.tr();
  static String get adminSection => 'adminSection'.tr();
  static String get systemSection => 'systemSection'.tr();
  static String get generalConfig => 'generalConfig'.tr();
  static String get userManagement => 'userManagement'.tr();
  static String get organization => 'organization'.tr();
  static String get policyPermission => 'policyPermission'.tr();
  static String get adminRole => 'adminRole'.tr();
  static String get nhapSanLuong => 'nhapSanLuong'.tr();

  // List Contract screen strings
  static String get quanLyDuAn => 'quanLyDuAn'.tr();
  static String get maHoacTenDuAn => 'maHoacTenDuAn'.tr();
  static String hienThiCongDuAn(int count) =>
      'hienThiCongDuAn'.tr(namedArgs: {'count': count.toString()});
  static String get boLocNangCao => 'boLocNangCao'.tr();
  static String get trangThai => 'trangThai'.tr();
  static String get donViChuTri => 'donViChuTri'.tr();
  static String get linhVuc => 'linhVuc'.tr();
  static String get apDung => 'apDung'.tr();
  static String get khachHang => 'khachHang'.tr();
  static String get quanLyDA => 'quanLyDA'.tr();
  static String get coHoiNguon => 'coHoiNguon'.tr();
  static String get tienDo => 'tienDo'.tr();
  static String get duKienForecast => 'duKienForecast'.tr();
  static String get chinhSua => 'chinhSua'.tr();
  static String get xem => 'xem'.tr();
  static String get khongCoDuAn => 'khongCoDuAn'.tr();
  static String get tyGia => 'tyGia'.tr();
  static String get lapKeHoach => 'lapKeHoach'.tr();
  static String get dangThucHien => 'dangThucHien'.tr();
  static String get tamDung => 'tamDung'.tr();
  static String get hoanThanh => 'hoanThanh'.tr();
  static String get daHuy => 'daHuy'.tr();

  // Project Detail screen strings
  static String get chiTietDuAn => 'chiTietDuAn'.tr();
  static String get suaDuAn => 'suaDuAn'.tr();
  static String get tenDuAn => 'tenDuAn'.tr();
  static String get nhapTenDuAn => 'nhapTenDuAn'.tr();
  static String get vuiLongNhapTenDuAn => 'vuiLongNhapTenDuAn'.tr();
  static String get quanLyDuAnPM => 'quanLyDuAnPM'.tr();
  static String get nhapGhiChuDuAn => 'nhapGhiChuDuAn'.tr();
  static String get duAnDaDuocCapNhatThanhCong => 'duAnDaDuocCapNhatThanhCong'.tr();
  static String get luu => 'luu'.tr();
  static String get thongTinChung => 'thongTinChung'.tr();
  static String get keThuaTuCoHoi => 'keThuaTuCoHoi'.tr();
  static String get loaiSPDichVu => 'loaiSPDichVu'.tr();
  static String get maJiraProject => 'maJiraProject'.tr();
  static String get tienDoCongViecTheoDoiQuaJira => 'tienDoCongViecTheoDoiQuaJira'.tr();
  static String get ngayBatDau => 'ngayBatDau'.tr();
  static String get ngayKetThuc => 'ngayKetThuc'.tr();
  static String get giaTriDong => 'giaTriDong'.tr();
  static String get tongMucDuKien => 'tongMucDuKien'.tr();
  static String get forecast => 'forecast'.tr();
  static String get ghiChu => 'ghiChu'.tr();
  static String get quanLyOCoHoi => 'quanLyOCoHoi'.tr();
  static String get tinhNangDangPhatTrien => 'tinhNangDangPhatTrien'.tr();

  // Add Contract screen strings
  static String get themMoiHopDong => 'themMoiHopDong'.tr();
  static String get chonDonVi => 'chonDonVi'.tr();
  static String get khong => 'khong'.tr();
  static String get timKhachHangTheoTenHoacMa => 'timKhachHangTheoTenHoacMa'.tr();
  static String get chonSpDv => 'chonSpDv'.tr();
  static String get tenHopDongHoacTenDuAn => 'tenHopDongHoacTenDuAn'.tr();
  static String get deTrongSeLayTheoCoHoi => 'deTrongSeLayTheoCoHoi'.tr();
  static String get chonLoai => 'chonLoai'.tr();
  static String get chonTrangThai => 'chonTrangThai'.tr();
  static String get trangThaiHopDong => 'trangThaiHopDong'.tr();
  static String get linkKmsFileHopDong => 'linkKmsFileHopDong'.tr();
  static String get ganCoHoiChkd => 'ganCoHoiChkd'.tr();
  static String get ganDuAn => 'ganDuAn'.tr();
  static String get luuHopDong => 'luuHopDong'.tr();
  static String get luuHopDongThanhCong => 'luuHopDongThanhCong'.tr();
  static String get truongNayLaBatBuoc => 'truongNayLaBatBuoc'.tr();
  static String get ngayHetHanKhongNhoHonNgayKy => 'ngayHetHanKhongNhoHonNgayKy'.tr();
  static String get chonNgay => 'chonNgay'.tr();
  static String get deTrongBangVnptNhanPhanTramIt => 'deTrongBangVnptNhanPhanTramIt'.tr();
  static String get giaTriVeVnptIt => 'giaTriVeVnptIt'.tr();

  // Edit Contract screen strings
  static String get suaHopDong => 'suaHopDong'.tr();
  static String get capNhatHopDong => 'capNhatHopDong'.tr();
  static String get hopDongDaDuocCapNhatThanhCong =>
      'hopDongDaDuocCapNhatThanhCong'.tr();
}
