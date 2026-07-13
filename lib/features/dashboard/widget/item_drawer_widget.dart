import 'package:flutter/material.dart';
import 'package:obm_gen_with_ai/core/constants/app_strings.dart';
import 'package:obm_gen_with_ai/core/constants/color_app.dart';
import 'package:obm_gen_with_ai/core/constants/route_generator.dart';
class DashboardDrawerWidget extends StatelessWidget {
  final VoidCallback? onLogout;
  final Function(String route)? onNavigate;
  final String currentRoute;

  const DashboardDrawerWidget({
    super.key,
    this.onLogout,
    this.onNavigate,
    required this.currentRoute,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0,
      child: SafeArea(
        child: Column(
          children: [
            const _DrawerHeader(),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    _DrawerItem(
                      icon: Icons.dashboard_outlined,
                      label: AppStrings.dashboardOverview,
                      route: '/dashboard',
                      onTap: () => onNavigate?.call('/dashboard'),
                    ),
                    _DrawerMenuSection(
                      label: 'Kinh doanh',
                      items:  [
                        _DrawerItem(
                          icon: Icons.rocket_launch_outlined,
                          label: AppStrings.opportunity,
                          route: '/opportunity',
                          onTap: () => onNavigate?.call('/opportunity'),
                        ),
                        _DrawerItem(
                          icon: Icons.assignment_outlined,
                          label: AppStrings.projectManagement,
                          route: RouteGenerator.listContract,
                          onTap: () => onNavigate?.call(RouteGenerator.listContract),
                        ),
                        _DrawerItem(
                          icon: Icons.description_outlined,
                          label: AppStrings.contracts,
                          route: '/list-contract_real',
                          onTap: () => onNavigate?.call(RouteGenerator.listContractReal),
                        ),
                        _DrawerItem(
                          icon: Icons.star_outline,
                          label: AppStrings.focus,
                          route: '/focus',
                          onTap: () => onNavigate?.call('/focus'),
                        ),
                        _DrawerItem(
                          icon: Icons.inventory_2_outlined,
                          label: AppStrings.productsServices,
                          route: '/products-services',
                          onTap: () => onNavigate?.call('/products-services'),
                        ),
                      ],
                    ),
                    _DrawerMenuSection(
                      label: 'Vận hành & Doanh thu',
                      items:  [
                        _DrawerItem(
                          icon: Icons.edit_note,
                          label: AppStrings.nhapSanLuong,
                          route: '/nhap-san-luong',
                          onTap: () => onNavigate?.call('/nhap-san-luong'),
                        ),
                        _DrawerItem(
                          icon: Icons.payments_outlined,
                          label: AppStrings.revenueTracking,
                          route: '/revenue-tracking',
                          onTap: () => onNavigate?.call('/revenue-tracking'),
                        ),
                        _DrawerItem(
                          icon: Icons.bar_chart_outlined,
                          label: AppStrings.annualRevenueReport,
                          route: '/annual-revenue-report',
                          onTap: () => onNavigate?.call('/annual-revenue-report'),
                        ),
                        _DrawerItem(
                          icon: Icons.query_stats,
                          label: AppStrings.annualRevenuePlanReport,
                          route: '/annual-revenue-plan-report',
                          onTap: () => onNavigate?.call('/annual-revenue-plan-report'),
                        ),
                        _DrawerItem(
                          icon: Icons.dns_outlined,
                          label: AppStrings.serverInfrastructure,
                          route: '/server-infrastructure',
                          onTap: () => onNavigate?.call('/server-infrastructure'),
                        ),
                        _DrawerItem(
                          icon: Icons.dashboard_outlined,
                          label: AppStrings.infrastructureDashboard,
                          route: '/infrastructure-dashboard',
                          onTap: () => onNavigate?.call('/infrastructure-dashboard'),
                        ),
                        _DrawerItem(
                          icon: Icons.balance_outlined,
                          label: AppStrings.revenueExpense,
                          route: '/revenue-expense',
                          onTap: () => onNavigate?.call('/revenue-expense'),
                        ),
                      ],
                    ),
                    _DrawerMenuSection(
                      label: 'Nguồn lực',
                      items:  [
                        _DrawerItem(
                          icon: Icons.hub_outlined,
                          label: AppStrings.resourceManage,
                          route: '/resource-manage',
                          onTap: () => onNavigate?.call('/resource-manage'),
                        ),
                        _DrawerItem(
                          icon: Icons.person_search_outlined,
                          label: AppStrings.searchResource,
                          route: '/search-resource',
                          onTap: () => onNavigate?.call('/search-resource'),
                        ),
                      ],
                    ),
                    _DrawerMenuSection(
                      label: 'Quản trị',
                      items:  [
                        _DrawerItem(
                          icon: Icons.policy_outlined,
                          label: AppStrings.policyPermission,
                          route: '/policy-permission',
                          onTap: () => onNavigate?.call('/policy-permission'),
                        ),
                        _DrawerItem(
                          icon: Icons.corporate_fare_outlined,
                          label: AppStrings.organization,
                          route: '/organization',
                          onTap: () => onNavigate?.call('/organization'),
                        ),
                      ],
                    ),
                    _DrawerMenuSection(
                      label: 'Hệ thống',
                      items:  [
                        _DrawerItem(
                          icon: Icons.settings_outlined,
                          label: AppStrings.generalConfig,
                          route: '/general-config',
                          onTap: () => onNavigate?.call('/general-config'),
                        ),
                        _DrawerItem(
                          icon: Icons.manage_accounts_outlined,
                          label: AppStrings.userManagement,
                          route: '/user-management',
                          onTap: () => onNavigate?.call('/user-management'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ),
            _DrawerFooter(onLogout: onLogout),
          ],
        ),
      ),
    );
  }
}

class _DrawerHeader extends StatelessWidget {
  const _DrawerHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 24, 16, 20),
      decoration: BoxDecoration(
        color: ColorApp.color005F9E.withValues(alpha: 0.05),
        border: Border(
          bottom: BorderSide(
            color: ColorApp.colorC0C7D3.withValues(alpha: 0.3),
          ),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: ColorApp.color005F9E.withValues(alpha: 0.2),
                    width: 2,
                  ),
                ),
                child: ClipOval(
                  child: Container(
                    color: ColorApp.colorECEEF0,
                    child: Icon(
                      Icons.person,
                      size: 28,
                      color: ColorApp.color707882,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'DAS Admin',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: ColorApp.color191C1E,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      AppStrings.adminRole,
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: ColorApp.color404751,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DrawerMenuSection extends StatelessWidget {
  final String label;
  final List<_DrawerItem> items;

  const _DrawerMenuSection({
    required this.label,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              label.toUpperCase(),
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: ColorApp.color005F9E,
                letterSpacing: 0.08,
              ),
            ),
          ),
          const SizedBox(height: 4),
          ...items,
        ],
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String? route;
  final VoidCallback? onTap;

  const _DrawerItem({
    required this.icon,
    required this.label,
    this.route,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final parent = context.findAncestorWidgetOfExactType<DashboardDrawerWidget>();
    final isActive = route != null && parent?.currentRoute == route;
    final activeColor = ColorApp.color005F9E;
    final defaultColor = ColorApp.color404751;
    final activeBg = ColorApp.color005F9E.withValues(alpha: 0.1);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 1),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: isActive ? activeBg : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 20,
              color: isActive ? activeColor : defaultColor,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 14,
                  fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                  color: isActive ? activeColor : defaultColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DrawerFooter extends StatelessWidget {
  final VoidCallback? onLogout;

  const _DrawerFooter({required this.onLogout});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: ColorApp.colorC0C7D3.withValues(alpha: 0.3),
          ),
        ),
      ),
      child: GestureDetector(
        onTap: onLogout,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: ColorApp.colorBA1A1A.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(
                Icons.logout,
                size: 20,
                color: ColorApp.colorBA1A1A,
              ),
              const SizedBox(width: 12),
              Text(
                AppStrings.logout,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: ColorApp.colorBA1A1A,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
