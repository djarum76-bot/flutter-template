import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:my_template/main.dart';
import 'package:my_template/shared/services/local/local_storage.dart';
import 'package:my_template/shared/utils/constants/api_constant.dart';
import 'package:my_template/shared/utils/routes/app_routes.dart';
import 'package:my_template/shared/widgets/custom_toast.dart';

///Interceptor for debugging
class HandlingInterceptor extends QueuedInterceptor {
  final _storage = LocalStorage.instance;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler)async{
    // TODO: implement onRequest
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // TODO: implement onResponse
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler)async{
    if(err.response?.statusCode == null){
      CustomToast.customToast("Sorry, unable to connect to server. Please check your internet connection.");
    }else{
      if(err.response?.statusCode == 401){
        final token = await _storage.token;

        if(token.isEmpty){
          CustomToast.customToast(err.response?.data[ApiConstant.error] ?? "An error occurred. Please try again later.Code : ${err.response?.statusCode}.");
        }else{
          if(JwtDecoder.isExpired(await _storage.token)){
            CustomToast.customToast("The session is over. Please log in again");
            Navigator.pushNamedAndRemoveUntil(navigatorKey.currentContext!, AppRoutes.loginPage, (route) => false);
          }else{
            CustomToast.customToast(err.response?.data[ApiConstant.error] ?? "An error occurred. Please try again later.Code : ${err.response?.statusCode}.");
          }
        }
      }else{
        if(err.response!.data.toString().contains('<!DOCTYPE html>')){
          CustomToast.customToast("An error occurred. Please try again later.Code : ${err.response?.statusCode}.");
        }else{
          CustomToast.customToast(err.response?.data[ApiConstant.error] ?? "An error occurred. Please try again later.Code : ${err.response?.statusCode}.");
        }
      }
    }

    super.onError(err, handler);
  }
}
