import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_template/shared/services/local/local_storage.dart';
import 'package:my_template/shared/utils/constants/storage_key.dart';

class ThemeCubit extends Cubit<bool>{
  ThemeCubit() : super(SchedulerBinding.instance.platformDispatcher.platformBrightness == Brightness.light);

  Future<void> initialized()async{
    final light = await LocalStorage.instance.light;

    emit(light ?? SchedulerBinding.instance.platformDispatcher.platformBrightness == Brightness.light);
  }

  void toggleTheme(){
    LocalStorage.instance.setData<bool>(StorageKey.light, !state);
    emit(!state);
  }
}