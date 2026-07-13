import 'package:dio/dio.dart';
import 'package:obm_gen_with_ai/core/base/base_provider.dart';
import 'package:obm_gen_with_ai/core/base/toast/toast_event.dart';
import 'package:obm_gen_with_ai/core/constants/app_strings.dart';
import 'package:obm_gen_with_ai/features/list_contract_real/component/list_contract_real_service.dart';
import 'package:obm_gen_with_ai/features/list_contract_real/model/list_contract_real_model.dart';

class ListContractRealProvider extends BaseProvider<ListContractRealService> {
  final ListContractRealService _service;

  ListContractRealProvider(this._service) : super();

  ListContractRealService get service => _service;

  List<ContractModel> contracts = const [];
  String keyword = '';
  String selectedStatus = '';
  int currentPage = 0;
  bool hasMore = true;

  @override
  void onStart() {
    super.onStart();
    loadContracts();
  }

  Future<void> loadContracts() async {
    showLoading();
    try {
      final res = await _service.getContracts(
        page: 0,
        keyword: keyword,
        status: selectedStatus,
      );
      contracts = res.content ?? const [];
      currentPage = 0;
      hasMore = !(res.last ?? true);
      contracts.isEmpty ? showNoData() : showLoaded();
    } on DioException catch (e) {
      errorMessage = e.message ?? AppStrings.warningNotConnectInternet;
      showError();
    } catch (e) {
      errorMessage = e.toString();
      showError();
    }
  }

  Future<void> loadMoreContracts() async {
    if (!hasMore) return;
    try {
      final res = await _service.getContracts(
        page: currentPage + 1,
        keyword: keyword,
        status: selectedStatus,
      );
      contracts = [...contracts, ...(res.content ?? const [])];
      currentPage++;
      hasMore = !(res.last ?? true);
      showLoaded();
    } on DioException catch (e) {
      showToast(e.message ?? AppStrings.warningNotConnectInternet, type: ToastType.error);
    } catch (e) {
      showToast(e.toString(), type: ToastType.error);
    }
  }

  Future<void> searchContracts(String value) async {
    keyword = value;
    currentPage = 0;
    showLoading();
    try {
      final res = await _service.getContracts(
        page: 0,
        keyword: value,
        status: selectedStatus,
      );
      contracts = res.content ?? const [];
      hasMore = !(res.last ?? true);
      contracts.isEmpty ? showNoData() : showLoaded();
    } on DioException catch (e) {
      errorMessage = e.message ?? AppStrings.warningNotConnectInternet;
      showError();
    } catch (e) {
      errorMessage = e.toString();
      showError();
    }
  }

  Future<void> applyStatusFilter(String status) async {
    selectedStatus = status;
    currentPage = 0;
    showLoading();
    try {
      final res = await _service.getContracts(
        page: 0,
        keyword: keyword,
        status: status,
      );
      contracts = res.content ?? const [];
      hasMore = !(res.last ?? true);
      contracts.isEmpty ? showNoData() : showLoaded();
    } on DioException catch (e) {
      errorMessage = e.message ?? AppStrings.warningNotConnectInternet;
      showError();
    } catch (e) {
      errorMessage = e.toString();
      showError();
    }
  }

  Future<void> clearFilters() async {
    keyword = '';
    selectedStatus = '';
    await loadContracts();
  }

  Future<void> deleteContract(int contractId, String contractName) async {
    try {
      await _service.deleteContract(contractId);
      contracts = contracts.where((c) => c.id != contractId).toList();
      showToast(AppStrings.xoaHopDongThanhCong(contractName), type: ToastType.success);
    } on DioException catch (e) {
      showToast(e.message ?? AppStrings.warningNotConnectInternet, type: ToastType.error);
    } catch (e) {
      showToast(AppStrings.warningNotConnectInternet, type: ToastType.error);
    }
  }

  int get totalContracts => contracts.length;
}
