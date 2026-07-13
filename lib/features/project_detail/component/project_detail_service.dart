import 'package:obm_gen_with_ai/core/base/services/base_service.dart';
import 'package:obm_gen_with_ai/features/project_detail/model/project_detail_model.dart';

class ProjectDetailService extends BaseService {
  ProjectDetailService(super.client);

  Future<ProjectDetailModel> getProjectDetail(int projectId) async {
    final result = await client.get<Map<String, dynamic>>(
      'http://10.168.6.37:9080/api/v1/projects/$projectId',
    );
    return ProjectDetailModel.fromJson(result.data!);
  }
}
