import 'package:obm_gen_with_ai/core/base/services/base_service.dart';
import 'package:dio/dio.dart';
import 'package:obm_gen_with_ai/features/project_edit/model/project_edit_model.dart';

class ProjectEditService extends BaseService {
  ProjectEditService(Dio client) : super(client);

  Future<ProjectEditResponse> getProjectDetail(int projectId) async {
    final result = await client.get<Map<String, dynamic>>(
      'http://10.168.6.37:9080/api/v1/projects/$projectId',
    );
    return ProjectEditResponse.fromJson(result.data!);
  }

  Future<ProjectEditResponse> updateProject(int projectId, ProjectEditModel data) async {
    final result = await client.put<Map<String, dynamic>>(
      'http://10.168.6.37:9080/api/v1/projects/$projectId',
      data: data.toJson(),
    );
    return ProjectEditResponse.fromJson(result.data!);
  }
}
