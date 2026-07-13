import 'package:obm_gen_with_ai/core/base/services/base_service.dart';
import 'package:obm_gen_with_ai/features/list_contract_real/model/list_contract_real_model.dart';

class ListContractRealService extends BaseService {
  ListContractRealService(super.client);

  Future<ContractResponse> getContracts({
    required int page,
    int size = 20,
    String keyword = '',
    String status = '',
  }) async {
    final queryParams = <String, dynamic>{
      'page': page,
      'size': size,
      if (keyword.isNotEmpty) 'keyword': keyword,
      if (status.isNotEmpty) 'status': status,
    };

    final result = await client.get<Map<String, dynamic>>(
      'http://10.168.6.37:9080/api/v1/contracts',
      queryParameters: queryParams,
    );
    return ContractResponse.fromJson(result.data!);
  }

  Future<void> deleteContract(int contractId) async {
    await client.delete('http://10.168.6.37:9080/api/v1/contracts/$contractId');
  }
}
