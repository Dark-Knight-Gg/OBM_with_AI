import 'package:dio/dio.dart';
import 'package:obm_gen_with_ai/core/base/base_provider.dart';
import 'package:obm_gen_with_ai/core/base/toast/toast_event.dart';
import 'package:obm_gen_with_ai/core/constants/app_strings.dart';
import 'package:obm_gen_with_ai/features/add_contract/component/add_contract_service.dart';
import 'package:obm_gen_with_ai/features/add_contract/model/add_contract_model.dart';

class AddContractProvider extends BaseProvider<AddContractService> {
  final AddContractService _service;

  AddContractProvider(this._service) : super();

  AddContractService get service => _service;

  // Form state
  int? selectedOwningUnitId;
  int? selectedOpportunityId;
  int? selectedProjectId;
/*  String customerName = '';*/
  int? selectedCustomerId;
  int? selectedProductServiceId;
  String? selectedRegionCode;
  String? selectedBusinessField;
  String contractName = '';
  String contractNo = '';
  String? selectedTypeCode;
  String? selectedStatusCode = 'DRAFT';
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

  // Filter option data
  List<DeptLineModel> depts = const [];
  List<ProductRefModel> productRefs = const [];
  List<OpportunityModel> opportunities = const [];
  List<ProjectRefModel> projects = const [];
  List<CustomerModel> customers = const [];
  List<ProductServiceModel> productServices = const [];

  // Validation
  String? owningUnitError;
  String? contractNameError;
  String? expiryDateError;

  @override
  void onStart() {
    super.onStart();
    loadFilterData();
  }

  Future<void> loadFilterData() async {
    showLoading();
    try {
      final results = await Future.wait([
        _service.getFilterOptions(),
        _service.getOpportunities(),
        _service.getProjects(),
        _service.getCustomers(),
        _service.getProductServices(),
      ]);

      final filter = results[0] as FilterOptionsResponse;
      depts = filter.depts;
      productRefs = filter.products;
      opportunities = (results[1] as OpportunityResponse).content;
      projects = (results[2] as ProjectRefResponse).content;
      customers = (results[3] as CustomerResponse).content;
      productServices = (results[4] as ProductServiceResponse).content;
      showLoaded();
    } on DioException catch (e) {
      errorMessage = e.message ?? AppStrings.warningNotConnectInternet;
      showError();
    } catch (e) {
      errorMessage = e.toString();
      showError();
    }
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

  // ─── BR-001 Auto-compute VNPT-IT value ────────────────────────────
  double get computedVnptItValue {
    if (vnptValue == null || itPercent == null) return 0;
    return vnptValue! * (itPercent! / 100);
  }

  // ─── Form state mutators (notify listeners) ────────────────────
  void setOwningUnitId(int? id) {
    selectedOwningUnitId = id;
    // BR-004: reset product when unit changes
    selectedProductServiceId = null;
    notifyListeners();
  }

  void setProjectId(int? id) {
    selectedProjectId = id;
    notifyListeners();
  }

/*  void setCustomerName(String v) {
    customerName = v;
    notifyListeners();
  }*/
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

  // ─── BR-002 Inherit from opportunity ──────────────────────────────
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
/*    if (opp.customerName != null && customerName.isEmpty) {
      customerName = opp.customerName!;
    }*/
    if (opp.fieldLabel == 'Chính phủ điện tử') {
      selectedBusinessField = 'EGOV';
    }
    if (opp.name != null && contractName.isEmpty) {
      contractName = opp.name!;
    }
    notifyListeners();
  }

  // ─── BR-003 Date validation ───────────────────────────────────────
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

  // ─── BR-005 Form validation before submit ─────────────────────────
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
    if (expiryDateError != null) {
      ok = false;
    }
    notifyListeners();
    return ok;
  }

  Future<bool> submit() async {
    if (!validate()) return false;
    showLoading();
    try {
      final req = AddContractRequest(
        owningUnitId: selectedOwningUnitId,
        opportunityId: selectedOpportunityId,
        projectId: selectedProjectId,
        customerId: selectedCustomerId,
        productServiceId: selectedProductServiceId,
        regionCode: selectedRegionCode,
        businessField: selectedBusinessField,
        name: contractName.trim().isEmpty ? null : contractName.trim(),
        contractNo: contractNo.trim().isEmpty ? null : contractNo.trim(),
        typeCode: selectedTypeCode,
        statusCode: selectedStatusCode,
        managerName: managerName.trim().isEmpty ? null : managerName.trim(),
        kmsLink: kmsLink.trim().isEmpty ? null : kmsLink.trim(),
        signedDate: _formatDate(signedDate),
        acceptanceDate: _formatDate(acceptanceDate),
        expiryDate: _formatDate(expiryDate),
        durationMonths: durationMonths,
        contractValue: contractValue,
        vnptValue: vnptValue,
        itPercent: itPercent,
        vnptItValue: vnptValue != null && itPercent != null
            ? vnptValue! * (itPercent! / 100)
            : null,
        bindingTerms: bindingTerms.trim().isEmpty ? null : bindingTerms.trim(),
        note: note.trim().isEmpty ? null : note.trim(),
      );
      await _service.createContract(req);
      showLoaded();
      showToast(AppStrings.luuHopDongThanhCong, type: ToastType.success);
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

  int? _findCustomerIdByName(String name) {
    if (name.trim().isEmpty) return null;
    final match = customers.firstWhere(
      (c) => (c.name ?? '').trim() == name.trim(),
      orElse: () => const CustomerModel(),
    );
    return match.id;
  }

  String? _formatDate(DateTime? d) {
    if (d == null) return null;
    return '${d.year.toString().padLeft(4, '0')}-'
        '${d.month.toString().padLeft(2, '0')}-'
        '${d.day.toString().padLeft(2, '0')}';
  }

  /// Returns true if both signed and expiry dates are valid (expiry >= signed).
  bool get isDateRangeValid =>
      expiryDateError == null &&
      (signedDate == null ||
          expiryDate == null ||
          !expiryDate!.isBefore(signedDate!));
}