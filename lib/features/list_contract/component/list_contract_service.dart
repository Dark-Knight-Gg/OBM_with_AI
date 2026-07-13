import 'package:obm_gen_with_ai/core/base/services/base_service.dart';
import 'package:obm_gen_with_ai/features/list_contract/model/list_contract_model.dart';

class ListContractService extends BaseService {
  ListContractService(super.client);

  Future<ListContractResponse> getProjects({
    required int page,
    int size = 20,
    String keyword = '',
    String status = '',
    String field = '',
    int? unitId,
  }) async {
    final queryParams = <String, dynamic>{
      'page': page,
      'size': size,
      'keyword': keyword,
      'status': status,
      'field': field,
      if (unitId != null) 'unitId': unitId,
    };

    final result = await client.get<Map<String, dynamic>>(
      'http://10.168.6.37:9080/api/v1/projects',
      queryParameters: queryParams,
    );
    return ListContractResponse.fromJson(result.data!);
  }

  Future<FilterOptionsResponse> getFilterOptions() async {
    final result = await client.get<Map<String, dynamic>>(
      'http://10.168.6.37:9080/api/v1/dashboard/filter-options',
    );
    return FilterOptionsResponse.fromJson(result.data!);
  }
}
