import 'package:flutter/material.dart';
import 'package:obm_gen_with_ai/core/base/base_page.dart';
import 'package:obm_gen_with_ai/features/login/component/login_provider.dart';
import 'package:obm_gen_with_ai/features/login/component/login_service.dart';
import 'package:obm_gen_with_ai/features/login/widget/body_login_widget.dart';

class LoginScreen extends BasePageStatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState
    extends BaseStatefulWidgetState<LoginScreen, LoginService, LoginProvider> {
  @override
  Widget buildBody(BuildContext context) {
    return const BodyLoginWidget();
  }
}
