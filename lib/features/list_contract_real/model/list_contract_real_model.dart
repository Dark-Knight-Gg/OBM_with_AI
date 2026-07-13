import 'dart:ui';

class ContractModel {
  final int? id;
  final String? name;
  final String? contractNo;
  final String? customerName;
  final String? owningUnitName;
  final String? regionLabel;
  final String? typeLabel;
  final String? statusLabel;
  final String? statusBadge;
  final double? contractValue;
  final String? signedDate;
  final String? expiryDate;
  final String? linkLabel;

  const ContractModel({
    this.id,
    this.name,
    this.contractNo,
    this.customerName,
    this.owningUnitName,
    this.regionLabel,
    this.typeLabel,
    this.statusLabel,
    this.statusBadge,
    this.contractValue,
    this.signedDate,
    this.expiryDate,
    this.linkLabel,
  });

  factory ContractModel.fromJson(Map<String, dynamic> json) {
    return ContractModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
      contractNo: json['contractNo'] as String?,
      customerName: json['customerName'] as String?,
      owningUnitName: json['owningUnitName'] as String?,
      regionLabel: json['regionLabel'] as String?,
      typeLabel: json['typeLabel'] as String?,
      statusLabel: json['statusLabel'] as String?,
      statusBadge: json['statusBadge'] as String?,
      contractValue: (json['contractValue'] as num?)?.toDouble(),
      signedDate: json['signedDate'] as String?,
      expiryDate: json['expiryDate'] as String?,
      linkLabel: json['linkLabel'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (contractNo != null) 'contractNo': contractNo,
      if (customerName != null) 'customerName': customerName,
      if (owningUnitName != null) 'owningUnitName': owningUnitName,
      if (regionLabel != null) 'regionLabel': regionLabel,
      if (typeLabel != null) 'typeLabel': typeLabel,
      if (statusLabel != null) 'statusLabel': statusLabel,
      if (statusBadge != null) 'statusBadge': statusBadge,
      if (contractValue != null) 'contractValue': contractValue,
      if (signedDate != null) 'signedDate': signedDate,
      if (expiryDate != null) 'expiryDate': expiryDate,
      if (linkLabel != null) 'linkLabel': linkLabel,
    };
  }

  String get formattedValue {
    if (contractValue == null) return '---';
    return '${contractValue!.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]},')} đ';
  }

  Color get borderColor {
    switch (statusBadge) {
      case 'bg-success':
        return const Color(0xFF005F9E);
      case 'bg-primary':
        return const Color(0xFF005F9E);
      case 'bg-warning':
        return const Color(0xFFDE842F);
      default:
        return const Color(0xFF707882);
    }
  }

  Color get statusBgColor {
    switch (statusBadge) {
      case 'bg-success':
        return const Color(0xFFD1E7DD);
      default:
        return const Color(0xFFE0E3E5);
    }
  }

  Color get statusTextColor {
    switch (statusBadge) {
      case 'bg-success':
        return const Color(0xFF0A5D3B);
      default:
        return const Color(0xFF404751);
    }
  }

  bool get isActive =>
      statusBadge == 'bg-success' || statusBadge == 'bg-primary';
}

class ContractResponse {
  final List<ContractModel>? content;
  final int? page;
  final int? size;
  final int? totalElements;
  final int? totalPages;
  final bool? last;

  const ContractResponse({
    this.content,
    this.page,
    this.size,
    this.totalElements,
    this.totalPages,
    this.last,
  });

  factory ContractResponse.fromJson(Map<String, dynamic> json) {
    return ContractResponse(
      content: (json['content'] as List?)
          ?.map((e) => ContractModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      page: json['page'] as int?,
      size: json['size'] as int?,
      totalElements: json['totalElements'] as int?,
      totalPages: json['totalPages'] as int?,
      last: json['last'] as bool?,
    );
  }
}
