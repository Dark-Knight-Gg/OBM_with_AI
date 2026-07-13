import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:obm_gen_with_ai/core/constants/app_strings.dart';
import 'package:obm_gen_with_ai/core/constants/color_app.dart';
import 'package:obm_gen_with_ai/features/dashboard/component/dashboard_provider.dart';

class BodyDashboardWidget extends StatelessWidget {
  const BodyDashboardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const _DashboardContent();
  }
}

class _DashboardContent extends StatelessWidget {
  const _DashboardContent();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorApp.colorF7F9FB,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const _FilterSection(),
            const _RevenueInfoBanner(),
            const _StatCardsGrid(),
            const _RevenueTrendChart(),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class _FilterSection extends StatelessWidget {
  const _FilterSection();

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<DashboardProvider>();
    final isExpanded = provider.showFilters;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: ColorApp.colorC0C7D3.withValues(alpha: 0.3)),
        boxShadow: const [
          BoxShadow(color: Color(0x0D000000), blurRadius: 20, offset: Offset(0, 4)),
          BoxShadow(color: Color(0x0A000000), blurRadius: 12, offset: Offset(0, 2)),
        ],
      ),
      child: Column(
        children: [
          _FilterToggleRow(isExpanded: isExpanded, onTap: provider.toggleFilters),
          AnimatedCrossFade(
            duration: const Duration(milliseconds: 300),
            crossFadeState: isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
            firstChild: const SizedBox.shrink(),
            secondChild: _FilterForm(provider: provider),
          ),
        ],
      ),
    );
  }
}

class _FilterToggleRow extends StatelessWidget {
  final bool isExpanded;
  final VoidCallback onTap;

  const _FilterToggleRow({required this.isExpanded, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: ColorApp.colorF2F4F6.withValues(alpha: 0.5),
          borderRadius: isExpanded ? const BorderRadius.vertical(top: Radius.circular(12)) : BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(Icons.filter_alt, size: 20, color: ColorApp.color005F9E),
            const SizedBox(width: 8),
            Text(
              isExpanded ? AppStrings.hideFilters : AppStrings.showFilters,
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: ColorApp.color191C1E,
              ),
            ),
            const Spacer(),
            AnimatedRotation(
              turns: isExpanded ? 0.5 : 0,
              duration: const Duration(milliseconds: 200),
              child: Icon(Icons.expand_more, size: 20, color: ColorApp.color404751),
            ),
          ],
        ),
      ),
    );
  }
}

class _FilterForm extends StatelessWidget {
  final DashboardProvider provider;

  const _FilterForm({required this.provider});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(border: Border(top: BorderSide(color: ColorApp.colorC0C7D3.withValues(alpha: 0.3)))),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(child: _YearDropdown(provider: provider)),
              const SizedBox(width: 12),
              Expanded(child: _PriceTypeDropdown(provider: provider)),
            ],
          ),
          const SizedBox(height: 12),
          _UnitDropdown(provider: provider),
          const SizedBox(height: 12),
          _DepartmentDropdown(provider: provider),
          const SizedBox(height: 12),
          _ProductServiceDropdown(provider: provider),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: _FilterButton(provider: provider)),
              const SizedBox(width: 8),
              _RefreshButton(provider: provider),
            ],
          ),
        ],
      ),
    );
  }
}

class _YearDropdown extends StatelessWidget {
  final DashboardProvider provider;

  const _YearDropdown({required this.provider});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.year.toUpperCase(),
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 11,
            fontWeight: FontWeight.w700,
            color: ColorApp.color404751.withValues(alpha: 0.6),
            letterSpacing: 0.05,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          height: 40,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: ColorApp.colorC0C7D3.withValues(alpha: 0.3)),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<int>(
              value: provider.selectedYear,
              isExpanded: true,
              icon: Icon(Icons.arrow_drop_down, color: ColorApp.color707882),
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: ColorApp.color191C1E,
              ),
              items:
                  [
                    2026,
                    2025,
                    2024,
                  ].map((year) => DropdownMenuItem<int>(value: year, child: Text(year.toString()))).toList(),
              onChanged: (value) {
                if (value != null) provider.setYear(value);
              },
            ),
          ),
        ),
      ],
    );
  }
}

class _PriceTypeDropdown extends StatelessWidget {
  final DashboardProvider provider;

  const _PriceTypeDropdown({required this.provider});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.priceType.toUpperCase(),
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 11,
            fontWeight: FontWeight.w700,
            color: ColorApp.color404751.withValues(alpha: 0.6),
            letterSpacing: 0.05,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          height: 40,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: ColorApp.colorC0C7D3.withValues(alpha: 0.3)),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: provider.selectedPriceType,
              isExpanded: true,
              icon: Icon(Icons.arrow_drop_down, color: ColorApp.color707882),
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: ColorApp.color191C1E,
              ),
              items: const [DropdownMenuItem<String>(value: 'Doanh thu chủ quản', child: Text('Doanh thu chủ quản'))],
              onChanged: (value) {
                if (value != null) provider.setPriceType(value);
              },
            ),
          ),
        ),
      ],
    );
  }
}

class _UnitDropdown extends StatelessWidget {
  final DashboardProvider provider;

  const _UnitDropdown({required this.provider});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${AppStrings.unit} (Line)'.toUpperCase(),
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 11,
            fontWeight: FontWeight.w700,
            color: ColorApp.color404751.withValues(alpha: 0.6),
            letterSpacing: 0.05,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          height: 40,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: ColorApp.colorC0C7D3.withValues(alpha: 0.3)),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: provider.selectedUnit.isEmpty ? null : provider.selectedUnit,
              isExpanded: true,
              hint: Text(
                AppStrings.all,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: ColorApp.color707882,
                ),
              ),
              icon: Icon(Icons.arrow_drop_down, color: ColorApp.color707882),
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: ColorApp.color191C1E,
              ),
              items: provider.filterOptions?.units?.map((e)=> DropdownMenuItem<String>(value: e.id, child: Text(e.name ?? ''))).toList(),
              onChanged: (value) => provider.setUnit(value ?? ''),
            ),
          ),
        ),
      ],
    );
  }
}

class _DepartmentDropdown extends StatelessWidget {
  final DashboardProvider provider;

  const _DepartmentDropdown({required this.provider});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.department.toUpperCase(),
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 11,
            fontWeight: FontWeight.w700,
            color: ColorApp.color404751.withValues(alpha: 0.6),
            letterSpacing: 0.05,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          height: 40,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: ColorApp.colorC0C7D3.withValues(alpha: 0.3)),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: provider.selectedDepartment.isEmpty ? null : provider.selectedDepartment,
              isExpanded: true,
              hint: Text(
                AppStrings.all,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: ColorApp.color707882,
                ),
              ),
              icon: Icon(Icons.arrow_drop_down, color: ColorApp.color707882),
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: ColorApp.color191C1E,
              ),
                items: provider.filterOptions?.departments?.map((e)=> DropdownMenuItem<String>(value: e.id, child: Text(e.name??''))).toList(),
              onChanged: (value) => provider.setDepartment(value ?? ''),
            ),
          ),
        ),
      ],
    );
  }
}

class _ProductServiceDropdown extends StatelessWidget {
  final DashboardProvider provider;

  const _ProductServiceDropdown({required this.provider});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.productService.toUpperCase(),
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 11,
            fontWeight: FontWeight.w700,
            color: ColorApp.color404751.withValues(alpha: 0.6),
            letterSpacing: 0.05,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          height: 40,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: ColorApp.colorC0C7D3.withValues(alpha: 0.3)),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: provider.selectedProductService.isEmpty ? null : provider.selectedProductService,
              isExpanded: true,
              hint: Text(
                AppStrings.all,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: ColorApp.color707882,
                ),
              ),
              icon: Icon(Icons.arrow_drop_down, color: ColorApp.color707882),
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: ColorApp.color191C1E,
              ),
                items: provider.filterOptions?.productServices?.map((e)=> DropdownMenuItem<String>(value: e.id, child: Text(e.name ?? ''))).toList(),
              onChanged: (value) => provider.setProductService(value ?? ''),
            ),
          ),
        ),
      ],
    );
  }
}

class _FilterButton extends StatelessWidget {
  final DashboardProvider provider;

  const _FilterButton({required this.provider});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => provider.applyFilters(),
      child: Container(
        height: 40,
        decoration: BoxDecoration(color: ColorApp.color005F9E, borderRadius: BorderRadius.circular(8)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.filter_alt, size: 18, color: Colors.white),
            const SizedBox(width: 8),
            Text(
              AppStrings.filterResults,
              style: TextStyle(fontFamily: 'Inter', fontSize: 14, fontWeight: FontWeight.w700, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

class _RefreshButton extends StatelessWidget {
  final DashboardProvider provider;

  const _RefreshButton({required this.provider});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => provider.refreshData(),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: ColorApp.colorC0C7D3.withValues(alpha: 0.3)),
        ),
        child: Icon(Icons.refresh, size: 20, color: ColorApp.color404751),
      ),
    );
  }
}

class _RevenueInfoBanner extends StatelessWidget {
  const _RevenueInfoBanner();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ColorApp.color005F9E.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: ColorApp.color005F9E.withValues(alpha: 0.1)),
      ),
      child: Row(
        children: [
          Icon(Icons.info_outline, size: 18, color: ColorApp.color005F9E),
          const SizedBox(width: 8),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  height: 1.5,
                  color: ColorApp.color404751,
                ),
                children: [
                  TextSpan(
                    text: AppStrings.totalRevenue.toUpperCase(),
                    style: TextStyle(fontWeight: FontWeight.w700, color: ColorApp.color005F9E),
                  ),
                  TextSpan(text: ' ${AppStrings.revenueNote} '),
                  TextSpan(
                    text: AppStrings.revenueReportLink,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: ColorApp.color005F9E,
                      decoration: TextDecoration.underline,
                      decorationColor: ColorApp.color005F9E.withValues(alpha: 0.3),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatCardsGrid extends StatelessWidget {
  const _StatCardsGrid();

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<DashboardProvider>();
    final data = provider.dashboardData;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _StatCard(
                  gradient: const LinearGradient(
                    colors: [ColorApp.color12B76A, ColorApp.color0E9355],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  icon: Icons.trending_up,
                  label: AppStrings.totalRevenue.toUpperCase(),
                  value: _formatCurrency(data?.totalRevenueActual ?? 6.0),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _StatCard(
                  gradient: const LinearGradient(
                    colors: [ColorApp.color0078C7, ColorApp.color005F9E],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  icon: Icons.shopping_cart_outlined,
                  label: AppStrings.totalOrders.toUpperCase(),
                  value: _formatCurrency(data?.totalOrderValue ?? 0.595),
                  suffix: ' đ',
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _StatCard(
                  gradient: const LinearGradient(
                    colors: [ColorApp.color12B76A, ColorApp.color0E9355],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  icon: Icons.bar_chart,
                  label: AppStrings.expectedRevenue.toUpperCase(),
                  value: _formatCurrency(data?.expectedRevenue ?? 5.0),
                  opacity: 0.95,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _StatCard(
                  gradient: const LinearGradient(
                    colors: [ColorApp.colorF79009, ColorApp.colorD97706],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  icon: Icons.groups,
                  label: AppStrings.totalResources.toUpperCase(),
                  value: (data?.totalResources ?? 9).toString(),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _StatCard(
            gradient: const LinearGradient(
              colors: [ColorApp.colorF04438, ColorApp.colorD92D20],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            icon: Icons.report_problem_outlined,
            label: AppStrings.openRisks.toUpperCase(),
            value: (data?.openRisks ?? 6).toString(),
          ),
        ],
      ),
    );
  }

  String _formatCurrency(double value) {
    if (value >= 1000000000) {
      return '${(value / 1000000000).toStringAsFixed(1)}B';
    } else if (value >= 1000000) {
      return '${(value / 1000000).toStringAsFixed(1)}M';
    }
    return value.toStringAsFixed(0);
  }
}

class _StatCard extends StatelessWidget {
  final LinearGradient gradient;
  final IconData icon;
  final String label;
  final String value;
  final double opacity;
  final String suffix;

  const _StatCard({
    required this.gradient,
    required this.icon,
    required this.label,
    required this.value,
    this.opacity = 1.0,
    this.suffix = ' đ',
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: opacity,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(color: Color(0x0D000000), blurRadius: 20, offset: Offset(0, 4)),
            BoxShadow(color: Color(0x0A000000), blurRadius: 12, offset: Offset(0, 2)),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, size: 16, color: Colors.white),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 10,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.05,
                color: Colors.white.withValues(alpha: 0.8),
              ),
            ),
            const SizedBox(height: 4),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  value,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),
                if (suffix.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(left: 4, bottom: 1),
                    child: Text(
                      suffix,
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Colors.white.withValues(alpha: 0.8),
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _RevenueTrendChart extends StatelessWidget {
  const _RevenueTrendChart();

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<DashboardProvider>();
    final barHeights = provider.revenueBarHeights;
    final monthLabels = provider.revenueMonthLabels;

    return Container(
      margin: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(color: Color(0x0D000000), blurRadius: 20, offset: Offset(0, 4)),
          BoxShadow(color: Color(0x0A000000), blurRadius: 12, offset: Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppStrings.revenueTrend,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: ColorApp.color191C1E,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    AppStrings.annualRevenueReport,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      color: ColorApp.color404751,
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(color: ColorApp.colorF2F4F6, borderRadius: BorderRadius.circular(8)),
                  child: Icon(Icons.more_horiz, size: 20, color: ColorApp.color404751),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 160,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: List.generate(barHeights.length, (index) {
                return Expanded(
                  child: _ChartBar(
                    heightFraction: barHeights[index],
                    label: monthLabels.length > index ? monthLabels[index] : '',
                    index: index,
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

class _ChartBar extends StatelessWidget {
  final double heightFraction;
  final String label;
  final int index;

  const _ChartBar({required this.heightFraction, required this.label, required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final maxHeight = constraints.maxHeight;
                  return Align(
                    alignment: Alignment.bottomCenter,
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 300 + (index * 50)),
                      curve: Curves.easeOut,
                      height: maxHeight * heightFraction.clamp(0.05, 1.0),
                      decoration: BoxDecoration(
                        color: ColorApp.color005F9E.withValues(alpha: 0.8),
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 10,
                fontWeight: FontWeight.w700,
                color: ColorApp.color404751,
              ),
            ),
          ],
        ),
    );
  }
}
