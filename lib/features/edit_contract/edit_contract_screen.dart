import 'package:flutter/material.dart';
import 'package:obm_gen_with_ai/core/base/base_page.dart';
import 'package:obm_gen_with_ai/features/edit_contract/component/edit_contract_provider.dart';
import 'package:obm_gen_with_ai/features/edit_contract/component/edit_contract_service.dart';
import 'package:obm_gen_with_ai/features/edit_contract/widget/body_edit_contract_widget.dart';

class EditContractScreen extends BasePageStatefulWidget {
  final int contractId;

  const EditContractScreen({super.key, required this.contractId});

  @override
  State<EditContractScreen> createState() => _EditContractScreenState();
}

class _EditContractScreenState extends BaseStatefulWidgetState<
    EditContractScreen, EditContractService, EditContractProvider> {

  @override
  Widget buildBody(BuildContext context) {
    return BodyEditContractWidget(contractId: widget.contractId);
  }
}
