import 'package:dio/dio.dart';
import 'package:obm_gen_with_ai/core/base/base_provider.dart';
import 'package:obm_gen_with_ai/core/constants/app_strings.dart';
import 'package:obm_gen_with_ai/features/contract_detail/component/contract_detail_service.dart';
import 'package:obm_gen_with_ai/features/contract_detail/model/contract_detail_model.dart';

class ContractDetailProvider extends BaseProvider<ContractDetailService> {
  final ContractDetailService _service;

  ContractDetailProvider(this._service) : super();

  ContractDetailService get service => _service;

  ContractDetailModel? contract;
  bool isExpiringSoon = false;

  Future<void> loadContractDetail(int id) async {
    showLoading();
    isExpiringSoon = false;
    try {
      contract = await _service.getContractDetail(id);
      if (contract?.expiryDate != null) {
        isExpiringSoon = _checkExpiringSoon(contract!.expiryDate!);
      }
      contract != null ? showLoaded() : showNoData();
    } on DioException catch (e) {
      errorMessage = e.message ?? AppStrings.warningNotConnectInternet;
      showError();
    } catch (e) {
      errorMessage = e.toString();
      showError();
    }
  }

  bool _checkExpiringSoon(String expiryDateStr) {
    try {
      final parts = expiryDateStr.split('-');
      final expiryDate = DateTime(
        int.parse(parts[0]),
        int.parse(parts[1]),
        int.parse(parts[2]),
      );
      final now = DateTime.now();
      final diff = expiryDate.difference(now).inDays;
      return diff >= 0 && diff <= 7;
    } catch (_) {
      return false;
    }
  }

  String formatCurrency(double? value) {
    if (value == null) return AppStrings.dashDash;
    final str = value.toStringAsFixed(0).replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
        );
    return '$str đ';
  }

  String formatDate(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) return AppStrings.dashDash;
    try {
      final parts = dateStr.split('-');
      return '${parts[2]}/${parts[1]}/${parts[0]}';
    } catch (_) {
      return dateStr;
    }
  }

  String formatPercent(double? value) {
    if (value == null) return AppStrings.dashDash;
    return '${value.toStringAsFixed(2)}%';
  }

  String orEmpty(String? value) {
    return value?.isNotEmpty == true ? value! : AppStrings.dashDash;
  }
}
