import 'package:flutter/material.dart';
import 'package:obm_gen_with_ai/core/base/base_page.dart';
import 'package:obm_gen_with_ai/core/components/app_main_bar.dart';
import 'package:obm_gen_with_ai/core/constants/app_strings.dart';
import 'package:obm_gen_with_ai/core/constants/route_generator.dart';
import 'package:obm_gen_with_ai/features/dashboard/widget/item_drawer_widget.dart';
import 'package:obm_gen_with_ai/features/list_contract/component/list_contract_provider.dart';
import 'package:obm_gen_with_ai/features/list_contract/component/list_contract_service.dart';
import 'package:obm_gen_with_ai/features/list_contract/widget/body_list_contract_widget.dart';

class ListContractScreen extends BasePageStatefulWidget {
  const ListContractScreen({Key? key}) : super(key: key);

  @override
  State<ListContractScreen> createState() => _ListContractScreenState();
}

class _ListContractScreenState
    extends BaseStatefulWidgetState<ListContractScreen, ListContractService, ListContractProvider> {
  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return AppMainBar(title: AppStrings.projectManagement, hasUnreadNotification: true);
  }

  @override
  Widget? buildDrawer(BuildContext context) {
    return DashboardDrawerWidget(
      currentRoute: RouteGenerator.listContract,
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
    );
  }

  @override
  Widget buildBody(BuildContext context) {
    return const BodyListContractWidget();
  }
}
