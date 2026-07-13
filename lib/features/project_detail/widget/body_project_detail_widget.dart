import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:obm_gen_with_ai/core/base/toast/toast_event.dart';
import 'package:obm_gen_with_ai/core/constants/app_strings.dart';
import 'package:obm_gen_with_ai/features/project_detail/component/project_detail_provider.dart';
import 'package:obm_gen_with_ai/features/project_detail/model/project_detail_model.dart';

class BodyProjectDetailWidget extends StatelessWidget {
  const BodyProjectDetailWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final detail = context.watch<ProjectDetailProvider>().detail;
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF191C1E)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          AppStrings.chiTietDuAn,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Color(0xFF191C1E)),
        ),
      ),
      body:
          detail == null
              ? const SizedBox.shrink()
              : SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _ProjectHeader(detail: detail),
                    const SizedBox(height: 16),
                    _SectionGeneralInfo(detail: detail),
                    const SizedBox(height: 16),
                    _SectionValue(detail: detail),
                    const SizedBox(height: 16),
                    const _ManageAtOpportunityButton(),
                  ],
                ),
              ),
    );
  }
}

class _ProjectHeader extends StatelessWidget {
  final ProjectDetailModel detail;

  const _ProjectHeader({required this.detail});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${detail.opportunityCode ?? '—'} · ${detail.name ?? '—'}',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF191C1E)),
          ),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(color: const Color(0xFF1A73E8), borderRadius: BorderRadius.circular(4)),
            child: Text(
              detail.statusLabel ?? '—',
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionGeneralInfo extends StatefulWidget {
  final ProjectDetailModel detail;

  const _SectionGeneralInfo({required this.detail});

  @override
  State<_SectionGeneralInfo> createState() => _SectionGeneralInfoState();
}

class _SectionGeneralInfoState extends State<_SectionGeneralInfo> {
  bool _isExpanded = true;

  @override
  Widget build(BuildContext context) {
    return _CollapsibleSection(
      isExpanded: _isExpanded,
      onToggle: () => setState(() => _isExpanded = !_isExpanded),
      icon: Icons.info_outline,
      iconColor: const Color(0xFF005F9E),
      title: AppStrings.thongTinChung,
      titleNote: AppStrings.keThuaTuCoHoi,
      child: _InfoGrid(detail: widget.detail),
    );
  }
}

class _SectionValue extends StatefulWidget {
  final ProjectDetailModel detail;

  const _SectionValue({required this.detail});

  @override
  State<_SectionValue> createState() => _SectionValueState();
}

class _SectionValueState extends State<_SectionValue> {
  bool _isExpanded = true;

  @override
  Widget build(BuildContext context) {
    return _CollapsibleSection(
      isExpanded: _isExpanded,
      onToggle: () => setState(() => _isExpanded = !_isExpanded),
      icon: Icons.payments_outlined,
      iconColor: const Color(0xFF005F9E),
      title: AppStrings.giaTriDong,
      child: _ValueContent(detail: widget.detail),
    );
  }
}

class _CollapsibleSection extends StatelessWidget {
  final bool isExpanded;
  final VoidCallback onToggle;
  final IconData icon;
  final Color iconColor;
  final String title;
  final String? titleNote;
  final Widget child;

  const _CollapsibleSection({
    required this.isExpanded,
    required this.onToggle,
    required this.icon,
    required this.iconColor,
    required this.title,
    this.titleNote,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFC0C7D3)),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          InkWell(
            onTap: onToggle,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: const Color(0xFF0078C7).withValues(alpha: 0.1),
                border: Border(bottom: BorderSide(color: const Color(0xFFC0C7D3).withValues(alpha: 0.3))),
              ),
              child: Row(
                children: [
                  Icon(icon, color: iconColor, size: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: title,
                            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Color(0xFF191C1E)),
                          ),
                          if (titleNote != null) ...[
                            const TextSpan(text: ' '),
                            TextSpan(
                              text: titleNote,
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF404751),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                  AnimatedRotation(
                    turns: isExpanded ? 0.5 : 0,
                    duration: const Duration(milliseconds: 300),
                    child: const Icon(Icons.expand_more, color: Color(0xFF707882), size: 20),
                  ),
                ],
              ),
            ),
          ),
          AnimatedCrossFade(
            firstChild: child,
            secondChild: const SizedBox.shrink(),
            crossFadeState: isExpanded ? CrossFadeState.showFirst : CrossFadeState.showSecond,
            duration: const Duration(milliseconds: 300),
          ),
        ],
      ),
    );
  }
}

class _InfoGrid extends StatelessWidget {
  final ProjectDetailModel detail;

  const _InfoGrid({required this.detail});

  Widget _row(String label, String? value, {bool isPlaceholder = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xFF404751)),
            ),
          ),
          Expanded(
            child: Text(
              value ?? '—',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: isPlaceholder ? const Color(0xFF707882) : const Color(0xFF191C1E),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _row(AppStrings.khachHang, detail.customerName),
          const Divider(height: 1, color: Color(0xFFC0C7D3)),
          _row(AppStrings.donViChuTri, detail.owningUnitName),
          const Divider(height: 1, color: Color(0xFFC0C7D3)),
          _row(AppStrings.quanLyDuAn, detail.projectManagerName, isPlaceholder: true),
          const Divider(height: 1, color: Color(0xFFC0C7D3)),
          _row(AppStrings.loaiSPDichVu, detail.productCategoryName),
          const Divider(height: 1, color: Color(0xFFC0C7D3)),
          _row(AppStrings.linhVuc, detail.fieldLabel),
          const Divider(height: 1, color: Color(0xFFC0C7D3)),
          _row(AppStrings.maJiraProject, detail.jiraProjectKey, isPlaceholder: true),
          if (detail.jiraProjectKey == null || detail.jiraProjectKey!.isEmpty) ...[
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  AppStrings.tienDoCongViecTheoDoiQuaJira,
                  style: const TextStyle(fontSize: 11, fontStyle: FontStyle.italic, color: Color(0xFF707882)),
                ),
              ),
            ),
          ],
          const Divider(height: 1, color: Color(0xFFC0C7D3)),
          _row(AppStrings.ngayBatDau, detail.startDate),
          const Divider(height: 1, color: Color(0xFFC0C7D3)),
          _row(AppStrings.ngayKetThuc, detail.endDate, isPlaceholder: true),
        ],
      ),
    );
  }
}

class _ValueContent extends StatelessWidget {
  final ProjectDetailModel detail;

  const _ValueContent({required this.detail});

  String _formatCurrency(double? amount) {
    if (amount == null) return '—';
    return '${amount.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]},')} đ';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _ValueRow(
            label: AppStrings.tongMucDuKien,
            value: _formatCurrency(detail.estimatedValue),
            valueColor: const Color(0xFF2E7D32),
            isBold: true,
          ),
          const SizedBox(height: 12),
          _ValueRow(
            label: AppStrings.forecast,
            value: _formatCurrency(detail.forecastRevenue),
            valueColor: const Color(0xFF005F9E),
            isBold: true,
          ),
          const SizedBox(height: 16),
          Align(
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.ghiChu,
                  style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Color(0xFF404751)),
                ),
                const SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  constraints: const BoxConstraints(minHeight: 60),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF2F4F6),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFFC0C7D3)),
                  ),
                  child: Text(detail.note ?? '—', style: const TextStyle(fontSize: 14, color: Color(0xFF707882))),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ValueRow extends StatelessWidget {
  final String label;
  final String value;
  final Color valueColor;
  final bool isBold;

  const _ValueRow({required this.label, required this.value, required this.valueColor, required this.isBold});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xFF404751))),
        Text(
          value,
          style: TextStyle(fontSize: 16, fontWeight: isBold ? FontWeight.w700 : FontWeight.w600, color: valueColor),
        ),
      ],
    );
  }
}

class _ManageAtOpportunityButton extends StatelessWidget {
  const _ManageAtOpportunityButton();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: OutlinedButton.icon(
        onPressed: () {
          context.read<ProjectDetailProvider>().showToast(AppStrings.tinhNangDangPhatTrien, type: ToastType.normal);
        },
        style: OutlinedButton.styleFrom(
          foregroundColor: const Color(0xFF005F9E),
          side: const BorderSide(color: Color(0xFF005F9E)),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        icon: const Icon(Icons.edit_note, size: 18),
        label: Text(AppStrings.quanLyOCoHoi, style: const TextStyle(fontSize: 13)),
      ),
    );
  }
}
