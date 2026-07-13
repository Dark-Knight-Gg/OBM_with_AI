import 'package:dio/dio.dart';
import 'package:obm_gen_with_ai/core/base/base_provider.dart';
import 'package:obm_gen_with_ai/core/constants/app_strings.dart';
import 'package:obm_gen_with_ai/features/project_detail/component/project_detail_service.dart';
import 'package:obm_gen_with_ai/features/project_detail/model/project_detail_model.dart';

class ProjectDetailProvider extends BaseProvider<ProjectDetailService> {
  final ProjectDetailService _service;

  ProjectDetailProvider(this._service) : super();

  ProjectDetailService get service => _service;

  ProjectDetailModel? detail;

  Future<void> fetchProjectDetail(int projectId) async {
    showLoading();
    try {
      final res = await _service.getProjectDetail(projectId);
      detail = res;
      detail != null ? showLoaded() : showNoData();
    } on DioException catch (e) {
      errorMessage = e.message ?? AppStrings.warningNotConnectInternet;
      showError();
    } catch (e) {
      errorMessage = e.toString();
      showError();
    }
  }
}
