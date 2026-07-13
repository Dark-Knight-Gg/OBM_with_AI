import 'package:flutter/material.dart';
import 'package:obm_gen_with_ai/core/constants/app_strings.dart';
import 'package:obm_gen_with_ai/features/list_contract_real/model/list_contract_real_model.dart';


class ItemContractWidget extends StatelessWidget {
  final ContractModel contract;
  final VoidCallback? onTapEdit;
  final VoidCallback? onTapDelete;

  const ItemContractWidget({
    super.key,
    required this.contract,
    this.onTapEdit,
    this.onTapDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: contract.isActive ? 1.0 : 0.8,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border(left: BorderSide(color: contract.borderColor, width: 4)),
          boxShadow: const [
            BoxShadow(color: Color(0x14000000), blurRadius: 40, offset: Offset(0, 10)),
            BoxShadow(color: Color(0x0A000000), blurRadius: 10, offset: Offset(0, 2)),
          ],
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          contract.name ?? '',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: contract.isActive
                                ? const Color(0xFF005F9E)
                                : const Color(0xFF404751),
                            height: 1.3,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: contract.statusBgColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          contract.statusLabel ?? '',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: contract.statusTextColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  _buildGrid(),
                  const SizedBox(height: 6),
                  _buildValue(),
                ],
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                border: Border(top: BorderSide(color: Color(0xFFC0C7D3), width: 0.5)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: _ActionButton(
                      icon: Icons.edit_outlined,
                      label: AppStrings.chinhSua,
                      onTap: onTapEdit,
                    ),
                  ),
                  Container(
                    width: 0.5,
                    height: 48,
                    color: const Color(0xFFC0C7D3),
                  ),
                  Expanded(
                    child: _ActionButton(
                      icon: Icons.delete_outline,
                      label: AppStrings.xoa,
                      onTap: onTapDelete,
                      isDanger: true,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGrid() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _buildField(AppStrings.soHd, contract.contractNo ?? '---')),
            const SizedBox(width: 8),
            Expanded(child: _buildField(AppStrings.ngayKy, contract.signedDate ?? '---')),
          ],
        ),
        const SizedBox(height: 6),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _buildField(AppStrings.khachHang, contract.customerName ?? '---')),
            const SizedBox(width: 8),
            Expanded(child: _buildField(AppStrings.loai, contract.typeLabel ?? '---')),
          ],
        ),
        const SizedBox(height: 6),
        _buildField(AppStrings.donViChuTri, contract.owningUnitName ?? '---', fullWidth: true),
        const SizedBox(height: 6),
        _buildField(AppStrings.lienKet, contract.linkLabel ?? '---', fullWidth: true),
      ],
    );
  }

  Widget _buildField(String label, String value, {bool fullWidth = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Color(0xFF707882),
            letterSpacing: 1.0,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(0xFF191C1E),
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget _buildValue() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.giaTri.toUpperCase(),
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Color(0xFF707882),
            letterSpacing: 1.0,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          contract.formattedValue,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: contract.isActive
                ? const Color(0xFF005F9E)
                : const Color(0xFF707882),
            letterSpacing: -0.5,
          ),
        ),
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  final bool isDanger;

  const _ActionButton({
    required this.icon,
    required this.label,
    this.onTap,
    this.isDanger = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: isDanger ? const Color(0xFFFFCAD6) : const Color(0xFFE6E8EA),
      highlightColor: isDanger ? const Color(0xFFFFCAD6) : const Color(0xFFE6E8EA),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 20,
              color: isDanger ? const Color(0xFFBA1A1A) : const Color(0xFF404751),
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: isDanger ? const Color(0xFFBA1A1A) : const Color(0xFF404751),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
