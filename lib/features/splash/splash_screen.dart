import 'package:flutter/material.dart';
import 'package:obm_gen_with_ai/core/base/base_page.dart';
import 'package:obm_gen_with_ai/features/splash/component/splash_provider.dart';
import 'package:obm_gen_with_ai/features/splash/component/splash_service.dart';
import 'package:obm_gen_with_ai/features/splash/widget/body_splash_widget.dart';

class SplashScreen extends BasePageStatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState
    extends BaseStatefulWidgetState<SplashScreen, SplashService, SplashProvider> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget buildBody(BuildContext context) {
    return const BodySplashWidget();
  }
}
