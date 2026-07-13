import 'package:dio/dio.dart';
import 'package:obm_gen_with_ai/core/base/base_provider.dart';
import 'package:obm_gen_with_ai/core/base/toast/toast_event.dart';
import 'package:obm_gen_with_ai/core/constants/app_strings.dart';
import 'package:obm_gen_with_ai/features/list_contract/component/list_contract_service.dart';
import 'package:obm_gen_with_ai/features/list_contract/model/list_contract_model.dart';

class ListContractProvider extends BaseProvider<ListContractService> {
  final ListContractService _service;

  ListContractProvider(this._service) : super();

  ListContractService get service => _service;

  List<ListContractModel> projects = const [];
  List<DeptModel> depts = const [];

  String keyword = '';
  String selectedStatus = '';
  String selectedField = '';
  int? selectedUnitId;

  int currentPage = 0;
  bool hasMore = true;

  @override
  void onStart() {
    super.onStart();
    loadProjects();
    loadFilterOptions();
  }

  Future<void> loadProjects() async {
    showLoading();
    try {
      final res = await _service.getProjects(
        page: 0,
        keyword: keyword,
        status: selectedStatus,
        field: selectedField,
        unitId: selectedUnitId,
      );
      projects = res.content ?? const [];
      currentPage = 0;
      hasMore = !(res.last ?? true);
      projects.isEmpty ? showNoData() : showLoaded();
    } on DioException catch (e) {
      errorMessage = e.message ?? AppStrings.warningNotConnectInternet;
      showError();
    } catch (e) {
      errorMessage = e.toString();
      showError();
    }
  }

  Future<void> loadMoreProjects() async {
    if (!hasMore) return;
    try {
      final res = await _service.getProjects(
        page: currentPage + 1,
        keyword: keyword,
        status: selectedStatus,
        field: selectedField,
        unitId: selectedUnitId,
      );
      projects = [...projects, ...(res.content ?? const [])];
      currentPage++;
      hasMore = !(res.last ?? true);
      showLoaded();
    } on DioException catch (e) {
      showToast(
        e.message ?? AppStrings.warningNotConnectInternet,
        type: ToastType.error,
      );
    } catch (e) {
      showToast(e.toString(), type: ToastType.error);
    }
  }

  Future<void> searchProjects(String value) async {
    keyword = value;
    currentPage = 0;
    showLoading();
    try {
      final res = await _service.getProjects(
        page: 0,
        keyword: value,
        status: selectedStatus,
        field: selectedField,
        unitId: selectedUnitId,
      );
      projects = res.content ?? const [];
      hasMore = !(res.last ?? true);
      projects.isEmpty ? showNoData() : showLoaded();
    } on DioException catch (e) {
      errorMessage = e.message ?? AppStrings.warningNotConnectInternet;
      showError();
    } catch (e) {
      errorMessage = e.toString();
      showError();
    }
  }

  Future<void> applyFilters({
    String? status,
    String? field,
    int? unitId,
  }) async {
    selectedStatus = status ?? '';
    selectedField = field ?? '';
    selectedUnitId = unitId;
    currentPage = 0;
    showLoading();
    try {
      final res = await _service.getProjects(
        page: 0,
        keyword: keyword,
        status: selectedStatus,
        field: selectedField,
        unitId: selectedUnitId,
      );
      projects = res.content ?? const [];
      hasMore = !(res.last ?? true);
      projects.isEmpty ? showNoData() : showLoaded();
    } on DioException catch (e) {
      errorMessage = e.message ?? AppStrings.warningNotConnectInternet;
      showError();
    } catch (e) {
      errorMessage = e.toString();
      showError();
    }
  }

  Future<void> clearFilters() async {
    selectedStatus = '';
    selectedField = '';
    selectedUnitId = null;
    await applyFilters();
  }

  void reset() {
    keyword = '';
    selectedStatus = '';
    selectedField = '';
    selectedUnitId = null;
    currentPage = 0;
    hasMore = true;
  }

  Future<void> loadFilterOptions() async {
    try {
      final res = await _service.getFilterOptions();
      depts = res.depts ?? const [];
    } catch (_) {
      // silent fail for filter options
    }
  }

  int get totalProjects => projects.length;
}
