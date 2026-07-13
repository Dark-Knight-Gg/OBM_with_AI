import 'package:flutter/material.dart';
import 'package:obm_gen_with_ai/core/constants/app_strings.dart';
import 'package:obm_gen_with_ai/features/list_contract/model/list_contract_model.dart';

class ItemProjectWidget extends StatelessWidget {
  final ListContractModel project;
  final VoidCallback? onTapEdit;
  final VoidCallback? onTapView;

  const ItemProjectWidget({super.key, required this.project, this.onTapEdit, this.onTapView});

  Color _getStatusColor() {
    switch (project.statusBadge) {
      case 'bg-primary':
        return const Color(0xFF005F9E);
      case 'bg-tertiary':
        return const Color(0xFF2A5AA7);
      case 'bg-success':
        return const Color(0xFF0CBA71);
      case 'bg-warning':
        return const Color(0xFFDE842F);
      default:
        return const Color(0xFF707882);
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusColor = _getStatusColor();
    final progress = project.progress ?? 0;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Color(0x14000000), blurRadius: 40, offset: Offset(0, 10)),
          BoxShadow(color: Color(0x0A000000), blurRadius: 10, offset: Offset(0, 2)),
        ],
        border: Border(left: BorderSide(color: statusColor, width: 4)),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Code badge + Title
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (project.code != null)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: statusColor.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          project.code!,
                          style: TextStyle(
                            fontFamily: 'JetBrains Mono',
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: statusColor,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    if (project.name != null) ...[
                      const SizedBox(height: 8),
                      Text(
                        project.name!,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF191C1E),
                          height: 1.3,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 16),
                // Metadata Grid
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: _buildMetaItem(AppStrings.khachHang, project.customerName ?? '---')),
                    const SizedBox(width: 8),
                    Expanded(child: _buildMetaItem(AppStrings.coHoiNguon, project.opportunityCode ?? '---')),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: _buildMetaItem(AppStrings.quanLyDA, project.projectManagerName ?? '---')),
                    const SizedBox(width: 8),
                    const Expanded(child: SizedBox()),
                  ],
                ),
                const SizedBox(height: 16),
                // Progress
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${AppStrings.tienDo.toUpperCase()} $progress%',
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF707882),
                            letterSpacing: 1.0,
                          ),
                        ),
                        Text(
                          project.statusLabel ?? '',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: statusColor,
                            letterSpacing: 1.0,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: progress / 100,
                        backgroundColor: const Color(0xFFECEEF0),
                        valueColor: AlwaysStoppedAnimation<Color>(statusColor),
                        minHeight: 6,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Forecast
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.duKienForecast.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF707882),
                        letterSpacing: 1.5,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      project.formattedForecastRevenue,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF005F9E),
                        letterSpacing: -0.5,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Action Row
          Container(
            decoration: const BoxDecoration(
              color: Color(0xFFF7F9FB),
              border: Border(top: BorderSide(color: Color(0xFFC0C7D3), width: 0.5)),
            ),
            child: Row(
              children: [
                Expanded(child: _ActionButton(icon: Icons.edit_outlined, label: AppStrings.chinhSua, onTap: onTapEdit)),
                Container(width: 0.5, height: 48, color: const Color(0xFFC0C7D3)),
                Expanded(
                  child: _ActionButton(icon: Icons.visibility_outlined, label: AppStrings.xem, onTap: onTapView),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetaItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w700,
            color: Color(0xFF707882),
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Color(0xFF191C1E)),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  const _ActionButton({required this.icon, required this.label, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: const Color(0xFFE6E8EA),
      highlightColor: const Color(0xFFE6E8EA),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 16, color: const Color(0xFF404751)),
            const SizedBox(width: 8),
            Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Color(0xFF404751))),
          ],
        ),
      ),
    );
  }
}
