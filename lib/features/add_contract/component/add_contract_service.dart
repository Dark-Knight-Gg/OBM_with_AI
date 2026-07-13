import 'package:obm_gen_with_ai/core/base/services/base_service.dart';
import 'package:obm_gen_with_ai/features/add_contract/model/add_contract_model.dart';

class AddContractService extends BaseService {
  AddContractService(super.client);

  static const String _base = 'http://10.168.6.37:9080/api/v1';

  Future<FilterOptionsResponse> getFilterOptions() async {
    final result = await client.get<Map<String, dynamic>>('$_base/dashboard/filter-options');
    return FilterOptionsResponse.fromJson(result.data!);
  }

  Future<OpportunityResponse> getOpportunities({int page = 0, int size = 1000}) async {
    final result = await client.get<Map<String, dynamic>>(
      '$_base/opportunities',
      queryParameters: {'page': page, 'size': size},
    );
    return OpportunityResponse.fromJson(result.data!);
  }

  Future<ProjectRefResponse> getProjects({int page = 0, int size = 1000}) async {
    final result = await client.get<Map<String, dynamic>>(
      '$_base/projects',
      queryParameters: {'page': page, 'size': size},
    );
    return ProjectRefResponse.fromJson(result.data!);
  }

  Future<CustomerResponse> getCustomers({int page = 0, int size = 1000}) async {
    final result = await client.get<Map<String, dynamic>>(
      '$_base/customers',
      queryParameters: {'page': page, 'size': size},
    );
    return CustomerResponse.fromJson(result.data!);
  }

  Future<ProductServiceResponse> getProductServices({int page = 0, int size = 1000}) async {
    final result = await client.get<Map<String, dynamic>>(
      '$_base/product-services',
      queryParameters: {'page': page, 'size': size},
    );
    return ProductServiceResponse.fromJson(result.data!);
  }

  Future<Map<String, dynamic>> createContract(AddContractRequest req) async {
    final result = await client.post<Map<String, dynamic>>(
      'http://10.168.6.37:9080/contracts',
      data: req.toJson(),
    );
    return result.data ?? <String, dynamic>{};
  }
}