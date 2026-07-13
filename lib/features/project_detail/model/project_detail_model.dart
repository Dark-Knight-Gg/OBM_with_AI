class ProjectDetailModel {
  final int? id;
  final String? code;
  final String? name;
  final String? customerName;
  final String? owningUnitName;
  final String? projectManagerName;
  final String? productCategoryName;
  final String? fieldLabel;
  final String? jiraProjectKey;
  final double? estimatedValue;
  final double? forecastRevenue;
  final String? statusCode;
  final String? statusLabel;
  final String? statusBadge;
  final String? startDate;
  final String? endDate;
  final String? note;
  final int? opportunityId;
  final String? opportunityCode;

  const ProjectDetailModel({
    this.id,
    this.code,
    this.name,
    this.customerName,
    this.owningUnitName,
    this.projectManagerName,
    this.productCategoryName,
    this.fieldLabel,
    this.jiraProjectKey,
    this.estimatedValue,
    this.forecastRevenue,
    this.statusCode,
    this.statusLabel,
    this.statusBadge,
    this.startDate,
    this.endDate,
    this.note,
    this.opportunityId,
    this.opportunityCode,
  });

  factory ProjectDetailModel.fromJson(Map<String, dynamic> json) {
    return ProjectDetailModel(
      id: json['id'] as int?,
      code: json['code'] as String?,
      name: json['name'] as String?,
      customerName: json['customerName'] as String?,
      owningUnitName: json['owningUnitName'] as String?,
      projectManagerName: json['projectManagerName'] as String?,
      productCategoryName: json['productCategoryName'] as String?,
      fieldLabel: json['fieldLabel'] as String?,
      jiraProjectKey: json['jiraProjectKey'] as String?,
      estimatedValue: (json['estimatedValue'] as num?)?.toDouble(),
      forecastRevenue: (json['forecastRevenue'] as num?)?.toDouble(),
      statusCode: json['statusCode'] as String?,
      statusLabel: json['statusLabel'] as String?,
      statusBadge: json['statusBadge'] as String?,
      startDate: json['startDate'] as String?,
      endDate: json['endDate'] as String?,
      note: json['note'] as String?,
      opportunityId: json['opportunityId'] as int?,
      opportunityCode: json['opportunityCode'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'name': name,
      'customerName': customerName,
      'owningUnitName': owningUnitName,
      'projectManagerName': projectManagerName,
      'productCategoryName': productCategoryName,
      'fieldLabel': fieldLabel,
      'jiraProjectKey': jiraProjectKey,
      'estimatedValue': estimatedValue,
      'forecastRevenue': forecastRevenue,
      'statusCode': statusCode,
      'statusLabel': statusLabel,
      'statusBadge': statusBadge,
      'startDate': startDate,
      'endDate': endDate,
      'note': note,
      'opportunityId': opportunityId,
      'opportunityCode': opportunityCode,
    };
  }
}

class ProjectDetailResponse {
  final ProjectDetailModel? data;
  final int? status;
  final String? message;

  const ProjectDetailResponse({this.data, this.status, this.message});

  factory ProjectDetailResponse.fromJson(Map<String, dynamic> json) {
    return ProjectDetailResponse(
      data: json['data'] != null
          ? ProjectDetailModel.fromJson(json['data'] as Map<String, dynamic>)
          : null,
      status: json['status'] as int?,
      message: json['message'] as String?,
    );
  }
}
