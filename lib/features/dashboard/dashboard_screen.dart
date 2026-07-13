import 'package:flutter/material.dart';
import 'package:obm_gen_with_ai/core/base/base_page.dart';
import 'package:obm_gen_with_ai/core/components/app_main_bar.dart';
import 'package:obm_gen_with_ai/core/constants/route_generator.dart';
import 'package:obm_gen_with_ai/features/dashboard/component/dashboard_provider.dart';
import 'package:obm_gen_with_ai/features/dashboard/component/dashboard_service.dart';
import 'package:obm_gen_with_ai/features/dashboard/widget/body_dashboard_widget.dart';
import 'package:obm_gen_with_ai/features/dashboard/widget/item_drawer_widget.dart';

class DashboardScreen extends BasePageStatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState
    extends BaseStatefulWidgetState<DashboardScreen, DashboardService, DashboardProvider> {
  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return const AppMainBar(hasUnreadNotification: true);
  }

  @override
  Widget? buildDrawer(BuildContext context) {
    return DashboardDrawerWidget(
      currentRoute: RouteGenerator.dashboard,
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
  Widget buildBody(BuildContext context) {
    return const BodyDashboardWidget();
  }
}
