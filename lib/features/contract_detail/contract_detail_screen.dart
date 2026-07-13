import 'package:flutter/material.dart';
import 'package:obm_gen_with_ai/core/base/base_page.dart';
import 'package:obm_gen_with_ai/core/constants/app_strings.dart';
import 'package:obm_gen_with_ai/features/contract_detail/component/contract_detail_provider.dart';
import 'package:obm_gen_with_ai/features/contract_detail/component/contract_detail_service.dart';
import 'package:obm_gen_with_ai/features/contract_detail/widget/body_contract_detail_widget.dart';

class ContractDetailScreen extends BasePageStatefulWidget {
  const ContractDetailScreen({super.key});

  @override
  State<ContractDetailScreen> createState() => _ContractDetailScreenState();
}

class _ContractDetailScreenState
    extends BaseStatefulWidgetState<ContractDetailScreen, ContractDetailService,
        ContractDetailProvider> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args = ModalRoute.of(context)?.settings.arguments;
      int? id;
      if (args is int) {
        id = args;
      } else if (args is Map<String, dynamic> && args.containsKey('id')) {
        id = args['id'] as int?;
      }
      if (id != null) {
        pageProvider(context).loadContractDetail(id);
      }
    });
  }

  @override
  Widget buildBody(BuildContext context) {
    return const BodyContractDetailWidget();
  }
}
