class BaseResponse<T> {
  StatusModel? status;
  T? data;

  BaseResponse({
    this.status,
    this.data,
  });

  BaseResponse.fromJson(
    Map<String, dynamic> json, {
    Function(Map<String, dynamic>)? dataFromJson,
  }) {
    status =
        (json['status'] != null) ? StatusModel.fromJson(json['status']) : null;

    final jsonData = json['data'];
    data = jsonData == null
        ? null
        : dataFromJson != null
            ? dataFromJson(jsonData)
            : jsonData.toString();
  }

  Map<String, dynamic> toJson({Map<String, dynamic> Function(T)? dataToJson}) {
    final json = <String, dynamic>{};
    if (status != null) {
      json['status'] = status!.toJson();
    }
    json['data'] = data == null
        ? null
        : dataToJson != null
            ? dataToJson(data as T)
            : data!;

    return json;
  }
}

class StatusModel {
  String? err_code;
  String? message;

  StatusModel({
    this.err_code,
    this.message,
  });

  bool get isSuccess => err_code == "0";

  StatusModel.fromJson(Map<String, dynamic> json) {
    err_code = json['err_code']?.toString();
    message = json['message']?.toString();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['err_code'] = err_code;
    data['message'] = message;
    return data;
  }
}
