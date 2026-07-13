import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:obm_gen_with_ai/core/base/selector_base.dart';
import 'package:obm_gen_with_ai/core/constants/app_strings.dart';
import 'package:obm_gen_with_ai/core/constants/color_app.dart';
import 'package:obm_gen_with_ai/core/constants/route_generator.dart';
import 'package:obm_gen_with_ai/features/list_contract_real/component/list_contract_real_provider.dart';
import 'package:obm_gen_with_ai/features/list_contract_real/component/list_contract_real_service.dart';
import 'package:obm_gen_with_ai/features/list_contract_real/widget/item_contract_widget.dart';
import 'package:obm_gen_with_ai/core/constants/config_filter_app.dart';

class BodyListContractRealWidget extends StatefulWidget {
  const BodyListContractRealWidget({super.key});

  @override
  State<BodyListContractRealWidget> createState() => _BodyListContractRealWidgetState();
}

class _BodyListContractRealWidgetState extends State<BodyListContractRealWidget> {
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
      context.read<ListContractRealProvider>().searchContracts(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildHeader(),
        Expanded(
          child: ConsumerBase<ListContractRealService, ListContractRealProvider>(
            contextParent: context,
            onRepositoryLoading: (_) => const Center(child: CircularProgressIndicator()),
            onRepositorySuccess: (repo) => _buildList(repo as ListContractRealProvider),
            onRepositoryError: (repo) => _buildError(repo as ListContractRealProvider),
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
                    hintText: AppStrings.timKiemHopDong,
                    hintStyle: const TextStyle(fontSize: 14, color: Color(0xFFC0C7D3)),
                    prefixIcon: const Icon(Icons.search, color: Color(0xFF707882), size: 20),
                    filled: true,
                    fillColor: Colors.white,
                    prefixIconConstraints: const BoxConstraints(minWidth: 40, minHeight: 40),
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Color(0xFFC0C7D3)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Color(0xFFC0C7D3)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Color(0xFF005F9E), width: 1),
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
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFFC0C7D3)),
                  ),
                  child: const Icon(Icons.tune, color: Color(0xFF005F9E), size: 18),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Selector<ListContractRealProvider, int>(
            selector: (_, p) => p.totalContracts,
            builder: (ctx, count, _) {
              if (count == 0) return const SizedBox.shrink();
              return Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  AppStrings.hienThiSoHopDong(count),
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Color(0xFF404751)),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildList(ListContractRealProvider provider) {
    return RefreshIndicator(
      onRefresh: () => provider.loadContracts(),
      color: const Color(0xFF005F9E),
      child: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (notification is ScrollEndNotification) {
            final metrics = notification.metrics;
            if (metrics.pixels >= metrics.maxScrollExtent - 100) {
              provider.loadMoreContracts();
            }
          }
          return false;
        },
        child: ListView.separated(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 120),
          itemCount: provider.contracts.length + (provider.hasMore ? 1 : 0),
          separatorBuilder: (_, __) => const SizedBox(height: 16),
          itemBuilder: (ctx, index) {
            if (index == provider.contracts.length) {
              return const Center(
                child: Padding(padding: EdgeInsets.all(16), child: CircularProgressIndicator(strokeWidth: 2)),
              );
            }
            final contract = provider.contracts[index];
            return InkWell(
              onTap: () {
                Navigator.pushNamed(context, RouteGenerator.contractDetail, arguments: {'id': contract.id});
              },
              child: ItemContractWidget(
                contract: contract,
                onTapEdit: () {
                  final provider = context.read<ListContractRealProvider>();
                  Navigator.pushNamed(
                    context,
                    RouteGenerator.contractEdit,
                    arguments: {'id': contract.id},
                  ).then((_) {
                    if (!context.mounted) return;
                    provider.loadContracts();
                  });
                },
                onTapDelete: () {
                  _showDeleteConfirmDialog(context, provider, contract.id!, contract.name ?? '');
                },
              ),
            );
          },
        ),
      ),
    );
  }

  void _showDeleteConfirmDialog(
    BuildContext context,
    ListContractRealProvider provider,
    int contractId,
    String contractName,
  ) {
    showDialog(
      context: context,
      builder:
          (ctx) => AlertDialog(
            title: Text(AppStrings.xacNhanXoa),
            content: Text(AppStrings.banCoChacChanMuonXoaHopDong(contractName)),
            actions: [
              TextButton(onPressed: () => Navigator.pop(ctx), child: Text(AppStrings.huy)),
              TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                  provider.deleteContract(contractId, contractName);
                },
                child: Text(AppStrings.xoa, style: const TextStyle(color: Color(0xFFBA1A1A))),
              ),
            ],
          ),
    );
  }

  void _showFilterBottomSheet(BuildContext context) {
    final provider = context.read<ListContractRealProvider>();
    String tempStatus = provider.selectedStatus;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder:
          (ctx) => StatefulBuilder(
            builder:
                (ctx, setSheetState) => Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
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
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Color(0xFF191C1E)),
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
                              DropdownMenuItem<String>(value: '', child: Text(AppStrings.all)),
                              ...ConfigFilterApp.contractStatuses.map(
                                (s) => DropdownMenuItem(value: s.code, child: Text(s.label)),
                              ),
                            ],
                            onChanged: (v) {
                              setSheetState(() => tempStatus = v ?? '');
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
                                provider.applyStatusFilter(tempStatus);
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

  Widget _buildError(ListContractRealProvider provider) {
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
              onPressed: () => provider.loadContracts(),
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
          Text(AppStrings.khongCoHopDong, style: const TextStyle(fontSize: 14, color: Color(0xFF7D8798))),
        ],
      ),
    );
  }
}
