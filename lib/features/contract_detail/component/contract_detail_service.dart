import 'package:obm_gen_with_ai/core/base/services/base_service.dart';
import 'package:obm_gen_with_ai/features/contract_detail/model/contract_detail_model.dart';

class ContractDetailService extends BaseService {
  ContractDetailService(super.client);

  Future<ContractDetailModel> getContractDetail(int id) async {
    final result = await client.get<Map<String, dynamic>>(
      'http://10.168.6.37:9080/api/v1/contracts/$id',
    );
    return ContractDetailModel.fromJson(result.data!);
  }
}
