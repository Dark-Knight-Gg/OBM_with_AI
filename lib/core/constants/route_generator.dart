import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:obm_gen_with_ai/core/constants/color_app.dart';
import 'package:obm_gen_with_ai/core/base/services/dio_option.dart';
import 'package:obm_gen_with_ai/features/dashboard/component/dashboard_provider.dart';
import 'package:obm_gen_with_ai/features/dashboard/component/dashboard_service.dart';
import 'package:obm_gen_with_ai/features/dashboard/dashboard_screen.dart';
import 'package:obm_gen_with_ai/features/login/component/login_provider.dart';
import 'package:obm_gen_with_ai/features/login/component/login_service.dart';
import 'package:obm_gen_with_ai/features/login/login_screen.dart';
import 'package:obm_gen_with_ai/features/splash/component/splash_provider.dart';
import 'package:obm_gen_with_ai/features/splash/component/splash_service.dart';
import 'package:obm_gen_with_ai/features/splash/splash_screen.dart';
import 'package:obm_gen_with_ai/features/list_contract/list_contract_screen.dart';
import 'package:obm_gen_with_ai/features/list_contract/component/list_contract_provider.dart';
import 'package:obm_gen_with_ai/features/list_contract/component/list_contract_service.dart';
import 'package:obm_gen_with_ai/features/project_detail/component/project_detail_provider.dart';
import 'package:obm_gen_with_ai/features/project_detail/component/project_detail_service.dart';
import 'package:obm_gen_with_ai/features/project_detail/project_detail_screen.dart';
import 'package:obm_gen_with_ai/features/project_edit/component/project_edit_provider.dart';
import 'package:obm_gen_with_ai/features/project_edit/component/project_edit_service.dart';
import 'package:obm_gen_with_ai/features/project_edit/project_edit_screen.dart';
import 'package:obm_gen_with_ai/features/list_contract_real/component/list_contract_real_provider.dart';
import 'package:obm_gen_with_ai/features/list_contract_real/component/list_contract_real_service.dart';
import 'package:obm_gen_with_ai/features/list_contract_real/list_contract_real_screen.dart';
import 'package:obm_gen_with_ai/features/contract_detail/component/contract_detail_provider.dart';
import 'package:obm_gen_with_ai/features/contract_detail/component/contract_detail_service.dart';
import 'package:obm_gen_with_ai/features/contract_detail/contract_detail_screen.dart';
import 'package:obm_gen_with_ai/features/add_contract/add_contract_screen.dart';
import 'package:obm_gen_with_ai/features/add_contract/component/add_contract_provider.dart';
import 'package:obm_gen_with_ai/features/add_contract/component/add_contract_service.dart';
import 'package:obm_gen_with_ai/features/edit_contract/edit_contract_screen.dart';
import 'package:obm_gen_with_ai/features/edit_contract/component/edit_contract_provider.dart';
import 'package:obm_gen_with_ai/features/edit_contract/component/edit_contract_service.dart';

class RouteGenerator {
  RouteGenerator._();

  static const String splash = '/splash';
  static const String login = '/login';
  static const String home = '/home';
  static const String dashboard = '/dashboard';
  static const String listContract = '/list-contract';
  static const String projectDetail = '/project-detail';
  static const String projectEdit = '/project-edit';
  static const String listContractReal = '/list-contract-real';
  static const String contractDetail = '/contract-detail';
  static const String contractEdit = '/contract-edit';
  static const String addContract = '/add-contract';

  // Placeholder routes for drawer navigation
  static const String opportunity = '/opportunity';
  static const String projectManagement = '/project-management';
  static const String focus = '/focus';
  static const String productsServices = '/products-services';
  static const String nhapSanLuong = '/nhap-san-luong';
  static const String revenueTracking = '/revenue-tracking';
  static const String annualRevenueReport = '/annual-revenue-report';
  static const String annualRevenuePlanReport = '/annual-revenue-plan-report';
  static const String serverInfrastructure = '/server-infrastructure';
  static const String infrastructureDashboard = '/infrastructure-dashboard';
  static const String revenueExpense = '/revenue-expense';
  static const String resourceManage = '/resource-manage';
  static const String searchResource = '/search-resource';
  static const String policyPermission = '/policy-permission';
  static const String organization = '/organization';
  static const String generalConfig = '/general-config';
  static const String userManagement = '/user-management';

  static String _getPlaceholderTitle(String route) {
    final titles = {
      opportunity: 'Cơ hội kinh doanh',
      projectManagement: 'Quản lý dự án',
      focus: 'Tập trung',
      productsServices: 'Sản phẩm & Dịch vụ',
      nhapSanLuong: 'Nhập sản lượng',
      revenueTracking: 'Theo dõi doanh thu',
      annualRevenueReport: 'Báo cáo doanh thu năm',
      annualRevenuePlanReport: 'Báo cáo kế hoạch doanh thu năm',
      serverInfrastructure: 'Hạ tầng máy chủ',
      infrastructureDashboard: 'Dashboard hạ tầng',
      revenueExpense: 'Thu chi doanh thu',
      resourceManage: 'Quản lý nguồn lực',
      searchResource: 'Tìm kiếm nguồn lực',
      policyPermission: 'Chính sách & Phân quyền',
      organization: 'Tổ chức',
      generalConfig: 'Cấu hình chung',
      userManagement: 'Quản lý người dùng',
    };
    return titles[route] ?? 'Đang phát triển';
  }

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(
          settings: settings,
            builder: (_) => MultiProvider(
              providers: [
                ChangeNotifierProvider<SplashProvider>(
                  create: (_) => SplashProvider(
                    SplashService(DioOption().createDio()),
                  ),
                ),
              ],
              child: const SplashScreen(),
            )
        );
      case login:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => MultiProvider(
            providers: [
              ChangeNotifierProvider<LoginProvider>(
                create: (_) => LoginProvider(
                  LoginService(DioOption().createDio()),
                ),
              ),
            ],
            child: const LoginScreen(),
          ),
        );
      case dashboard:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => MultiProvider(
            providers: [
              ChangeNotifierProvider<DashboardProvider>(
                create: (_) => DashboardProvider(
                  DashboardService(DioOption().createDio()),
                ),
              ),
            ],
            child: const DashboardScreen(),
          ),
        );
      case listContract:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => MultiProvider(
            providers: [
              ChangeNotifierProvider<ListContractProvider>(
                create: (_) => ListContractProvider(
                  ListContractService(DioOption().createDio()),
                ),
              ),
            ],
            child: const ListContractScreen(),
          ),
        );
      case projectDetail:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => MultiProvider(
            providers: [
              ChangeNotifierProvider<ProjectDetailProvider>(
                create: (_) => ProjectDetailProvider(
                  ProjectDetailService(DioOption().createDio()),
                ),
              ),
            ],
            child: const ProjectDetailScreen(),
          ),
        );
      case projectEdit:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => MultiProvider(
            providers: [
              ChangeNotifierProvider<ProjectEditProvider>(
                create: (_) => ProjectEditProvider(
                  ProjectEditService(DioOption().createDio()),
                ),
              ),
            ],
            child: const ProjectEditScreen(),
          ),
        );
      case listContractReal:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => MultiProvider(
            providers: [
              ChangeNotifierProvider<ListContractRealProvider>(
                create: (_) => ListContractRealProvider(
                  ListContractRealService(DioOption().createDio()),
                ),
              ),
            ],
            child: const ListContractRealScreen(),
          ),
        );
      case contractDetail:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => MultiProvider(
            providers: [
              ChangeNotifierProvider<ContractDetailProvider>(
                create: (_) => ContractDetailProvider(
                  ContractDetailService(DioOption().createDio()),
                ),
              ),
            ],
            child: const ContractDetailScreen(),
          ),
        );
      case addContract:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => MultiProvider(
            providers: [
              ChangeNotifierProvider<AddContractProvider>(
                create: (_) => AddContractProvider(
                  AddContractService(DioOption().createDio()),
                ),
              ),
            ],
            child: const AddContractScreen(),
          ),
        );
      case contractEdit: {
        final args = settings.arguments as Map<String, dynamic>?;
        final contractId = (args?['id'] as int?) ?? 0;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => MultiProvider(
            providers: [
              ChangeNotifierProvider<EditContractProvider>(
                create: (_) => EditContractProvider(
                  EditContractService(DioOption().createDio()),
                  contractId,
                ),
              ),
            ],
            child: EditContractScreen(contractId: contractId),
          ),
        );
      }
      // Placeholder routes for drawer navigation
      case opportunity:
      case projectManagement:
      case focus:
      case productsServices:
      case nhapSanLuong:
      case revenueTracking:
      case annualRevenueReport:
      case annualRevenuePlanReport:
      case serverInfrastructure:
      case infrastructureDashboard:
      case revenueExpense:
      case resourceManage:
      case searchResource:
      case policyPermission:
      case organization:
      case generalConfig:
      case userManagement:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              scrolledUnderElevation: 0,
              automaticallyImplyLeading: false,
              flexibleSpace: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.8),
                  border: Border(bottom: BorderSide(color: ColorApp.colorC0C7D3.withValues(alpha: 0.3))),
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.of(context).pop(),
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
                            child: Icon(Icons.arrow_back, size: 24, color: ColorApp.color191C1E),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Thông báo',
                            style: TextStyle(fontFamily: 'Inter', fontSize: 18, fontWeight: FontWeight.w700, color: ColorApp.color191C1E),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            body: const Center(
              child: Text(
                'Tính năng chưa được phát triển',
                style: TextStyle(fontFamily: 'Inter', fontSize: 16),
              ),
            ),
          ),
        );
      default:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              scrolledUnderElevation: 0,
              automaticallyImplyLeading: false,
              flexibleSpace: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.8),
                  border: Border(bottom: BorderSide(color: ColorApp.colorC0C7D3.withValues(alpha: 0.3))),
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.of(context).pop(),
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
                            child: Icon(Icons.arrow_back, size: 24, color: ColorApp.color191C1E),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Thông báo',
                            style: TextStyle(fontFamily: 'Inter', fontSize: 18, fontWeight: FontWeight.w700, color: ColorApp.color191C1E),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            body: const Center(
              child: Text(
                'Tính năng chưa được phát triển',
                style: TextStyle(fontFamily: 'Inter', fontSize: 16),
              ),
            ),
          ),
        );
    }
  }
}