import 'dart:async';

import 'package:dio/dio.dart';
import 'package:obm_gen_with_ai/core/base/base_provider.dart';
import 'package:obm_gen_with_ai/core/base/toast/toast_event.dart';
import 'package:obm_gen_with_ai/core/constants/app_strings.dart';
import 'package:obm_gen_with_ai/features/add_contract/model/add_contract_model.dart';
import 'package:obm_gen_with_ai/features/edit_contract/component/edit_contract_service.dart';
import 'package:obm_gen_with_ai/features/edit_contract/model/edit_contract_model.dart';

class EditContractProvider extends BaseProvider<EditContractService> {
  final EditContractService _service;
  final int contractId;

  EditContractProvider(this._service, this.contractId) : super();

  EditContractService get service => _service;

  // ─── Form state (mirrors AddContractProvider) ────────────────────
  int? selectedOwningUnitId;
  int? selectedOpportunityId;
  int? selectedProjectId;
  int? selectedCustomerId;
  int? selectedProductServiceId;
  String? selectedRegionCode;
  String? selectedBusinessField;
  String contractName = '';
  String contractNo = '';
  String? selectedTypeCode;
  String? selectedStatusCode;
  String managerName = '';
  String kmsLink = '';
  DateTime? signedDate;
  DateTime? acceptanceDate;
  DateTime? expiryDate;
  int? durationMonths;
  double? contractValue;
  double? vnptValue;
  double? itPercent;
  String bindingTerms = '';
  String note = '';

  // ─── Filter option data ─────────────────────────────────────────
  List<DeptLineModel> depts = const [];
  List<ProductRefModel> productRefs = const [];
  List<OpportunityModel> opportunities = const [];
  List<ProjectRefModel> projects = const [];
  List<CustomerModel> customers = const [];
  List<ProductServiceModel> productServices = const [];

  // ─── Validation ─────────────────────────────────────────────────
  String? owningUnitError;
  String? contractNameError;
  String? expiryDateError;

  @override
  void onStart() {
    super.onStart();
    loadContractAndFilters();
  }

  Future<void> loadContractAndFilters() async {
    showLoading();
    try {
      final contract = await _service.getContract(contractId);
      final results = await Future.wait([
        _service.getFilterOptions(),
        _service.getOpportunities(),
        _service.getProjects(),
        _service.getCustomers(),
        _service.getProductServices(),
      ]);

      depts = (results[0] as FilterOptionsResponse).depts;
      productRefs = (results[0] as FilterOptionsResponse).products;
      opportunities = (results[1] as OpportunityResponse).content;
      projects = (results[2] as ProjectRefResponse).content;
      customers = (results[3] as CustomerResponse).content;
      productServices = (results[4] as ProductServiceResponse).content;

      _hydrateFromContract(contract);
      showLoaded();
    } on DioException catch (e) {
      errorMessage = e.message ?? AppStrings.warningNotConnectInternet;
      showError();
    } catch (e) {
      errorMessage = e.toString();
      showError();
    }
  }

  void _hydrateFromContract(ContractDetailModel c) {
    selectedOwningUnitId = c.owningUnitId;
    selectedOpportunityId = c.opportunityId;
    selectedProjectId = c.projectId;
    selectedCustomerId = c.customerId;
    selectedProductServiceId = c.productServiceId;
    selectedRegionCode = c.regionCode;
    selectedBusinessField = c.businessField;
    contractName = c.name ?? '';
    contractNo = c.contractNo ?? '';
    selectedTypeCode = c.typeCode;
    selectedStatusCode = c.statusCode;
    managerName = c.managerName ?? '';
    kmsLink = c.kmsLink ?? '';
    signedDate = _parseDate(c.signedDate);
    acceptanceDate = _parseDate(c.acceptanceDate);
    expiryDate = _parseDate(c.expiryDate);
    durationMonths = c.durationMonths;
    contractValue = c.contractValue;
    vnptValue = c.vnptValue;
    itPercent = c.itPercent;
    bindingTerms = c.bindingTerms ?? '';
    note = c.note ?? '';
  }

  // ─── BR-001 Auto-compute VNPT-IT value ───────────────────────────
  double get computedVnptItValue {
    if (vnptValue == null || itPercent == null) return 0;
    return vnptValue! * (itPercent! / 100);
  }

  // ─── BR-004 Filter products by owning unit's line ─────────────────
  List<ProductServiceModel> get filteredProductServices {
    if (selectedOwningUnitId == null) return productServices;
    final dept = depts.firstWhere(
      (d) => d.id == selectedOwningUnitId,
      orElse: () => const DeptLineModel(),
    );
    if (dept.parentId == null) return productServices;
    final line = depts.firstWhere(
      (d) => d.id == dept.parentId,
      orElse: () => const DeptLineModel(),
    );
    final lineName = line.name;
    if (lineName == null) return productServices;
    return productServices
        .where((p) => p.lineUnitName == lineName)
        .toList();
  }

  // ─── BR-002 Inherit from opportunity ─────────────────────────────
  void onOpportunitySelected(int? opportunityId) {
    selectedOpportunityId = opportunityId;
    if (opportunityId == null) {
      notifyListeners();
      return;
    }
    final opp = opportunities.firstWhere(
      (o) => o.id == opportunityId,
      orElse: () => const OpportunityModel(),
    );
    if (opp.fieldLabel == 'Chính phủ điện tử') {
      selectedBusinessField = 'EGOV';
    }
    if (opp.name != null && contractName.isEmpty) {
      contractName = opp.name!;
    }
    notifyListeners();
  }

  // ─── Form state mutators ─────────────────────────────────────────
  void setOwningUnitId(int? id) {
    selectedOwningUnitId = id;
    selectedProductServiceId = null;
    notifyListeners();
  }

  void setProjectId(int? id) {
    selectedProjectId = id;
    notifyListeners();
  }

  void setCustomerId(int? id) {
    selectedCustomerId = id;
    notifyListeners();
  }

  void setProductServiceId(int? id) {
    selectedProductServiceId = id;
    notifyListeners();
  }

  void setRegionCode(String? v) {
    selectedRegionCode = v;
    notifyListeners();
  }

  void setBusinessField(String? v) {
    selectedBusinessField = v;
    notifyListeners();
  }

  void setContractName(String v) {
    contractName = v;
    notifyListeners();
  }

  void setContractNo(String v) {
    contractNo = v;
    notifyListeners();
  }

  void setTypeCode(String? v) {
    selectedTypeCode = v;
    notifyListeners();
  }

  void setStatusCode(String? v) {
    selectedStatusCode = v;
    notifyListeners();
  }

  void setManagerName(String v) {
    managerName = v;
    notifyListeners();
  }

  void setKmsLink(String v) {
    kmsLink = v;
    notifyListeners();
  }

  void setAcceptanceDate(DateTime? d) {
    acceptanceDate = d;
    notifyListeners();
  }

  void setDurationMonths(int? v) {
    durationMonths = v;
    notifyListeners();
  }

  void setContractValue(double? v) {
    contractValue = v;
    notifyListeners();
  }

  void setVnptValue(double? v) {
    vnptValue = v;
    notifyListeners();
  }

  void setItPercent(double? v) {
    itPercent = v;
    notifyListeners();
  }

  void setBindingTerms(String v) {
    bindingTerms = v;
    notifyListeners();
  }

  void setNote(String v) {
    note = v;
    notifyListeners();
  }

  // ─── Date validation (mirrors AddContractProvider) ───────────────
  void setExpiryDate(DateTime? date) {
    expiryDate = date;
    if (date != null && signedDate != null && date.isBefore(signedDate!)) {
      expiryDateError = AppStrings.ngayHetHanKhongNhoHonNgayKy;
    } else {
      expiryDateError = null;
    }
    notifyListeners();
  }

  void setSignedDate(DateTime? date) {
    signedDate = date;
    if (expiryDate != null && date != null && expiryDate!.isBefore(date)) {
      expiryDateError = AppStrings.ngayHetHanKhongNhoHonNgayKy;
    } else {
      expiryDateError = null;
    }
    notifyListeners();
  }

  bool validate() {
    owningUnitError = null;
    contractNameError = null;
    bool ok = true;
    if (selectedOwningUnitId == null) {
      owningUnitError = AppStrings.truongNayLaBatBuoc;
      ok = false;
    }
    if (contractName.trim().isEmpty) {
      contractNameError = AppStrings.truongNayLaBatBuoc;
      ok = false;
    }
    if (expiryDateError != null) ok = false;
    notifyListeners();
    return ok;
  }

  Future<bool> submit() async {
    if (!validate()) return false;
    showLoading();
    try {
      final body = <String, dynamic>{
        'id': contractId,
        if (selectedOwningUnitId != null) 'owningUnitId': selectedOwningUnitId,
        if (selectedOpportunityId != null) 'opportunityId': selectedOpportunityId,
        if (selectedProjectId != null) 'projectId': selectedProjectId,
        if (selectedCustomerId != null) 'customerId': selectedCustomerId,
        if (selectedProductServiceId != null)
          'productServiceId': selectedProductServiceId,
        if (selectedRegionCode != null) 'regionCode': selectedRegionCode,
        if (selectedBusinessField != null) 'businessField': selectedBusinessField,
        if (contractName.trim().isNotEmpty) 'name': contractName.trim(),
        if (contractNo.trim().isNotEmpty) 'contractNo': contractNo.trim(),
        if (selectedTypeCode != null) 'typeCode': selectedTypeCode,
        if (selectedStatusCode != null) 'statusCode': selectedStatusCode,
        if (managerName.trim().isNotEmpty) 'managerName': managerName.trim(),
        if (kmsLink.trim().isNotEmpty) 'kmsLink': kmsLink.trim(),
        if (signedDate != null) 'signedDate': _formatDate(signedDate),
        if (acceptanceDate != null) 'acceptanceDate': _formatDate(acceptanceDate),
        if (expiryDate != null) 'expiryDate': _formatDate(expiryDate),
        if (durationMonths != null) 'durationMonths': durationMonths,
        if (contractValue != null) 'contractValue': contractValue,
        if (vnptValue != null) 'vnptValue': vnptValue,
        if (itPercent != null) 'itPercent': itPercent,
        if (vnptValue != null && itPercent != null)
          'vnptItValue': vnptValue! * (itPercent! / 100),
        if (bindingTerms.trim().isNotEmpty) 'bindingTerms': bindingTerms.trim(),
        if (note.trim().isNotEmpty) 'note': note.trim(),
      };
      await _service.updateContract(contractId, body);
      showLoaded();
      showToast(
        AppStrings.hopDongDaDuocCapNhatThanhCong,
        type: ToastType.success,
      );
      return true;
    } on DioException catch (e) {
      errorMessage = e.message ?? AppStrings.khongTheKetNoiMauChu;
      showError();
      showToast(
        e.message ?? AppStrings.khongTheKetNoiMauChu,
        type: ToastType.error,
      );
      return false;
    } catch (e) {
      errorMessage = e.toString();
      showError();
      showToast(e.toString(), type: ToastType.error);
      return false;
    }
  }

  String? _formatDate(DateTime? d) {
    if (d == null) return null;
    return '${d.year.toString().padLeft(4, '0')}-'
        '${d.month.toString().padLeft(2, '0')}-'
        '${d.day.toString().padLeft(2, '0')}';
  }

  DateTime? _parseDate(String? s) {
    if (s == null || s.isEmpty) return null;
    try {
      final parts = s.split('-');
      if (parts.length != 3) return null;
      return DateTime(
        int.parse(parts[0]),
        int.parse(parts[1]),
        int.parse(parts[2]),
      );
    } catch (_) {
      return null;
    }
  }
}
