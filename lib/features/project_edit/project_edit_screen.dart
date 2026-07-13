import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:obm_gen_with_ai/core/base/base_page.dart';
import 'package:obm_gen_with_ai/features/list_contract/component/list_contract_provider.dart';
import 'package:obm_gen_with_ai/features/project_edit/component/project_edit_provider.dart';
import 'package:obm_gen_with_ai/features/project_edit/component/project_edit_service.dart';
import 'package:obm_gen_with_ai/features/project_edit/widget/body_project_edit_widget.dart';

class ProjectEditScreen extends BasePageStatefulWidget {
  const ProjectEditScreen({super.key});

  @override
  State<ProjectEditScreen> createState() => _ProjectEditScreenState();
}

class _ProjectEditScreenState
    extends BaseStatefulWidgetState<ProjectEditScreen, ProjectEditService, ProjectEditProvider> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final projectId = ModalRoute.of(context)?.settings.arguments as int?;
      if (projectId != null) {
        pageProvider(context).loadProjectDetail(projectId);
      }
    });
  }

  @override
  Widget buildBody(BuildContext context) {
    return const BodyProjectEditWidget();
  }
}
