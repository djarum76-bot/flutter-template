import 'package:my_template/shared/services/network/api_response.dart';

abstract class AuthenticationRepository{
  Future<ApiResponse> register({required String email, required String password});
  Future<ApiResponse> login({required String email, required String password});
  Future<void> logout();
}