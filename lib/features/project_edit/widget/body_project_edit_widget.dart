import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:obm_gen_with_ai/core/base/base_provider.dart';
import 'package:obm_gen_with_ai/core/constants/app_strings.dart';
import 'package:obm_gen_with_ai/features/project_edit/component/project_edit_provider.dart';
import 'package:obm_gen_with_ai/core/constants/color_app.dart';
import 'package:obm_gen_with_ai/core/constants/config_filter_app.dart';

class BodyProjectEditWidget extends StatelessWidget {
  const BodyProjectEditWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProjectEditProvider>(
      builder: (context, provider, _) {
        if (provider.detailState == StateType.loading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (provider.detailState == StateType.error) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(provider.errorMessage ?? AppStrings.warningNotConnectInternet),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {},
                  child: Text(AppStrings.reloadStr),
                ),
              ],
            ),
          );
        }

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
              AppStrings.suaDuAn,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: Color(0xFF191C1E),
              ),
            ),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _LabelWithAsterisk(text: AppStrings.tenDuAn),
                const SizedBox(height: 8),
                _NameTextField(provider: provider),
                const SizedBox(height: 24),
                _StatusDropdown(provider: provider),
                const SizedBox(height: 24),
                _PmDropdown(provider: provider),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(child: _DateField(label: AppStrings.ngayBatDau, provider: provider, isStart: true)),
                    const SizedBox(width: 16),
                    Expanded(child: _DateField(label: AppStrings.ngayKetThuc, provider: provider, isStart: false)),
                  ],
                ),
                const SizedBox(height: 24),
                _Label(text: AppStrings.ghiChu),
                const SizedBox(height: 8),
                _NoteTextField(provider: provider),
                const SizedBox(height: 100),
              ],
            ),
          ),
          bottomNavigationBar: _SaveBottomBar(provider: provider),
        );
      },
    );
  }
}

class _Label extends StatelessWidget {
  final String text;
  const _Label({required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w700,
        color: Color(0xFF191C1E),
      ),
    );
  }
}

class _LabelWithAsterisk extends StatelessWidget {
  final String text;
  const _LabelWithAsterisk({required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          text,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: Color(0xFF191C1E),
          ),
        ),
        const Text(
          ' *',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: Color(0xFFBA1A1A),
          ),
        ),
      ],
    );
  }
}

class _NameTextField extends StatefulWidget {
  final ProjectEditProvider provider;
  const _NameTextField({required this.provider});

  @override
  State<_NameTextField> createState() => _NameTextFieldState();
}

class _NameTextFieldState extends State<_NameTextField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.provider.nameValue);
  }

  @override
  void didUpdateWidget(_NameTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.provider.nameValue != _controller.text && widget.provider.detailState == StateType.loaded) {
      _controller.text = widget.provider.nameValue;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final error = widget.provider.nameError;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: error != null ? const Color(0xFFBA1A1A) : const Color(0xFFC0C7D3),
            ),
          ),
          child: TextField(
            controller: _controller,
            style: const TextStyle(fontSize: 14, color: Color(0xFF191C1E)),
            decoration: InputDecoration(
              hintText: AppStrings.nhapTenDuAn,
              hintStyle: const TextStyle(fontSize: 14, color: Color(0xFF707882)),
              prefixIcon: const Icon(Icons.assignment_outlined, color: Color(0xFF707882), size: 20),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
            onChanged: (v) => widget.provider.nameValue = v,
          ),
        ),
        if (error != null)
          Padding(
            padding: const EdgeInsets.only(top: 4, left: 4),
            child: Text(error, style: const TextStyle(fontSize: 12, color: Color(0xFFBA1A1A))),
          ),
      ],
    );
  }
}

class _StatusDropdown extends StatelessWidget {
  final ProjectEditProvider provider;
  const _StatusDropdown({required this.provider});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
            value: provider.statusValue,
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
              const DropdownMenuItem<String>(value: '', child: Text('— Chọn —')),
              ...ConfigFilterApp.projectStatuses.map(
                    (s) => DropdownMenuItem(value: s.code, child: Text(s.label)),
              ),
            ],
            onChanged: (v) {
              provider.changeStatusValue(v ?? '');
            },
          ),
        ),
      ),
    ],);
  }
}

class _PmDropdown extends StatelessWidget {
  final ProjectEditProvider provider;
  const _PmDropdown({required this.provider});

  @override
  Widget build(BuildContext context) {
    return     Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      Text(
        AppStrings.quanLyDA,
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
          child: DropdownButton<int>(
            value: provider.projectManagerValue,
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
              const DropdownMenuItem<int>(value: -1, child: Text('— Chọn —')),
              const DropdownMenuItem<int>(value: 1, child: Text('PM 1')),
              const DropdownMenuItem<int>(value: 2, child: Text('PM 2')),
              const DropdownMenuItem<int>(value: 3, child: Text('PM3')),
            ],
            onChanged: (v) {
              provider.changeProjectManagerValue(v ?? -1);
            },
          ),
        ),
      ),
    ],);
  }
}

class _Dropdown<T> extends StatelessWidget {
  final T value;
  final String hint;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?> onChanged;

  const _Dropdown({
    required this.value,
    required this.hint,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFC0C7D3)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          value: value,
          isExpanded: true,
          hint: Text(hint, style: const TextStyle(fontSize: 14, color: Color(0xFF707882))),
          items: items,
          onChanged: onChanged,
          icon: const Icon(Icons.expand_more, color: Color(0xFF707882)),
          style: const TextStyle(fontSize: 14, color: Color(0xFF191C1E)),
        ),
      ),
    );
  }
}

class _DateField extends StatelessWidget {
  final String label;
  final ProjectEditProvider provider;
  final bool isStart;

  const _DateField({
    required this.label,
    required this.provider,
    required this.isStart,
  });

  DateTime? get _dateValue => isStart ? provider.startDateValue : provider.endDateValue;

  @override
  Widget build(BuildContext context) {
    final dateStr = _dateValue != null
        ? '${_dateValue!.day.toString().padLeft(2, '0')}/${_dateValue!.month.toString().padLeft(2, '0')}/${_dateValue!.year}'
        : '';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _Label(text: label),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () async {
            final picked = await showDatePicker(
              context: context,
              initialDate: _dateValue ?? DateTime.now(),
              firstDate: DateTime(2020),
              lastDate: DateTime(2100),
            );
            if (picked != null) {
              if (isStart) {
                provider.changeStartDateValue(picked);
              } else {
                provider.changeEndDateValue(picked);
              }
            }
          },
          child: Container(
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFFC0C7D3)),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                const Icon(Icons.calendar_today_outlined, color: Color(0xFF707882), size: 20),
                const SizedBox(width: 12),
                Text(
                  dateStr.isEmpty ? 'dd/MM/yyyy' : dateStr,
                  style: TextStyle(
                    fontSize: 14,
                    color: dateStr.isEmpty ? const Color(0xFF707882) : const Color(0xFF191C1E),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _NoteTextField extends StatefulWidget {
  final ProjectEditProvider provider;
  const _NoteTextField({required this.provider});

  @override
  State<_NoteTextField> createState() => _NoteTextFieldState();
}

class _NoteTextFieldState extends State<_NoteTextField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.provider.noteValue);
  }

  @override
  void didUpdateWidget(_NoteTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.provider.noteValue != _controller.text && widget.provider.detailState == StateType.loaded) {
      _controller.text = widget.provider.noteValue;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFC0C7D3)),
      ),
      child: TextField(
        controller: _controller,
        style: const TextStyle(fontSize: 14, color: Color(0xFF191C1E)),
        maxLines: 5,
        minLines: 3,
        decoration: InputDecoration(
          hintText: AppStrings.nhapGhiChuDuAn,
          hintStyle: const TextStyle(fontSize: 14, color: Color(0xFF707882)),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(16),
        ),
        onChanged: (v) => widget.provider.noteValue = v,
      ),
    );
  }
}

class _SaveBottomBar extends StatelessWidget {
  final ProjectEditProvider provider;
  const _SaveBottomBar({required this.provider});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFC0C7D3))),
      ),
      child: SafeArea(
        child: GestureDetector(
          onTap: () => provider.updateProject(),
          child: Container(
            height: 48,
            decoration: BoxDecoration(
              color: const Color(0xFF005F9E),
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF005F9E).withAlpha(77),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            alignment: Alignment.center,
            child: Text(
              AppStrings.luu,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
