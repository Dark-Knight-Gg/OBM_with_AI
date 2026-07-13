class DashboardRequest {
  final int year;
  final String priceType;
  final String? unit;
  final String? department;
  final String? productService;

  const DashboardRequest({
    required this.year,
    required this.priceType,
    this.unit,
    this.department,
    this.productService,
  });

  Map<String, dynamic> toJson() => {
        'year': year,
        'priceType': priceType,
        if (unit != null) 'unit': unit,
        if (department != null) 'department': department,
        if (productService != null) 'productService': productService,
      };
}

class DashboardResponse {
  final DashboardData? data;
  final int? status;
  final String? message;

  const DashboardResponse({
    this.data,
    this.status,
    this.message,
  });

  factory DashboardResponse.fromJson(Map<String, dynamic> json) {
    return DashboardResponse(
      data: json['data'] != null
          ? DashboardData.fromJson(json['data'] as Map<String, dynamic>)
          : null,
      status: json['status'] as int?,
      message: json['message'] as String?,
    );
  }
}

class DashboardData {
  final double? totalRevenueActual;
  final double? totalOrderValue;
  final double? expectedRevenue;
  final int? totalResources;
  final int? openRisks;
  final List<RevenueMonthData>? revenueByMonth;

  const DashboardData({
    this.totalRevenueActual,
    this.totalOrderValue,
    this.expectedRevenue,
    this.totalResources,
    this.openRisks,
    this.revenueByMonth,
  });

  factory DashboardData.fromJson(Map<String, dynamic> json) {
    return DashboardData(
      totalRevenueActual: (json['totalRevenueActual'] as num?)?.toDouble(),
      totalOrderValue: (json['totalOrderValue'] as num?)?.toDouble(),
      expectedRevenue: (json['expectedRevenue'] as num?)?.toDouble(),
      totalResources: json['totalResources'] as int?,
      openRisks: json['openRisks'] as int?,
      revenueByMonth: (json['revenueByMonth'] as List<dynamic>?)
          ?.map((e) => RevenueMonthData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class RevenueMonthData {
  final String? label;
  final double? value;

  const RevenueMonthData({this.label, this.value});

  factory RevenueMonthData.fromJson(Map<String, dynamic> json) {
    return RevenueMonthData(
      label: json['label'] as String?,
      value: (json['value'] as num?)?.toDouble(),
    );
  }
}

class FilterOptionsResponse {
  final FilterOptionsData? data;
  final int? status;
  final String? message;

  const FilterOptionsResponse({
    this.data,
    this.status,
    this.message,
  });

  factory FilterOptionsResponse.fromJson(Map<String, dynamic> json) {
    return FilterOptionsResponse(
      data: json['data'] != null
          ? FilterOptionsData.fromJson(json['data'] as Map<String, dynamic>)
          : null,
      status: json['status'] as int?,
      message: json['message'] as String?,
    );
  }
}

class FilterOptionsData {
  final List<String>? years;
  final List<String>? priceTypes;
  final List<OptionItem>? units;
  final List<OptionItem>? departments;
  final List<OptionItem>? productServices;

  const FilterOptionsData({
    this.years,
    this.priceTypes,
    this.units,
    this.departments,
    this.productServices,
  });

  factory FilterOptionsData.fromJson(Map<String, dynamic> json) {
    return FilterOptionsData(
      years: (json['years'] as List<dynamic>?)?.cast<String>(),
      priceTypes: (json['priceTypes'] as List<dynamic>?)?.cast<String>(),
      units: (json['lines'] as List<dynamic>?)
          ?.map((e) => OptionItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      departments: (json['depts'] as List<dynamic>?)
          ?.map((e) => OptionItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      productServices: (json['products'] as List<dynamic>?)
          ?.map((e) => OptionItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class OptionItem {
  final String? id;
  final String? name;

  const OptionItem({this.id, this.name});

  factory OptionItem.fromJson(Map<String, dynamic> json) {
    return OptionItem(
      id: json['id'].toString() as String?,
      name: json['name'] as String?,
    );
  }
}
