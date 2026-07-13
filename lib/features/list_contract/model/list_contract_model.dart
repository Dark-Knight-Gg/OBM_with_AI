import 'package:obm_gen_with_ai/core/constants/app_strings.dart';

class ListContractModel {
  final int? id;
  final String? code;
  final String? name;
  final String? customerName;
  final String? owningUnitName;
  final String? projectManagerName;
  final String? statusLabel;
  final String? statusBadge;
  final double? estimatedValue;
  final double? forecastRevenue;
  final String? startDate;
  final String? endDate;
  final int? opportunityId;
  final String? opportunityCode;
  final int? progress;

  const ListContractModel({
    this.id,
    this.code,
    this.name,
    this.customerName,
    this.owningUnitName,
    this.projectManagerName,
    this.statusLabel,
    this.statusBadge,
    this.estimatedValue,
    this.forecastRevenue,
    this.startDate,
    this.endDate,
    this.opportunityId,
    this.opportunityCode,
    this.progress,
  });

  factory ListContractModel.fromJson(Map<String, dynamic> json) {
    return ListContractModel(
      id: json['id'] as int?,
      code: json['code'] as String?,
      name: json['name'] as String?,
      customerName: json['customerName'] as String?,
      owningUnitName: json['owningUnitName'] as String?,
      projectManagerName: json['projectManagerName'] as String?,
      statusLabel: json['statusLabel'] as String?,
      statusBadge: json['statusBadge'] as String?,
      estimatedValue: (json['estimatedValue'] as num?)?.toDouble(),
      forecastRevenue: (json['forecastRevenue'] as num?)?.toDouble(),
      startDate: json['startDate'] as String?,
      endDate: json['endDate'] as String?,
      opportunityId: json['opportunityId'] as int?,
      opportunityCode: json['opportunityCode'] as String?,
      progress: _parseProgress(json),
    );
  }

  static int? _parseProgress(Map<String, dynamic> json) {
    final progressStr = json['progress'] as String?;
    if (progressStr != null) {
      return int.tryParse(progressStr.replaceAll('%', '').trim());
    }
    final progressNum = json['progress'] as num?;
    return progressNum?.toInt();
  }

  String get formattedForecastRevenue {
    if (forecastRevenue == null) return '---';
    return _formatCurrency(forecastRevenue!);
  }

  String _formatCurrency(double? amount) {
    if (amount == null) return '—';
    return '${amount.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]},')} đ';
  }
}

class ListContractResponse {
  final List<ListContractModel>? content;
  final int? page;
  final int? size;
  final int? totalElements;
  final int? totalPages;
  final bool? last;

  const ListContractResponse({
    this.content,
    this.page,
    this.size,
    this.totalElements,
    this.totalPages,
    this.last,
  });

  factory ListContractResponse.fromJson(Map<String, dynamic> json) {
    return ListContractResponse(
      content: (json['content'] as List?)
          ?.map((e) => ListContractModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      page: json['page'] as int?,
      size: json['size'] as int?,
      totalElements: json['totalElements'] as int?,
      totalPages: json['totalPages'] as int?,
      last: json['last'] as bool?,
    );
  }
}

class FilterOptionsResponse {
  final List<DeptModel>? depts;

  const FilterOptionsResponse({this.depts});

  factory FilterOptionsResponse.fromJson(Map<String, dynamic> json) {
    return FilterOptionsResponse(
      depts: (json['depts'] as List?)
          ?.map((e) => DeptModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class DeptModel {
  final int? id;
  final String? name;
  final int? parentId;

  const DeptModel({this.id, this.name, this.parentId});

  factory DeptModel.fromJson(Map<String, dynamic> json) {
    return DeptModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
      parentId: json['parentId'] as int?,
    );
  }
}
