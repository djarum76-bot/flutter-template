import 'package:flutter/material.dart';
import 'package:my_template/features/authentication/presentation/pages/login_page.dart';
import 'package:my_template/features/authentication/presentation/pages/register_page.dart';
import 'package:my_template/themes/app_text_style.dart';

class AppRoutes{
  static const loginPage = '/login';
  static const registerPage = '/register';

  static Route<dynamic>? onGenerateRoutes(RouteSettings settings){
    switch(settings.name){
      case loginPage:
        return _pageRouteBuilder(page: const LoginPage());
      case registerPage:
        return _pageRouteBuilder(page: const RegisterPage());
      default:
        return MaterialPageRoute(builder: (_){
          return Scaffold(
            body: Text(
              "No route defined for ${settings.name}",
              style: AppTypography.heading8.copyWith(color: const Color(0xFFE6E1E5)),
            ),
          );
        });
    }
  }

  static PageRouteBuilder<dynamic> _pageRouteBuilder({required Widget page}){
    return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          return page;
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        }
    );
  }
}