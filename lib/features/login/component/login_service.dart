import 'package:obm_gen_with_ai/core/base/services/base_service.dart';
import 'package:obm_gen_with_ai/features/login/model/login_model.dart';

class LoginService extends BaseService {
  LoginService(super.client);
  Future<LoginResponse> login(LoginRequest request) async {
    final response = await client.post(
      'http://10.168.6.37:9080/api/v1/auth/login',
      data: request.toJson(),
    );
    return LoginResponse.fromJson(response.data as Map<String, dynamic>);
  }
}
