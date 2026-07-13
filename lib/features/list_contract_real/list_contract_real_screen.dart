import 'package:flutter/material.dart';
import 'package:obm_gen_with_ai/core/base/base_page.dart';
import 'package:obm_gen_with_ai/core/constants/color_app.dart';
import 'package:obm_gen_with_ai/features/list_contract_real/component/list_contract_real_provider.dart';
import 'package:obm_gen_with_ai/features/list_contract_real/component/list_contract_real_service.dart';
import 'package:obm_gen_with_ai/features/list_contract_real/widget/body_list_contract_real_widget.dart';
import 'package:obm_gen_with_ai/core/constants/app_strings.dart';
import 'package:obm_gen_with_ai/core/constants/route_generator.dart';
import 'package:obm_gen_with_ai/features/dashboard/widget/item_drawer_widget.dart';
import 'package:obm_gen_with_ai/core/components/app_main_bar.dart';

class ListContractRealScreen extends BasePageStatefulWidget {
  const ListContractRealScreen({super.key});

  @override
  State<ListContractRealScreen> createState() => _ListContractRealScreenState();
}

class _ListContractRealScreenState
    extends BaseStatefulWidgetState<ListContractRealScreen, ListContractRealService, ListContractRealProvider> {
  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return AppMainBar(title: AppStrings.contracts, hasUnreadNotification: true);
  }

  @override
  Widget? buildDrawer(BuildContext context) {
    return DashboardDrawerWidget(
      currentRoute: RouteGenerator.listContractReal,
      onNavigate: (route) {
        Navigator.pop(context);
        Navigator.pushNamed(context, route);
      },
      onLogout: () {
        Navigator.pop(context);
        Navigator.pushReplacementNamed(context, RouteGenerator.login);
      },
    );
  }

  @override
  Widget buildRoot(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(context),
      drawer: buildDrawer(context),
      body: buildBody(context),
      floatingActionButton: _buildAddFab(context),
    );
  }

  Widget _buildAddFab(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () {
        final provider = pageProvider(context);
        Navigator.pushNamed(context, RouteGenerator.addContract).then((_) {
          if (!mounted) return;
          // Refresh the list when returning from add screen
          provider.loadContracts();
        });
      },
      backgroundColor: ColorApp.color005F9E,
      foregroundColor: Colors.white,
      elevation: 4,
      icon: const Icon(Icons.add, size: 22),
      label: Text(
        AppStrings.themMoiHopDong,
        style: const TextStyle(
          fontFamily: 'Inter',
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
  @override
  Widget buildBody(BuildContext context) {
    return const BodyListContractRealWidget();
  }
}
