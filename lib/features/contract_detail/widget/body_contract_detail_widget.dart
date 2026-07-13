import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:obm_gen_with_ai/core/constants/color_app.dart';
import 'package:obm_gen_with_ai/core/constants/app_strings.dart';
import 'package:obm_gen_with_ai/features/contract_detail/component/contract_detail_provider.dart';
import 'package:obm_gen_with_ai/features/contract_detail/model/contract_detail_model.dart';

class BodyContractDetailWidget extends StatelessWidget {
  const BodyContractDetailWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ContractDetailProvider>();
    final contract = provider.contract;

    if (contract == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return  Scaffold(
      backgroundColor: const Color(0xFFF7F9FB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF191C1E)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          AppStrings.chiTietHopDong,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Color(0xFF191C1E)),
        ),
      ),
      body:      SingleChildScrollView(
        padding: const EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 48),
        child: Column(
          children: [
            _SummarySection(contract: contract),
            const SizedBox(height: 16),
            _AccordionSection(
              title: AppStrings.lienKetVaPhanLoai,
              icon: Icons.link,
              child: _LinkClassificationContent(contract: contract),
            ),
            const SizedBox(height: 16),
            _AccordionSection(
              title: AppStrings.thongTinHopDong,
              icon: Icons.description_outlined,
              child: _ContractInfoContent(contract: contract),
            ),
            const SizedBox(height: 16),
            _AccordionSection(
              title: AppStrings.mocThoiGian,
              icon: Icons.calendar_month_outlined,
              child: _TimelineContent(contract: contract, provider: provider),
            ),
            const SizedBox(height: 16),
            _AccordionSection(
              title: AppStrings.giaTriDong,
              icon: Icons.payments_outlined,
              child: _ValueContent(contract: contract, provider: provider),
            ),
            const SizedBox(height: 16),
            _AccordionSection(
              title: AppStrings.dieuKhoanVaGhiChu,
              icon: Icons.notes,
              child: _TermsContent(contract: contract, provider: provider),
            ),
          ],
        ),
      ),
    );


  }
}

class _SummarySection extends StatelessWidget {
  final ContractDetailModel contract;

  const _SummarySection({required this.contract});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: ColorApp.colorC0C7D3.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '#${contract.contractNo ?? AppStrings.dashDash}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF005F9E),
                ),
              ),
              _StatusBadge(
                label: contract.statusLabel ?? AppStrings.dashDash,
                statusBadge: contract.statusBadge,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            contract.name ?? AppStrings.dashDash,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              height: 1.3,
              color: Color(0xFF191C1E),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final String label;
  final String? statusBadge;

  const _StatusBadge({required this.label, this.statusBadge});

  @override
  Widget build(BuildContext context) {
    Color bgColor;
    Color textColor;

    if (statusBadge != null && statusBadge!.isNotEmpty) {
      try {
        final hex = statusBadge!.replaceAll('#', '');
        final colorVal = int.parse('FF$hex', radix: 16);
        bgColor = Color(colorVal).withValues(alpha: 0.2);
        textColor = Color(colorVal);
      } catch (_) {
        bgColor = ColorApp.colorD1E7DD;
        textColor = ColorApp.color0F5132;
      }
    } else {
      bgColor = ColorApp.colorD1E7DD;
      textColor = ColorApp.color0F5132;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(9999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check_circle, size: 14, color: textColor),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w400,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}

class _AccordionSection extends StatefulWidget {
  final String title;
  final IconData icon;
  final Widget child;

  const _AccordionSection({
    required this.title,
    required this.icon,
    required this.child,
  });

  @override
  State<_AccordionSection> createState() => _AccordionSectionState();
}

class _AccordionSectionState extends State<_AccordionSection> {
  bool _isExpanded = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: const Color(0xFFC0C7D3)),
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: () => setState(() => _isExpanded = !_isExpanded),
            behavior: HitTestBehavior.opaque,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: const Color(0xFF0078C7).withValues(alpha: 0.1),
                borderRadius: _isExpanded
                    ? const BorderRadius.vertical(top: Radius.circular(12))
                    : BorderRadius.circular(12),
                border: Border(
                  bottom: BorderSide(color: const Color(0xFFC0C7D3).withValues(alpha: 0.3)),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(widget.icon, size: 20, color: ColorApp.color005F9E),
                      const SizedBox(width: 8),
                      Text(
                        widget.title,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF191C1E),
                        ),
                      ),
                    ],
                  ),
                  AnimatedRotation(
                    turns: _isExpanded ? 0 : 0.5,
                    duration: const Duration(milliseconds: 200),
                    child: const Icon(
                      Icons.expand_more,
                      color: Color(0xFF404751),
                    ),
                  ),
                ],
              ),
            ),
          ),
          AnimatedCrossFade(
            firstChild: Padding(
              padding: const EdgeInsets.all(20),
              child: widget.child,
            ),
            secondChild: const SizedBox.shrink(),
            crossFadeState:
                _isExpanded ? CrossFadeState.showFirst : CrossFadeState.showSecond,
            duration: const Duration(milliseconds: 200),
          ),
        ],
      ),
    );
  }
}

class _LinkClassificationContent extends StatelessWidget {
  final ContractDetailModel contract;

  const _LinkClassificationContent({required this.contract});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _LabelValue(
          label: AppStrings.donViChuTri,
          value: contract.owningUnitName,
        ),
        const SizedBox(height: 8),
        _LabelValue(
          label: AppStrings.khachHang,
          value: contract.customerName,
        ),
        const SizedBox(height: 8),
        _LabelValue(
          label: AppStrings.spDvCungCap,
          value: contract.productServiceName,
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: _LabelValue(
                label: AppStrings.diaBan,
                value: contract.regionLabel,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _LabelValue(
                label: AppStrings.linhVuc,
                value: contract.fieldLabel,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        _LinkLabelValue(
          label: AppStrings.duAn,
          value: contract.projectName,
          onTap: contract.projectId != null
              ? () {
                  Navigator.of(context).pushNamed(
                    '/project-detail',
                    arguments: contract.projectId,
                  );
                }
              : null,
        ),
      ],
    );
  }
}

class _ContractInfoContent extends StatelessWidget {
  final ContractDetailModel contract;

  const _ContractInfoContent({required this.contract});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: _LabelValue(
                label: AppStrings.soHopDong,
                value: contract.contractNo,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _LabelValue(
                label: AppStrings.loaiHopDong,
                value: contract.typeLabel,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        _LabelValue(
          label: AppStrings.nhanSuChuyenQuan,
          value: contract.managerName,
        ),
        const SizedBox(height: 8),
        _LabelValue(
          label: AppStrings.thoiGianThueBhThang,
          value: contract.durationMonths?.toString() ?? AppStrings.dashDash,
        ),
      ],
    );
  }
}

class _TimelineContent extends StatelessWidget {
  final ContractDetailModel contract;
  final ContractDetailProvider provider;

  const _TimelineContent({required this.contract, required this.provider});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _RowLabelValue(
          label: AppStrings.ngayKyHd,
          value: provider.formatDate(contract.signedDate),
        ),
        const SizedBox(height: 8),
        _RowLabelValue(
          label: AppStrings.ngayNghiemThuVaoSd,
          value: provider.formatDate(contract.acceptanceDate),
        ),
        const SizedBox(height: 8),
        _RowLabelValue(
          label: AppStrings.hetHanHdBhbt,
          value: provider.formatDate(contract.expiryDate),
          valueColor:
              provider.isExpiringSoon ? ColorApp.colorBA1A1A : Color(0xFF191C1E),
        ),
      ],
    );
  }
}

class _ValueContent extends StatelessWidget {
  final ContractDetailModel contract;
  final ContractDetailProvider provider;

  const _ValueContent({required this.contract, required this.provider});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _RowLabelValue(
          label: AppStrings.giaTriHd,
          value: provider.formatCurrency(contract.contractValue),
        ),
        const SizedBox(height: 8),
        _RowLabelValue(
          label: AppStrings.giaTriVeVnpt,
          value: provider.formatCurrency(contract.vnptValue),
        ),
        const SizedBox(height: 8),
        _RowLabelValue(
          label: AppStrings.tiLeVeIt,
          value: provider.formatPercent(contract.itPercent),
        ),
        const SizedBox(height: 8),
        _TotalValueRow(
          value: provider.formatCurrency(contract.vnptItValue),
        ),
      ],
    );
  }
}

class _TermsContent extends StatelessWidget {
  final ContractDetailModel contract;
  final ContractDetailProvider provider;

  const _TermsContent({required this.contract, required this.provider});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _BoxContent(
          label: AppStrings.dieuKhoanRangBuoc,
          content: provider.orEmpty(contract.bindingTerms),
        ),
        const SizedBox(height: 8),
        _BoxContent(
          label: AppStrings.ghiChu,
          content: provider.orEmpty(contract.note),
        ),
      ],
    );
  }
}

class _LabelValue extends StatelessWidget {
  final String label;
  final String? value;

  const _LabelValue({required this.label, this.value});

  @override
  Widget build(BuildContext context) {
    final display = value?.isNotEmpty == true ? value! : AppStrings.dashDash;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: Color(0xFF404751),
          ),
        ),
        const SizedBox(height: 2),
        Text(
          display,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Color(0xFF191C1E),
          ),
        ),
      ],
    );
  }
}

class _LinkLabelValue extends StatelessWidget {
  final String label;
  final String? value;
  final VoidCallback? onTap;

  const _LinkLabelValue({
    required this.label,
    this.value,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final display = value?.isNotEmpty == true ? value! : AppStrings.dashDash;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: Color(0xFF404751),
          ),
        ),
        const SizedBox(height: 2),
        GestureDetector(
          onTap: onTap,
          child: Text(
            display,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF005F9E),
              decoration: onTap != null ? TextDecoration.underline : null,
            ),
          ),
        ),
      ],
    );
  }
}

class _RowLabelValue extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;

  const _RowLabelValue({
    required this.label,
    required this.value,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Color(0xFF404751),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: valueColor ?? const Color(0xFF191C1E),
          ),
        ),
      ],
    );
  }
}

class _TotalValueRow extends StatelessWidget {
  final String value;

  const _TotalValueRow({required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 16),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: ColorApp.colorC0C7D3.withValues(alpha: 0.2),
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const Text(
            'TỔNG GIÁ TRỊ VNPT-IT',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Color(0xFF005F9E),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w400,
              color: Color(0xFF005F9E),
            ),
          ),
        ],
      ),
    );
  }
}

class _BoxContent extends StatelessWidget {
  final String label;
  final String content;

  const _BoxContent({required this.label, required this.content});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: Color(0xFF404751),
          ),
        ),
        const SizedBox(height: 6),
        Container(
          width: double.infinity,
          constraints: const BoxConstraints(minHeight: 60),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: ColorApp.colorF2F4F6,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: ColorApp.colorC0C7D3.withValues(alpha: 0.1),
            ),
          ),
          child: Text(
            content,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              fontStyle: FontStyle.italic,
              color: Color(0xFF191C1E),
            ),
          ),
        ),
      ],
    );
  }
}
