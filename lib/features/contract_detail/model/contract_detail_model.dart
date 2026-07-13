class ContractDetailModel {
  final int? id;
  final String? name;
  final String? contractNo;
  final String? owningUnitName;
  final String? customerName;
  final String? productServiceName;
  final String? opportunityName;
  final int? opportunityId;
  final String? projectName;
  final int? projectId;
  final String? regionLabel;
  final String? fieldLabel;
  final String? typeLabel;
  final String? statusLabel;
  final String? statusBadge;
  final String? signedDate;
  final String? acceptanceDate;
  final String? expiryDate;
  final String? bindingTerms;
  final double? contractValue;
  final int? durationMonths;
  final String? kmsLink;
  final String? managerName;
  final double? vnptValue;
  final double? itPercent;
  final double? vnptItValue;
  final String? note;
  final List<RevenueModel>? revenues;

  ContractDetailModel({
    this.id,
    this.name,
    this.contractNo,
    this.owningUnitName,
    this.customerName,
    this.productServiceName,
    this.opportunityName,
    this.opportunityId,
    this.projectName,
    this.projectId,
    this.regionLabel,
    this.fieldLabel,
    this.typeLabel,
    this.statusLabel,
    this.statusBadge,
    this.signedDate,
    this.acceptanceDate,
    this.expiryDate,
    this.bindingTerms,
    this.contractValue,
    this.durationMonths,
    this.kmsLink,
    this.managerName,
    this.vnptValue,
    this.itPercent,
    this.vnptItValue,
    this.note,
    this.revenues,
  });

  factory ContractDetailModel.fromJson(Map<String, dynamic> json) {
    return ContractDetailModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
      contractNo: json['contractNo'] as String?,
      owningUnitName: json['owningUnitName'] as String?,
      customerName: json['customerName'] as String?,
      productServiceName: json['productServiceName'] as String?,
      opportunityName: json['opportunityName'] as String?,
      opportunityId: json['opportunityId'] as int?,
      projectName: json['projectName'] as String?,
      projectId: json['projectId'] as int?,
      regionLabel: json['regionLabel'] as String?,
      fieldLabel: json['fieldLabel'] as String?,
      typeLabel: json['typeLabel'] as String?,
      statusLabel: json['statusLabel'] as String?,
      statusBadge: json['statusBadge'] as String?,
      signedDate: json['signedDate'] as String?,
      acceptanceDate: json['acceptanceDate'] as String?,
      expiryDate: json['expiryDate'] as String?,
      bindingTerms: json['bindingTerms'] as String?,
      contractValue: (json['contractValue'] as num?)?.toDouble(),
      durationMonths: json['durationMonths'] as int?,
      kmsLink: json['kmsLink'] as String?,
      managerName: json['managerName'] as String?,
      vnptValue: (json['vnptValue'] as num?)?.toDouble(),
      itPercent: (json['itPercent'] as num?)?.toDouble(),
      vnptItValue: (json['vnptItValue'] as num?)?.toDouble(),
      note: json['note'] as String?,
      revenues: (json['revenues'] as List?)
          ?.map((e) => RevenueModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'contractNo': contractNo,
        'owningUnitName': owningUnitName,
        'customerName': customerName,
        'productServiceName': productServiceName,
        'opportunityName': opportunityName,
        'opportunityId': opportunityId,
        'projectName': projectName,
        'projectId': projectId,
        'regionLabel': regionLabel,
        'fieldLabel': fieldLabel,
        'typeLabel': typeLabel,
        'statusLabel': statusLabel,
        'statusBadge': statusBadge,
        'signedDate': signedDate,
        'acceptanceDate': acceptanceDate,
        'expiryDate': expiryDate,
        'bindingTerms': bindingTerms,
        'contractValue': contractValue,
        'durationMonths': durationMonths,
        'kmsLink': kmsLink,
        'managerName': managerName,
        'vnptValue': vnptValue,
        'itPercent': itPercent,
        'vnptItValue': vnptItValue,
        'note': note,
        'revenues': revenues?.map((e) => e.toJson()).toList(),
      };
}

class RevenueModel {
  // Placeholder for revenues array items if needed
  RevenueModel();

  factory RevenueModel.fromJson(Map<String, dynamic> json) {
    return RevenueModel();
  }

  Map<String, dynamic> toJson() => {};
}
