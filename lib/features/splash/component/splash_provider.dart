import 'package:obm_gen_with_ai/core/base/base_provider.dart';
import 'package:obm_gen_with_ai/core/base/navigation/navigate_event.dart';
import 'package:obm_gen_with_ai/core/constants/route_generator.dart';
import 'package:obm_gen_with_ai/features/splash/component/splash_service.dart';
import 'package:obm_gen_with_ai/core/utils/app_storage.dart';

class SplashProvider extends BaseProvider<SplashService> {
  final SplashService _service;

  SplashProvider(this._service) : super();

  SplashService get service => _service;

  bool _isInitialized = false;
  bool get isInitialized => _isInitialized;

  Future<void> initialize() async {
    try {
      await Future.delayed(const Duration(milliseconds: 2500));
      final hasToken = await AppStorage().hasToken();
      _isInitialized = true;
      if (hasToken) {
        navigate(NavigateEvent.pushReplacementNamed(RouteGenerator.dashboard));
      } else {
        navigate(NavigateEvent.pushReplacementNamed(RouteGenerator.login));
      }
    } catch (e) {
      errorMessage = e.toString();
    }
  }

  @override
  void onStart() {
    super.onStart();
    initialize();
  }
}
