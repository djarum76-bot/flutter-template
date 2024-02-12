import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeCubit extends Cubit<bool>{
  ThemeCubit() : super(ThemeMode.system == ThemeMode.light);

  void toggleTheme(){
    emit(!state);
  }
}