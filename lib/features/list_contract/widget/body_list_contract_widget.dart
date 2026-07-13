import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:obm_gen_with_ai/core/constants/app_strings.dart';
import 'package:obm_gen_with_ai/core/constants/route_generator.dart';
import 'package:obm_gen_with_ai/core/base/selector_base.dart';
import 'package:obm_gen_with_ai/features/list_contract/component/list_contract_provider.dart';
import 'package:obm_gen_with_ai/features/list_contract/component/list_contract_service.dart';
import 'package:obm_gen_with_ai/features/list_contract/widget/item_project_widget.dart';
import 'package:obm_gen_with_ai/core/constants/color_app.dart';
import 'package:obm_gen_with_ai/core/constants/config_filter_app.dart';

class BodyListContractWidget extends StatefulWidget {
  const BodyListContractWidget({super.key});

  @override
  State<BodyListContractWidget> createState() => _BodyListContractWidgetState();
}

class _BodyListContractWidgetState extends State<BodyListContractWidget> {
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged(String value) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      context.read<ListContractProvider>().searchProjects(value);
    });
  }

  void _showFilterBottomSheet(BuildContext context) {
    final provider = context.read<ListContractProvider>();
    String tempStatus = provider.selectedStatus;
    String tempField = provider.selectedField;
    int? tempUnitId = provider.selectedUnitId;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder:
          (ctx) => StatefulBuilder(
            builder:
                (ctx, setSheetState) => Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                    boxShadow: const [BoxShadow(color: Color(0x14000000), blurRadius: 40, offset: Offset(0, -10))],
                  ),
                  padding: EdgeInsets.only(
                    left: 16,
                    right: 16,
                    top: 12,
                    bottom: MediaQuery.of(ctx).padding.bottom + 16,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          width: 48,
                          height: 4,
                          decoration: BoxDecoration(
                            color: const Color(0xFFE6E8EA),
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        AppStrings.boLocNangCao,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF191C1E),
                          height: 1.3,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        AppStrings.trangThai,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF404751),
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 8),
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
                            value: tempStatus.isEmpty ? null : tempStatus,
                            hint: Text(
                              AppStrings.all,
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: ColorApp.color707882,
                              ),
                            ),
                            isExpanded: true,
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: ColorApp.color191C1E,
                            ),
                            borderRadius: BorderRadius.circular(8),
                            items: [
                              const DropdownMenuItem<String>(value: '', child: Text('— Tất cả —')),
                              ...ConfigFilterApp.projectStatuses.map(
                                (s) => DropdownMenuItem(value: s.code, child: Text(s.label)),
                              ),
                            ],
                            onChanged: (v) {
                              setSheetState(() => tempStatus = v ?? '');
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Lĩnh vực',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF404751),
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 8),
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
                            value: tempField.isEmpty ? null : tempField,
                            hint: Text(
                              AppStrings.all,
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: ColorApp.color707882,
                              ),
                            ),
                            isExpanded: true,
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: ColorApp.color191C1E,
                            ),
                            borderRadius: BorderRadius.circular(8),
                            items: [
                              const DropdownMenuItem<String>(value: '', child: Text('— Tất cả —')),
                              ...ConfigFilterApp.projectFields.map(
                                    (s) => DropdownMenuItem(value: s.code, child: Text(s.label)),
                              ),
                            ],
                            onChanged: (v) {
                              setSheetState(() => tempField = v ?? '');
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        AppStrings.donViChuTri,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF404751),
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        height: 40,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: ColorApp.colorC0C7D3.withValues(alpha: 0.3)),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<int?>(
                            value: tempUnitId,
                            hint: Text(
                              AppStrings.all,
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: ColorApp.color707882,
                              ),
                            ),
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: ColorApp.color191C1E,
                            ),
                            isExpanded: true,
                            borderRadius: BorderRadius.circular(8),
                            items: [
                              const DropdownMenuItem<int?>(value: null, child: Text('— Tất cả —')),
                              ...provider.depts.map((d) => DropdownMenuItem(value: d.id, child: Text(d.name ?? ''))),
                            ],
                            onChanged: (v) {
                              setSheetState(() => tempUnitId = v);
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () {
                                Navigator.pop(ctx);
                                provider.clearFilters();
                              },
                              style: OutlinedButton.styleFrom(
                                foregroundColor: const Color(0xFF005F9E),
                                side: const BorderSide(color: Color(0xFF005F9E)),
                                padding: const EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              ),
                              child: Text(
                                AppStrings.huy,
                                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            flex: 2,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pop(ctx);
                                provider.applyFilters(status: tempStatus,field: tempField, unitId: tempUnitId);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF005F9E),
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                elevation: 0,
                              ),
                              child: Text(
                                AppStrings.apDung,
                                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildHeader(),
        Expanded(
          child: ConsumerBase<ListContractService, ListContractProvider>(
            contextParent: context,
            onRepositoryLoading: (_) => const Center(child: CircularProgressIndicator()),
            onRepositorySuccess: (repo) => _buildList(repo as ListContractProvider),
            onRepositoryError: (repo) => _buildError(repo as ListContractProvider),
            onRepositoryNoData: (_) => _buildEmpty(),
          ),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _searchController,
                  onChanged: _onSearchChanged,
                  style: const TextStyle(fontSize: 14, color: Color(0xFF191C1E)),
                  decoration: InputDecoration(
                    hintText: AppStrings.maHoacTenDuAn,
                    hintStyle: const TextStyle(fontSize: 14, color: Color(0xFF7D8798)),
                    prefixIcon: const Icon(Icons.search, color: Color(0xFF707882), size: 20),
                    filled: true,
                    fillColor: Colors.white,
                    prefixIconConstraints: const BoxConstraints(minWidth: 40, minHeight: 40),
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Color(0xFFC0C7D3)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Color(0xFFC0C7D3)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Color(0xFF005F9E), width: 2),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              GestureDetector(
                onTap: () => _showFilterBottomSheet(context),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFFC0C7D3)),
                    boxShadow: const [BoxShadow(color: Color(0x0A000000), blurRadius: 8, offset: Offset(0, 2))],
                  ),
                  child: const Icon(Icons.tune, color: Color(0xFF005F9E), size: 20),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Selector<ListContractProvider, int>(
            selector: (_, p) => p.totalProjects,
            builder: (ctx, count, _) {
              if (count == 0) return const SizedBox.shrink();
              return Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Hiển thị $count dự án',
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Color(0xFF404751)),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildList(ListContractProvider provider) {
    return RefreshIndicator(
      onRefresh: () => provider.loadProjects(),
      color: const Color(0xFF005F9E),
      child: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (notification is ScrollEndNotification) {
            final metrics = notification.metrics;
            if (metrics.pixels >= metrics.maxScrollExtent - 100) {
              provider.loadMoreProjects();
            }
          }
          return false;
        },
        child: ListView.separated(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 100),
          itemCount: provider.projects.length + (provider.hasMore ? 1 : 0),
          separatorBuilder: (_, __) => const SizedBox(height: 16),
          itemBuilder: (ctx, index) {
            if (index == provider.projects.length) {
              return const Center(
                child: Padding(padding: EdgeInsets.all(16), child: CircularProgressIndicator(strokeWidth: 2)),
              );
            }
            final project = provider.projects[index];
            return ItemProjectWidget(
              project: project,
              onTapEdit: () async {
                await Navigator.pushNamed(
                  context,
                  RouteGenerator.projectEdit,
                  arguments: project.id,
                ).then((value) {
                  provider.loadProjects();
                });
              },
              onTapView: () {
                Navigator.pushNamed(
                  context,
                  RouteGenerator.projectDetail,
                  arguments: project.id,
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildError(ListContractProvider provider) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              provider.errorMessage ?? AppStrings.warningNotConnectInternet,
              style: const TextStyle(fontSize: 14, color: Color(0xFF7D8798)),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            OutlinedButton(
              onPressed: () => provider.loadProjects(),
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFF005F9E),
                side: const BorderSide(color: Color(0xFF005F9E)),
              ),
              child: Text(AppStrings.refreshData),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmpty() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.inbox_outlined, size: 64, color: Color(0xFFC0C7D3)),
          const SizedBox(height: 16),
          Text(AppStrings.khongCoDuAn, style: const TextStyle(fontSize: 14, color: Color(0xFF7D8798))),
        ],
      ),
    );
  }
}
