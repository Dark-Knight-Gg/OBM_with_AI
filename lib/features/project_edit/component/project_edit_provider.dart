import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:obm_gen_with_ai/core/base/base_provider.dart';
import 'package:obm_gen_with_ai/core/base/toast/toast_event.dart';
import 'package:obm_gen_with_ai/core/constants/app_strings.dart';
import 'package:obm_gen_with_ai/features/project_edit/component/project_edit_service.dart';
import 'package:obm_gen_with_ai/features/project_edit/model/project_edit_model.dart';
import 'package:obm_gen_with_ai/core/base/navigation/navigator_helper.dart';
import 'package:obm_gen_with_ai/core/base/navigation/navigate_event.dart';

class ProjectEditProvider extends BaseProvider<ProjectEditService> {
  final ProjectEditService _service;

  ProjectEditProvider(this._service) : super();

  ProjectEditService get service => _service;
  ProjectEditModel? project;
  StateType detailState = StateType.none;

  String nameValue = '';
  String statusValue = 'doing';
  int? projectManagerValue;
  DateTime? startDateValue;
  DateTime? endDateValue;
  String noteValue = '';

  String? nameError;

  void initForm(ProjectEditModel data) {
    project = data;
    nameValue = data.name ?? '';
    statusValue = data.statusCode ?? 'doing';
    projectManagerValue = data.projectManagerId;
    startDateValue = data.startDate != null ? DateTime.tryParse(data.startDate!) : null;
    endDateValue = data.endDate != null ? DateTime.tryParse(data.endDate!) : null;
    noteValue = data.note ?? '';
    notifyListeners();
  }

  Future<void> loadProjectDetail(int projectId) async {
    detailState = StateType.loading;
    notifyListeners();
    try {
      final res = await _service.getProjectDetail(projectId);
      project = ProjectEditModel(
        id: res.id,
        name: res.name,
        statusCode: res.statusCode,
        projectManagerId: res.projectManagerId,
        startDate: res.startDate,
        endDate: res.endDate,
        note: res.note,
      );
      nameValue = res.name ?? '';
      statusValue = res.statusCode ?? 'doing';
      projectManagerValue = res.projectManagerId;
      startDateValue = res.startDate != null ? DateTime.tryParse(res.startDate!) : null;
      endDateValue = res.endDate != null ? DateTime.tryParse(res.endDate!) : null;
      noteValue = res.note ?? '';
      detailState = StateType.loaded;
    } on DioException catch (e) {
      errorMessage = e.message ?? AppStrings.warningNotConnectInternet;
      detailState = StateType.error;
    } catch (e) {
      errorMessage = e.toString();
      detailState = StateType.error;
    }
    notifyListeners();
  }
  void changeStatusValue(String value){
    statusValue = value;
    notifyListeners();
  }
  void changeProjectManagerValue(int? value){
    projectManagerValue = value;
    notifyListeners();
  }


  void changeStartDateValue(DateTime? value){
    startDateValue = value;
    notifyListeners();
  }
  void changeEndDateValue(DateTime? value){
    endDateValue = value;
    notifyListeners();
  }

  Future<void> updateProject() async {
    nameError = null;

    if (nameValue.trim().isEmpty) {
      nameError = AppStrings.vuiLongNhapTenDuAn;
      notifyListeners();
      return;
    }

    showProgress();
    try {
      final data = ProjectEditModel(
        id: project?.id,
        name: nameValue.trim(),
        statusCode: statusValue,
        projectManagerId: projectManagerValue,
        startDate: startDateValue != null
            ? '${startDateValue!.year}-${startDateValue!.month.toString().padLeft(2, '0')}-${startDateValue!.day.toString().padLeft(2, '0')}'
            : null,
        endDate: endDateValue != null
            ? '${endDateValue!.year}-${endDateValue!.month.toString().padLeft(2, '0')}-${endDateValue!.day.toString().padLeft(2, '0')}'
            : null,
        note: noteValue.isNotEmpty ? noteValue : null,
      );
      await _service.updateProject(project!.id!, data);
      showToast(AppStrings.duAnDaDuocCapNhatThanhCong, type: ToastType.success);
      hideProgress();
      navigate(NavigateEvent.pop());
    }  catch (e) {
      hideProgress();
      showToast(AppStrings.warningNotConnectInternet, type: ToastType.error);
    }
  }
}
