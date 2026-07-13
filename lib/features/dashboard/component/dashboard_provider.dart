import 'package:dio/dio.dart';
import 'package:obm_gen_with_ai/core/base/base_provider.dart';
import 'package:obm_gen_with_ai/core/base/toast/toast_event.dart';
import 'package:obm_gen_with_ai/core/constants/app_strings.dart';
import 'package:obm_gen_with_ai/features/dashboard/component/dashboard_service.dart';
import 'package:obm_gen_with_ai/features/dashboard/model/dashboard_model.dart';

class DashboardProvider extends BaseProvider<DashboardService> {
  final DashboardService _service;

  DashboardProvider(this._service) : super();

  DashboardService get service => _service;

  // Filter state
  int selectedYear = DateTime.now().year;
  String selectedPriceType = 'Doanh thu chủ quản';
  String selectedUnit = '';
  String selectedDepartment = '';
  String selectedProductService = '';

  // UI state
  bool showFilters = true;
  DashboardData? dashboardData;
  FilterOptionsData? filterOptions;

  // Revenue trend bar heights (0.0 - 1.0, relative to max)
  List<double> revenueBarHeights = const [
    0.40,
    0.60,
    0.85,
    0.35,
    0.55,
    0.95,
    0.70,
  ];

  List<String> revenueMonthLabels = const [
    'T1',
    'T2',
    'T3',
    'T4',
    'T5',
    'T6',
    'T7',
  ];

  void toggleFilters() {
    showFilters = !showFilters;
    notifyListeners();
  }

  void setYear(int year) {
    selectedYear = year;
    notifyListeners();
  }

  void setPriceType(String priceType) {
    selectedPriceType = priceType;
    notifyListeners();
  }

  void setUnit(String unit) {
    selectedUnit = unit;
    notifyListeners();
  }

  void setDepartment(String department) {
    selectedDepartment = department;
    notifyListeners();
  }

  void setProductService(String productService) {
    selectedProductService = productService;
    notifyListeners();
  }

  @override
  void onStart() {
    super.onStart();
    fetchFilterOptions();
    fetchDashboardData();
  }

  Future<void> fetchFilterOptions() async {
    try {
      final response = await service.getFilterOptions();
      filterOptions = response;
      notifyListeners();
    } on DioException {
      // Silently fail for filter options
    } catch (e) {
      // Silently fail
    }
  }

  Future<void> fetchDashboardData() async {
    showLoading();
    try {
      final response = await service.getDashboardData(
        year: selectedYear,
        priceType: selectedPriceType,
        unit: selectedUnit,
        department: selectedDepartment,
        productService: selectedProductService,
      );
      dashboardData = response.data;
      _computeBarHeights();
      showLoaded();
    } on DioException catch (e) {
      showToast(
        e.message ?? AppStrings.khongTheKetNoiMauChu,
        type: ToastType.error,
      );
      showError();
    } catch (e) {
      showToast(
        AppStrings.khongTheKetNoiMauChu,
        type: ToastType.error,
      );
      showError();
    }
  }

  void _computeBarHeights() {
    if (dashboardData == null) return;
    final months = dashboardData!.revenueByMonth ?? [];
    if (months.isEmpty) return;

    final maxValue = months
        .map((e) => e.value ?? 0)
        .reduce((a, b) => a > b ? a : b)
        .toDouble();
    if (maxValue == 0) return;

    revenueBarHeights = months
        .map((e) => ((e.value ?? 0) / maxValue).clamp(0.0, 1.0))
        .toList();

    revenueMonthLabels = months.map((e) => e.label ?? '').toList();
  }

  Future<void> applyFilters() async {
    if (showFilters) {
      showFilters = false;
    }
    await fetchDashboardData();
  }

  Future<void> refreshData() async {
    await fetchDashboardData();
  }
}
