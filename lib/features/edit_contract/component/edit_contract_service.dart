import 'package:obm_gen_with_ai/core/base/services/base_service.dart';
import 'package:obm_gen_with_ai/features/add_contract/component/add_contract_service.dart';
import 'package:obm_gen_with_ai/features/add_contract/model/add_contract_model.dart';
import 'package:obm_gen_with_ai/features/edit_contract/model/edit_contract_model.dart';

class EditContractService extends BaseService {
  EditContractService(super.client);

  static const String _base = 'http://10.168.6.37:9080/api/v1';

  // Reuse AddContractService dependency for filter endpoints
  late final AddContractService _deps = AddContractService(client);

  Future<FilterOptionsResponse> getFilterOptions() =>
      _deps.getFilterOptions();
  Future<OpportunityResponse> getOpportunities({int page = 0, int size = 1000}) =>
      _deps.getOpportunities(page: page, size: size);
  Future<ProjectRefResponse> getProjects({int page = 0, int size = 1000}) =>
      _deps.getProjects(page: page, size: size);
  Future<CustomerResponse> getCustomers({int page = 0, int size = 1000}) =>
      _deps.getCustomers(page: page, size: size);
  Future<ProductServiceResponse> getProductServices({
    int page = 0,
    int size = 1000,
  }) => _deps.getProductServices(page: page, size: size);

  Future<ContractDetailModel> getContract(int id) async {
    final result = await client.get<Map<String, dynamic>>(
      '$_base/contracts/$id',
    );
    final data = result.data ?? <String, dynamic>{};
    return ContractDetailModel.fromJson(data);
  }

  Future<Map<String, dynamic>> updateContract(
    int id,
    Map<String, dynamic> body,
  ) async {
    final result = await client.put<Map<String, dynamic>>(
      '$_base/contracts/$id',
      data: body,
    );
    return result.data ?? <String, dynamic>{};
  }
}
