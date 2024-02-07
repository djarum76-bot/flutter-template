import 'package:dio/dio.dart';
import 'package:my_template/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:my_template/shared/services/local/local_storage.dart';
import 'package:my_template/shared/services/network/api_response.dart';
import 'package:my_template/shared/services/network/interceptors/logging_interceptor.dart';
import 'package:my_template/shared/services/network/interceptors/token_interceptor.dart';
import 'package:my_template/shared/services/network/network_client.dart';
import 'package:my_template/shared/services/network/url.dart';
import 'package:my_template/shared/utils/constants/api_constant.dart';
import 'package:my_template/shared/utils/constants/storage_key.dart';

class AuthenticationRepositoryImpl extends AuthenticationRepository{
  final LocalStorage _storage = LocalStorage.instance;

  final NetworkClient _client = NetworkClient(
    dioClient: Dio(BaseOptions(baseUrl: Url.baseURL)),
    interceptors: [
      LoggingInterceptor(),
      TokenInterceptor()
    ],
  );

  @override
  Future<ApiResponse> register({required String email, required String password})async{
    try{
      /// this use when API accept FormData only
      FormData data = FormData.fromMap({
        ApiConstant.email : email,
        ApiConstant.password : password,
      });

      /// this use when API accept JSON only
      // var jsonData = {
      //   ApiConstant.email : email,
      //   ApiConstant.password : password,
      // };

      final response = await _client.post(
          endpoint: Url.user(UserEndpoint.register),
          data: data
        // data: jsonEncode(jsonData)
      );

      _storage.setData<String>(StorageKey.token, response.data[StorageKey.token]);

      return ApiResponse(
          code: response.statusCode!,
          message: "",
          error: false
      );
    } on DioException catch(e){
      return _client.errorParser(e);
    }
  }

  @override
  Future<ApiResponse> login({required String email, required String password})async{
    try{
      /// this use when API accept FormData only
      FormData data = FormData.fromMap({
        ApiConstant.email : email,
        ApiConstant.password : password,
      });

      /// this use when API accept JSON only
      // var jsonData = {
      //   ApiConstant.email : email,
      //   ApiConstant.password : password,
      // };

      final response = await _client.post(
        endpoint: Url.user(UserEndpoint.login),
        data: data
        // data: jsonEncode(jsonData)
      );

      _storage.setData<String>(StorageKey.token, response.data[StorageKey.token]);

      return ApiResponse(
        code: response.statusCode!,
        message: "",
        error: false
      );
    } on DioException catch(e){
      return _client.errorParser(e);
    }
  }

  @override
  Future<void> logout()async{
    try{
      await _storage.deleteData();
    } catch(_) {
      await _storage.deleteData();
    }
  }
}