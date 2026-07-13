import 'base_response.dart';

class PublicServicesResponse extends BaseResponse<List<PublicServices>> {
  int? total;

  PublicServicesResponse({super.status, super.data, this.total});
  factory PublicServicesResponse.fromJson(Map<String, dynamic> json) {
    return PublicServicesResponse(
      status: StatusModel.fromJson({
        'err_code': json['err_code'],
        'message': json['message'],
      }),
      total: json['total'],
      data: json['data'] != null
          ? List<PublicServices>.from(
              json['data'].map((x) => PublicServices.fromJson(x)))
          : null,
    );
  }

  bool get isSuccess => status?.err_code == '0';
}

class PublicServices {
  String? dieuKien;
  String? bieuMauId;
  Null? danhSachCoQuan;
  int? thiDiem;
  int? thuTucId;
  String? phamVi;
  String? ma;
  int? loaiDvc;
  String? dieuKienChiTiet;
  Null? validateQueryJson;
  String? ketQua;
  int? id;
  String? chuanBi;
  String? ten;
  String? thuTucHanhChinh;
  int? status;
  String? icon;

  PublicServices(
      {this.dieuKien,
      this.bieuMauId,
      this.danhSachCoQuan,
      this.thiDiem,
      this.thuTucId,
      this.phamVi,
      this.ma,
      this.loaiDvc,
      this.dieuKienChiTiet,
      this.validateQueryJson,
      this.ketQua,
      this.id,
      this.chuanBi,
      this.ten,
      this.thuTucHanhChinh,
      this.status});

  PublicServices.fromJson(Map<String, dynamic> json) {
    dieuKien = json['dieuKien'];
    bieuMauId = json['bieuMauId'];
    danhSachCoQuan = json['danhSachCoQuan'];
    thiDiem = json['thiDiem'];
    thuTucId = json['thuTucId'];
    phamVi = json['phamVi'];
    ma = json['ma'];
    loaiDvc = json['loaiDvc'];
    dieuKienChiTiet = json['dieuKienChiTiet'];
    validateQueryJson = json['validateQueryJson'];
    ketQua = json['ketQua'];
    id = json['id'];
    chuanBi = json['chuanBi'];
    ten = json['ten'];
    thuTucHanhChinh = json['thuTucHanhChinh'];
    status = json['status'];
  }
}
