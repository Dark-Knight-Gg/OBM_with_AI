import 'package:flutter/material.dart';
import 'package:obm_gen_with_ai/core/base/base_page.dart';
import 'package:obm_gen_with_ai/features/project_detail/component/project_detail_provider.dart';
import 'package:obm_gen_with_ai/features/project_detail/component/project_detail_service.dart';
import 'package:obm_gen_with_ai/features/project_detail/widget/body_project_detail_widget.dart';

class ProjectDetailScreen extends BasePageStatefulWidget {
  const ProjectDetailScreen({super.key});

  @override
  State<ProjectDetailScreen> createState() => _ProjectDetailScreenState();
}

class _ProjectDetailScreenState
    extends BaseStatefulWidgetState<ProjectDetailScreen, ProjectDetailService, ProjectDetailProvider> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final projectId = ModalRoute.of(context)?.settings.arguments as int?;
      if (projectId != null) {
        pageProvider(context).fetchProjectDetail(projectId);
      }
    });
  }

  @override
  Widget buildBody(BuildContext context) {
    return const BodyProjectDetailWidget();
  }
}
