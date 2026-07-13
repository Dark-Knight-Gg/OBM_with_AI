import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:obm_gen_with_ai/core/constants/app_strings.dart';
import 'package:obm_gen_with_ai/core/constants/color_app.dart';
import 'package:obm_gen_with_ai/core/constants/route_generator.dart';
import 'package:obm_gen_with_ai/features/add_contract/model/add_contract_model.dart';
import 'package:obm_gen_with_ai/features/edit_contract/component/edit_contract_provider.dart';

class BodyEditContractWidget extends StatefulWidget {
  final int contractId;
  const BodyEditContractWidget({super.key, required this.contractId});

  @override
  State<BodyEditContractWidget> createState() => _BodyEditContractWidgetState();
}

class _BodyEditContractWidgetState extends State<BodyEditContractWidget> {
  // ─── Section expanded/collapsed ─────────────────────────────────
  bool _expandedLink = true;
  bool _expandedInfo = true;
  bool _expandedTimeline = true;
  bool _expandedValue = true;
  bool _expandedTerms = true;

  // ─── Controllers ────────────────────────────────────────────────
  late final TextEditingController _contractNameController;
  late final TextEditingController _contractNoController;
  late final TextEditingController _managerController;
  late final TextEditingController _kmsController;
  late final TextEditingController _bindingTermsController;
  late final TextEditingController _noteController;
  late final TextEditingController _contractValueController;
  late final TextEditingController _vnptValueController;
  late final TextEditingController _itPercentController;
  late final TextEditingController _durationController;

  // ─── Hydration guard ────────────────────────────────────────────
  bool _controllersHydrated = false;

  @override
  void initState() {
    super.initState();
    _contractNameController = TextEditingController();
    _contractNoController = TextEditingController();
    _managerController = TextEditingController();
    _kmsController = TextEditingController();
    _bindingTermsController = TextEditingController();
    _noteController = TextEditingController();
    _contractValueController = TextEditingController();
    _vnptValueController = TextEditingController();
    _itPercentController = TextEditingController();
    _durationController = TextEditingController();
  }

  @override
  void dispose() {
    _contractNameController.dispose();
    _contractNoController.dispose();
    _managerController.dispose();
    _kmsController.dispose();
    _bindingTermsController.dispose();
    _noteController.dispose();
    _contractValueController.dispose();
    _vnptValueController.dispose();
    _itPercentController.dispose();
    _durationController.dispose();
    super.dispose();
  }

  void _hydrateTextControllersIfReady(EditContractProvider p) {
    if (_controllersHydrated) return;
    if (p.depts.isEmpty) return;
    _contractNameController.text = p.contractName;
    _contractNoController.text = p.contractNo;
    _managerController.text = p.managerName;
    _kmsController.text = p.kmsLink;
    _bindingTermsController.text = p.bindingTerms;
    _noteController.text = p.note;
    _contractValueController.text =
        p.contractValue == null ? '' : p.contractValue!.toStringAsFixed(0);
    _vnptValueController.text =
        p.vnptValue == null ? '' : p.vnptValue!.toStringAsFixed(0);
    _itPercentController.text =
        p.itPercent == null ? '' : p.itPercent!.toStringAsFixed(2);
    _durationController.text =
        p.durationMonths == null ? '' : p.durationMonths!.toString();
    _controllersHydrated = true;
  }

  @override
  Widget build(BuildContext context) {
    return Selector<EditContractProvider, bool>(
      selector: (_, p) => p.depts.isNotEmpty,
      builder: (context, ready, _) {
        final p = context.watch<EditContractProvider>();
        if (ready) _hydrateTextControllersIfReady(p);
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
              AppStrings.suaHopDong,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: Color(0xFF191C1E)),
            ),
          ),
          body:  SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildSection(
                  icon: Icons.link,
                  title: AppStrings.lienKetVaPhanLoai.toUpperCase(),
                  expanded: _expandedLink,
                  onToggle: () =>
                      setState(() => _expandedLink = !_expandedLink),
                  child: _buildLinkSection(p),
                ),
                const SizedBox(height: 12),
                _buildSection(
                  icon: Icons.description,
                  title: AppStrings.thongTinHopDong.toUpperCase(),
                  expanded: _expandedInfo,
                  onToggle: () =>
                      setState(() => _expandedInfo = !_expandedInfo),
                  child: _buildInfoSection(p),
                ),
                const SizedBox(height: 12),
                _buildSection(
                  icon: Icons.calendar_month,
                  title: AppStrings.mocThoiGian.toUpperCase(),
                  expanded: _expandedTimeline,
                  onToggle: () => setState(
                          () => _expandedTimeline = !_expandedTimeline),
                  child: _buildTimelineSection(p),
                ),
                const SizedBox(height: 12),
                _buildSection(
                  icon: Icons.payments,
                  title: 'GIÁ TRỊ (ĐỒNG)',
                  expanded: _expandedValue,
                  onToggle: () =>
                      setState(() => _expandedValue = !_expandedValue),
                  child: _buildValueSection(p),
                ),
                const SizedBox(height: 12),
                _buildSection(
                  icon: Icons.sticky_note_2,
                  title: AppStrings.dieuKhoanVaGhiChu.toUpperCase(),
                  expanded: _expandedTerms,
                  onToggle: () =>
                      setState(() => _expandedTerms = !_expandedTerms),
                  child: _buildTermsSection(p),
                ),
              ],
            ),
          ),
          bottomNavigationBar:_buildBottomActionBar(p),
        );
      },
    );
  }
  // ─── Section wrapper ────────────────────────────────────────────
  Widget _buildSection({
    required IconData icon,
    required String title,
    required bool expanded,
    required VoidCallback onToggle,
    required Widget child,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: ColorApp.colorC0C7D3),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
            onTap: onToggle,
            borderRadius: BorderRadius.circular(8),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: ColorApp.colorE2F0FB,
                borderRadius:
                    BorderRadius.vertical(top: Radius.circular(8)),
              ),
              child: Row(
                children: [
                  Icon(icon, color: ColorApp.color005F9E, size: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.5,
                        color: ColorApp.color191C1E,
                      ),
                    ),
                  ),
                  AnimatedRotation(
                    duration: const Duration(milliseconds: 300),
                    turns: expanded ? 0.5 : 0,
                    child: const Icon(
                      Icons.expand_more,
                      color: ColorApp.color707882,
                      size: 22,
                    ),
                  ),
                ],
              ),
            ),
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 300),
            child: expanded
                ? Padding(
                    padding: const EdgeInsets.all(12),
                    child: child,
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomActionBar(EditContractProvider p) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Color(0x0D000000),
              blurRadius: 12,
              offset: Offset(0, -4)),
        ],
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          width: double.infinity,
          height: 48,
          child: ElevatedButton(
            onPressed: () async {
              final provider = context.read<EditContractProvider>();
              final ok = await provider.submit();
              if (!mounted) return;
              if (ok) {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  RouteGenerator.contractDetail,
                  (route) => false,
                  arguments: {'id': widget.contractId},
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorApp.color005F9E,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
            child: Text(
              AppStrings.capNhatHopDong,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ─── Section 1: Liên kết & Phân loại ────────────────────────────
  Widget _buildLinkSection(EditContractProvider p) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _label(AppStrings.donViChuTri, required: true),
        _buildDropdown<int?>(
          value: p.selectedOwningUnitId,
          hint: AppStrings.chonDonVi,
          errorText: p.owningUnitError,
          items: <DropdownMenuItem<int?>>[
            DropdownMenuItem<int?>(
              value: null,
              child: Text(AppStrings.chonDonVi),
            ),
            ...p.depts.map((d) => DropdownMenuItem<int?>(
                  value: d.id,
                  child: Text(d.name ?? ''),
                )),
          ],
          onChanged: (v) => p.setOwningUnitId(v),
        ),
        const SizedBox(height: 12),
/*        _label(AppStrings.ganCoHoiChkd),
        _buildDropdown<int?>(
          value: p.selectedOpportunityId,
          hint: AppStrings.khong,
          items: <DropdownMenuItem<int?>>[
            DropdownMenuItem<int?>(
              value: null,
              child: Text(AppStrings.khong),
            ),
            ...p.opportunities.map((o) => DropdownMenuItem<int?>(
                  value: o.id,
                  child: Text(o.name ?? o.code ?? ''),
                )),
          ],
          onChanged: (v) => p.onOpportunitySelected(v),
        ),*/
        const SizedBox(height: 12),
        _label(AppStrings.ganDuAn),
        _buildDropdown<int?>(
          value: p.selectedProjectId,
          hint: AppStrings.khong,
          items: <DropdownMenuItem<int?>>[
            DropdownMenuItem<int?>(
              value: null,
              child: Text(AppStrings.khong),
            ),
            ...p.projects.map((pr) => DropdownMenuItem<int?>(
                  value: pr.id,
                  child: Text(pr.name ?? ''),
                )),
          ],
          onChanged: (v) => p.setProjectId(v),
        ),
        const SizedBox(height: 12),
        _label(AppStrings.khachHang),
        _buildDropdown<int?>(
          value: p.selectedCustomerId,
          hint: AppStrings.chonDonVi,
          items: <DropdownMenuItem<int?>>[
            DropdownMenuItem<int?>(
              value: null,
              child: Text(AppStrings.khong),
            ),
            ...p.customers.map(
              (c) => DropdownMenuItem<int?>(
                value: c.id,
                child: RichText(
                  text: TextSpan(
                    children: [
                      WidgetSpan(
                        alignment: PlaceholderAlignment.middle,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFFEFF2FF),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            c.code ?? '',
                            style: const TextStyle(
                              color: Color(0xFF4F5DFF),
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      const TextSpan(text: ' '),
                      TextSpan(
                        text: c.name ?? '',
                        style: const TextStyle(
                          color: Color(0xFF2F3542),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
          onChanged: p.setCustomerId,
        ),
        const SizedBox(height: 12),
        _label(AppStrings.spDvCungCap),
        _buildDropdown<int?>(
          value: p.selectedProductServiceId,
          hint: AppStrings.chonSpDv,
          items: <DropdownMenuItem<int?>>[
            DropdownMenuItem<int?>(
              value: null,
              child: Text(AppStrings.chonSpDv),
            ),
            ...p.filteredProductServices.map((ps) => DropdownMenuItem<int?>(
                  value: ps.id,
                  child: Text(ps.name ?? ps.code ?? ''),
                )),
          ],
          onChanged: p.setProductServiceId,
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _label(AppStrings.diaBan),
                  _buildDropdown<String>(
                    value: p.selectedRegionCode,
                    hint: AppStrings.dashDash,
                    items: AddContractConfig.regions
                        .map((r) => DropdownMenuItem<String>(
                              value: r.code,
                              child: Text(r.label),
                            ))
                        .toList(),
                    onChanged: p.setRegionCode,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _label(AppStrings.linhVuc),
                  _buildDropdown<String>(
                    value: p.selectedBusinessField,
                    hint: AppStrings.dashDash,
                    items: AddContractConfig.projectFields
                        .map((f) => DropdownMenuItem<String>(
                              value: f.code,
                              child: Text(f.label),
                            ))
                        .toList(),
                    onChanged: p.setBusinessField,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ─── Section 2: Thông tin hợp đồng ──────────────────────────────
  Widget _buildInfoSection(EditContractProvider p) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _label(AppStrings.tenHopDongHoacTenDuAn, required: true),
        TextField(
          controller: _contractNameController,
          onChanged: p.setContractName,
          style: const TextStyle(fontSize: 14, color: ColorApp.color191C1E),
          decoration: _inputDecoration(
              hint: AppStrings.deTrongSeLayTheoCoHoi,
              errorText: p.contractNameError),
        ),
        const SizedBox(height: 12),
        _label(AppStrings.soHopDong),
        TextField(
          controller: _contractNoController,
          onChanged: p.setContractNo,
          style: const TextStyle(fontSize: 14, color: ColorApp.color191C1E),
          decoration: _inputDecoration(),
        ),
        const SizedBox(height: 12),
        _label(AppStrings.loaiHopDong),
        _buildDropdown<String>(
          value: p.selectedTypeCode,
          hint: AppStrings.chonLoai,
          items: AddContractConfig.contractTypes
              .map((t) => DropdownMenuItem<String>(
                    value: t.code,
                    child: Text(t.label),
                  ))
              .toList(),
          onChanged: p.setTypeCode,
        ),
        const SizedBox(height: 12),
        _label(AppStrings.trangThaiHopDong),
        _buildDropdown<String>(
          value: p.selectedStatusCode,
          hint: AppStrings.chonTrangThai,
          items: AddContractConfig.contractStatuses
              .map((s) => DropdownMenuItem<String>(
                    value: s.code,
                    child: Text(s.label),
                  ))
              .toList(),
          onChanged: p.setStatusCode,
        ),
        const SizedBox(height: 12),
        _label(AppStrings.nhanSuChuyenQuan),
        TextField(
          controller: _managerController,
          onChanged: p.setManagerName,
          style: const TextStyle(fontSize: 14, color: ColorApp.color191C1E),
          decoration: _inputDecoration(),
        ),
        const SizedBox(height: 12),
        _label(AppStrings.linkKmsFileHopDong),
        TextField(
          controller: _kmsController,
          keyboardType: TextInputType.url,
          onChanged: p.setKmsLink,
          style: const TextStyle(fontSize: 14, color: ColorApp.color191C1E),
          decoration: _inputDecoration(hint: 'https://kms...'),
        ),
      ],
    );
  }

  // ─── Section 3: Mốc thời gian ───────────────────────────────────
  Widget _buildTimelineSection(EditContractProvider p) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _label(AppStrings.ngayKyHd),
        _buildDateField(p.signedDate, p.setSignedDate),
        const SizedBox(height: 12),
        _label(AppStrings.ngayNghiemThuVaoSd),
        _buildDateField(p.acceptanceDate, p.setAcceptanceDate),
        const SizedBox(height: 12),
        _label(AppStrings.hetHanHdBhbt),
        _buildDateField(p.expiryDate, p.setExpiryDate,
            errorText: p.expiryDateError),
        const SizedBox(height: 12),
        _label(AppStrings.thoiGianThueBhThang),
        TextField(
          controller: _durationController,
          keyboardType: TextInputType.number,
          onChanged: (v) => p.setDurationMonths(int.tryParse(v)),
          style: const TextStyle(fontSize: 14, color: ColorApp.color191C1E),
          decoration: _inputDecoration(),
        ),
      ],
    );
  }

  // ─── Section 4: Giá trị (đồng) ─────────────────────────────────
  Widget _buildValueSection(EditContractProvider p) {
    return Selector<EditContractProvider, double>(
      selector: (_, pr) => pr.computedVnptItValue,
      builder: (_, vnptIt, __) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _label(AppStrings.giaTriHd),
            TextField(
              controller: _contractValueController,
              keyboardType: TextInputType.number,
              onChanged: (v) => p.setContractValue(double.tryParse(v)),
              style: const TextStyle(fontSize: 14, color: ColorApp.color191C1E),
              decoration: _inputDecoration(),
            ),
            const SizedBox(height: 12),
            _label(AppStrings.giaTriVeVnpt),
            TextField(
              controller: _vnptValueController,
              keyboardType: TextInputType.number,
              onChanged: (v) => p.setVnptValue(double.tryParse(v)),
              style: const TextStyle(fontSize: 14, color: ColorApp.color191C1E),
              decoration: _inputDecoration(),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _label(AppStrings.tiLeVeIt),
                      TextField(
                        controller: _itPercentController,
                        keyboardType: TextInputType.number,
                        onChanged: (v) => p.setItPercent(double.tryParse(v)),
                        style: const TextStyle(
                            fontSize: 14, color: ColorApp.color191C1E),
                        decoration: _inputDecoration(),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _label(AppStrings.giaTriVeVnptIt),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: ColorApp.colorF7F9FB,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: ColorApp.colorC0C7D3),
                        ),
                        child: Text(
                          _formatCurrency(vnptIt),
                          style: const TextStyle(
                            fontSize: 14,
                            color: ColorApp.color707882,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              AppStrings.deTrongBangVnptNhanPhanTramIt,
              style: const TextStyle(
                fontSize: 12,
                fontStyle: FontStyle.italic,
                color: ColorApp.color707882,
              ),
            ),
          ],
        );
      },
    );
  }

  // ─── Section 5: Điều khoản & Ghi chú ───────────────────────────
  Widget _buildTermsSection(EditContractProvider p) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _label(AppStrings.dieuKhoanRangBuoc),
        TextField(
          controller: _bindingTermsController,
          maxLines: 4,
          onChanged: p.setBindingTerms,
          style: const TextStyle(fontSize: 14, color: ColorApp.color191C1E),
          decoration: _inputDecoration(),
        ),
        const SizedBox(height: 12),
        _label(AppStrings.ghiChu),
        TextField(
          controller: _noteController,
          maxLines: 3,
          onChanged: p.setNote,
          style: const TextStyle(fontSize: 14, color: ColorApp.color191C1E),
          decoration: _inputDecoration(),
        ),
      ],
    );
  }

  // ─── Helpers ───────────────────────────────────────────────────
  Widget _label(String text, {bool required = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Text(
            text,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: ColorApp.color191C1E,
            ),
          ),
          if (required)
            const Text(
              ' *',
              style: TextStyle(color: ColorApp.colorBA1A1A, fontSize: 14),
            ),
        ],
      ),
    );
  }

  InputDecoration _inputDecoration({String? hint, String? errorText}) {
    return InputDecoration(
      isDense: true,
      hintText: hint,
      errorText: errorText,
      hintStyle: const TextStyle(fontSize: 14, color: ColorApp.colorC0C7D3),
      filled: true,
      fillColor: Colors.white,
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: ColorApp.colorC0C7D3),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: ColorApp.colorC0C7D3),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: ColorApp.color005F9E, width: 1),
      ),
    );
  }

  Widget _buildDropdown<T>({
    required T? value,
    required String hint,
    required List<DropdownMenuItem<T>> items,
    required ValueChanged<T?> onChanged,
    String? errorText,
  }) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<T>(
        isDense: true,
        value: value,
        padding: EdgeInsets.zero,
        hint: Text(
          hint,
          style: const TextStyle(
            fontFamily: 'Inter',
            fontSize: 14,
            color: ColorApp.colorC0C7D3,
          ),
        ),
        isExpanded: true,
        icon: const Icon(Icons.expand_more, color: ColorApp.color707882),
        style: const TextStyle(
          fontFamily: 'Inter',
          fontSize: 14,
          color: ColorApp.color191C1E,
        ),
        borderRadius: BorderRadius.circular(8),
        items: items,
        onChanged: onChanged,
      ),
    ).intoInputDecoration(errorText: errorText, verticalPadding: 7);
  }

  Widget _buildDateField(
    DateTime? value,
    void Function(DateTime?) onChanged, {
    String? errorText,
  }) {
    return TextField(
      controller: TextEditingController(
        text: value == null ? '' : _formatDate(value),
      ),
      readOnly: true,
      onTap: () async {
        final picked = await showDatePicker(
          context: context,
          initialDate: value ?? DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );
        if (picked != null) onChanged(picked);
      },
      style: const TextStyle(fontSize: 14, color: ColorApp.color191C1E),
      decoration: _inputDecoration(
          hint: AppStrings.chonNgay, errorText: errorText),
    );
  }

  String _formatDate(DateTime d) =>
      '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}';

  String _formatCurrency(double v) =>
      v.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]},');
}

extension _DropdownIntoInput on Widget {
  Widget intoInputDecoration({
    String? errorText,
    double verticalPadding = 0,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: errorText != null
              ? ColorApp.colorBA1A1A
              : ColorApp.colorC0C7D3,
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: verticalPadding),
      child: this,
    );
  }
}
