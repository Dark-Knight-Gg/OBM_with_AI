import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:obm_gen_with_ai/core/base/selector_base.dart';
import 'package:obm_gen_with_ai/core/constants/app_strings.dart';
import 'package:obm_gen_with_ai/core/constants/color_app.dart';
import 'package:obm_gen_with_ai/core/constants/route_generator.dart';
import 'package:obm_gen_with_ai/features/add_contract/component/add_contract_provider.dart';
import 'package:obm_gen_with_ai/features/add_contract/component/add_contract_service.dart';
import 'package:obm_gen_with_ai/features/add_contract/model/add_contract_model.dart';

class BodyAddContractWidget extends StatefulWidget {
  const BodyAddContractWidget({super.key});

  @override
  State<BodyAddContractWidget> createState() => _BodyAddContractWidgetState();
}

class _BodyAddContractWidgetState extends State<BodyAddContractWidget> {
  // ─── Section expanded/collapsed ─────────────────────────────────
  bool _expandedLink = true;
  bool _expandedInfo = true;
  bool _expandedTimeline = true;
  bool _expandedValue = true;
  bool _expandedTerms = true;

  // ─── Controllers ────────────────────────────────────────────────
  late final TextEditingController _customerController;
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

  @override
  void initState() {
    super.initState();
    _customerController = TextEditingController();
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
    _customerController.dispose();
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

  @override
  Widget build(BuildContext context) {
    return ConsumerBase<AddContractService, AddContractProvider>(
      contextParent: context,
      onRepositoryLoading: (_) => const Center(child: CircularProgressIndicator()),
      onRepositorySuccess: (repo) => _buildContent(repo as AddContractProvider),
      onRepositoryError: (repo) => _buildError(repo as AddContractProvider),
    );
  }

  Widget _buildContent(AddContractProvider provider) {
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
          AppStrings.themMoiHopDong,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: Color(0xFF191C1E)),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
        child: Column(
          children: [
            _buildSection(
              icon: Icons.link,
              title: AppStrings.lienKetVaPhanLoai,
              expanded: _expandedLink,
              onToggle: () => setState(() => _expandedLink = !_expandedLink),
              child: _buildLinkSection(provider),
            ),
            const SizedBox(height: 12),
            _buildSection(
              icon: Icons.description_outlined,
              title: AppStrings.thongTinHopDong,
              expanded: _expandedInfo,
              onToggle: () => setState(() => _expandedInfo = !_expandedInfo),
              child: _buildInfoSection(provider),
            ),
            const SizedBox(height: 12),
            _buildSection(
              icon: Icons.calendar_month_outlined,
              title: AppStrings.mocThoiGian,
              expanded: _expandedTimeline,
              onToggle: () => setState(() => _expandedTimeline = !_expandedTimeline),
              child: _buildTimelineSection(provider),
            ),
            const SizedBox(height: 12),
            _buildSection(
              icon: Icons.payments_outlined,
              title: AppStrings.giaTriDong,
              expanded: _expandedValue,
              onToggle: () => setState(() => _expandedValue = !_expandedValue),
              child: _buildValueSection(provider),
            ),
            const SizedBox(height: 12),
            _buildSection(
              icon: Icons.sticky_note_2_outlined,
              title: AppStrings.dieuKhoanVaGhiChu,
              expanded: _expandedTerms,
              onToggle: () => setState(() => _expandedTerms = !_expandedTerms),
              child: _buildTermsSection(provider),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomBar(),
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
                borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
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
                    turns: expanded ? 0.5 : 0,
                    duration: const Duration(milliseconds: 300),
                    child: const Icon(Icons.expand_more, color: ColorApp.color191C1E),
                  ),
                ],
              ),
            ),
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 300),
            child: expanded ? Padding(padding: const EdgeInsets.all(12), child: child) : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  // ─── Section 1: Liên kết & Phân loại ────────────────────────────
  Widget _buildLinkSection(AddContractProvider p) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _label(AppStrings.donViChuTri, required: true),
        _buildDropdown<int>(
          value: p.selectedOwningUnitId,
          hint: AppStrings.chonDonVi,
          items: p.depts.map((d) => DropdownMenuItem<int>(value: d.id, child: Text(d.name ?? ''))).toList(),
          onChanged: (v) {
            p.setOwningUnitId(v);
          },
          errorText: p.owningUnitError,
        ),
        const SizedBox(height: 12),
        _label(AppStrings.ganCoHoiChkd),
        _buildDropdown<int>(
          value: p.selectedOpportunityId,
          hint: AppStrings.khong,
          items:
              p.opportunities
                  .map((o) => DropdownMenuItem<int>(value: o.id, child: Text(o.name ?? o.code ?? '')))
                  .toList(),
          onChanged: p.onOpportunitySelected,
        ),
        const SizedBox(height: 12),
        _label(AppStrings.ganDuAn),
        _buildDropdown<int>(
          value: p.selectedProjectId,
          hint: AppStrings.khong,
          items:
              p.projects
                  .map((pr) => DropdownMenuItem<int>(value: pr.id, child: Text(pr.name ?? pr.code ?? '')))
                  .toList(),
          onChanged: p.setProjectId,
        ),
        const SizedBox(height: 12),
        _label(AppStrings.khachHang),
        _buildDropdown<int>(
          value: p.selectedCustomerId,
          hint: AppStrings.chonSpDv,
          items:
              p.customers
                  .map(
                    (ps) => DropdownMenuItem<int>(
                      value: ps.id,
                      child: RichText(
                        text: TextSpan(
                          children: [
                            WidgetSpan(
                              alignment: PlaceholderAlignment.middle,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFEFF2FF),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  ps.code ?? '',
                                  style: TextStyle(color: Color(0xFF4F5DFF), fontSize: 14, fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                            const TextSpan(text: ' '),
                            TextSpan(
                              text: ps.name ?? '',
                              style: TextStyle(color: Color(0xFF2F3542), fontSize: 14, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                  .toList(),
          onChanged: p.setCustomerId,
        ),
        const SizedBox(height: 12),
        _label(AppStrings.spDvCungCap),
        _buildDropdown<int>(
          value: p.selectedProductServiceId,
          hint: AppStrings.chonSpDv,
          items:
              p.filteredProductServices
                  .map((ps) => DropdownMenuItem<int>(value: ps.id, child: Text(ps.name ?? ps.code ?? '')))
                  .toList(),
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
                    items:
                        AddContractConfig.regions
                            .map((r) => DropdownMenuItem<String>(value: r.code, child: Text(r.label)))
                            .toList(),
                    onChanged: p.setRegionCode,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _label(AppStrings.linhVuc),
                  _buildDropdown<String>(
                    value: p.selectedBusinessField,
                    hint: AppStrings.dashDash,
                    items:
                        AddContractConfig.projectFields
                            .map((f) => DropdownMenuItem<String>(value: f.code, child: Text(f.label)))
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
  Widget _buildInfoSection(AddContractProvider p) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _label(AppStrings.tenHopDongHoacTenDuAn, required: true),
        TextField(
          controller: _contractNameController,
          onChanged: p.setContractName,
          style: const TextStyle(fontSize: 14, color: ColorApp.color191C1E),
          decoration: _inputDecoration(hint: AppStrings.deTrongSeLayTheoCoHoi, errorText: p.contractNameError),
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
          items:
              AddContractConfig.contractTypes
                  .map((t) => DropdownMenuItem<String>(value: t.code, child: Text(t.label)))
                  .toList(),
          onChanged: p.setTypeCode,
        ),
        const SizedBox(height: 12),
        _label(AppStrings.trangThaiHopDong),
        _buildDropdown<String>(
          value: p.selectedStatusCode,
          hint: AppStrings.chonTrangThai,
          items:
              AddContractConfig.contractStatuses
                  .map((s) => DropdownMenuItem<String>(value: s.code, child: Text(s.label)))
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
          onChanged: p.setKmsLink,
          keyboardType: TextInputType.url,
          style: const TextStyle(fontSize: 14, color: ColorApp.color191C1E),
          decoration: _inputDecoration(hint: 'https://kms...'),
        ),
      ],
    );
  }

  // ─── Section 3: Mốc thời gian ──────────────────────────────────
  Widget _buildTimelineSection(AddContractProvider p) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _label(AppStrings.ngayKyHd),
        _buildDateField(p.signedDate, (d) => p.setSignedDate(d)),
        const SizedBox(height: 12),
        _label(AppStrings.ngayNghiemThuVaoSd),
        _buildDateField(p.acceptanceDate, p.setAcceptanceDate),
        const SizedBox(height: 12),
        _label(AppStrings.hetHanHdBhbt),
        _buildDateField(p.expiryDate, (d) => p.setExpiryDate(d), errorText: p.expiryDateError),
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
  Widget _buildValueSection(AddContractProvider p) {
    return Selector<AddContractProvider, double>(
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
                        style: const TextStyle(fontSize: 14, color: ColorApp.color191C1E),
                        decoration: _inputDecoration(),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _label(AppStrings.giaTriVeVnptIt),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                        decoration: BoxDecoration(
                          color: ColorApp.colorF7F9FB,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: ColorApp.colorC0C7D3),
                        ),
                        child: Text(
                          _formatCurrency(vnptIt),
                          style: const TextStyle(fontSize: 14, color: ColorApp.color707882),
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
              style: const TextStyle(fontSize: 12, fontStyle: FontStyle.italic, color: ColorApp.color707882),
            ),
          ],
        );
      },
    );
  }

  // ─── Section 5: Điều khoản & Ghi chú ───────────────────────────
  Widget _buildTermsSection(AddContractProvider p) {
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

  // ─── Bottom Save Bar ────────────────────────────────────────────
  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Color(0x0D000000), blurRadius: 12, offset: Offset(0, -4))],
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          width: double.infinity,
          height: 48,
          child: ElevatedButton(
            onPressed: () async {
              final provider = context.read<AddContractProvider>();
              final ok = await provider.submit();
              if (!mounted) return;
              if (ok) {
                Navigator.pushNamedAndRemoveUntil(context, RouteGenerator.listContractReal, (route) => false);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorApp.color005F9E,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: Text(AppStrings.luuHopDong, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400)),
          ),
        ),
      ),
    );
  }

  Widget _buildError(AddContractProvider p) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              p.errorMessage ?? AppStrings.khongTheKetNoiMauChu,
              style: const TextStyle(fontSize: 14, color: ColorApp.color7D8798),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            OutlinedButton(
              onPressed: () => p.loadFilterData(),
              style: OutlinedButton.styleFrom(
                foregroundColor: ColorApp.color005F9E,
                side: const BorderSide(color: ColorApp.color005F9E),
              ),
              child: Text(AppStrings.reloadStr),
            ),
          ],
        ),
      ),
    );
  }

  // ─── Helpers ────────────────────────────────────────────────────
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
          if (required) const Text(' *', style: TextStyle(color: ColorApp.colorBA1A1A, fontSize: 14)),
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
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
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
        hint: Text(hint, style: const TextStyle(fontFamily: 'Inter', fontSize: 14, color: ColorApp.colorC0C7D3)),
        isExpanded: true,
        icon: const Icon(Icons.expand_more, color: ColorApp.color707882),
        style: const TextStyle(fontFamily: 'Inter', fontSize: 14, color: ColorApp.color191C1E),
        borderRadius: BorderRadius.circular(8),
        items: items,
        onChanged: onChanged,
      ),
    ).intoInputDecoration(errorText: errorText, verticalPadding: 7);
  }

  Widget _buildDateField(DateTime? value, void Function(DateTime?) onChanged, {String? errorText}) {
    return TextField(
      controller: TextEditingController(text: value == null ? '' : _formatDate(value)),
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
      decoration: _inputDecoration(hint: AppStrings.chonNgay, errorText: errorText),
    );
  }

  String _formatDate(DateTime d) =>
      '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}';

  String _formatCurrency(double v) =>
      v.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]},');
}

extension _DropdownIntoInput on Widget {
  Widget intoInputDecoration({String? errorText, double verticalPadding = 0}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: errorText != null ? ColorApp.colorBA1A1A : ColorApp.colorC0C7D3),
      ),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: verticalPadding),
      child: this,
    );
  }
}
