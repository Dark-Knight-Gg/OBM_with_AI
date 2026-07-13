import 'package:obm_gen_with_ai/core/base/services/base_service.dart';
import 'package:obm_gen_with_ai/features/dashboard/model/dashboard_model.dart';

class DashboardService extends BaseService {
  DashboardService(super.client);

  Future<DashboardResponse> getDashboardData({
    required int year,
    required String priceType,
    String? unit,
    String? department,
    String? productService,
  }) async {
    final queryParams = <String, dynamic>{
      'year': year,
      'priceType': priceType,
    };
    if (unit != null && unit.isNotEmpty) queryParams['unit'] = unit;
    if (department != null && department.isNotEmpty) {
      queryParams['department'] = department;
    }
    if (productService != null && productService.isNotEmpty) {
      queryParams['productService'] = productService;
    }

    final response = await client.get<Map<String, dynamic>>(
      'http://10.168.6.37:9080/api/v1/dashboard',
      queryParameters: queryParams,
    );
    return DashboardResponse.fromJson(response.data as Map<String, dynamic>);
  }

  Future<FilterOptionsData> getFilterOptions() async {
    final response = await client.get<Map<String, dynamic>>(
      'http://10.168.6.37:9080/api/v1/dashboard/filter-options',
    );
    print('test');
    final test = FilterOptionsData.fromJson(response.data as Map<String, dynamic>);
    print('test');
    return FilterOptionsData.fromJson(response.data as Map<String, dynamic>);
  }
}
