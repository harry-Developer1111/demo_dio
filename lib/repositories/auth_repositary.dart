import 'package:demo_dio/models/user_model.dart';
import '../core/network/api_endpoints.dart';
import '../core/network/api_service.dart';

class AuthRepositaryLogin {
  final ApiService apiService;

  AuthRepositaryLogin(this.apiService);

  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    final response = await apiService.post(
      ApiEndpoints.login,
      data: {
        'email': email,
        'password': password,
      },
    );
    return UserModel.fromJson(response.data);
  }

  Future<UserModel> signup({
    required String name,
    required String email,
    required String password,

  }) async {
    final response = await apiService.post(
      ApiEndpoints.register,
      data: {
        'name':name,
        'email': email,
        'password': password,
      },
    );
    return UserModel.fromJson(response.data);
  }

}