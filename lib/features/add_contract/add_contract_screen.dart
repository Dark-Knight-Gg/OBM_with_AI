import 'package:flutter/material.dart';
import 'package:obm_gen_with_ai/core/base/base_page.dart';
import 'package:obm_gen_with_ai/features/add_contract/component/add_contract_provider.dart';
import 'package:obm_gen_with_ai/features/add_contract/component/add_contract_service.dart';
import 'package:obm_gen_with_ai/features/add_contract/widget/body_add_contract_widget.dart';

class AddContractScreen extends BasePageStatefulWidget {
  const AddContractScreen({super.key});

  @override
  State<AddContractScreen> createState() => _AddContractScreenState();
}

class _AddContractScreenState
    extends BaseStatefulWidgetState<AddContractScreen, AddContractService, AddContractProvider> {

  @override
  Widget buildBody(BuildContext context) {
    return const BodyAddContractWidget();
  }
}