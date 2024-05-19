import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_template/features/authentication/presentation/blocs/authentication/authentication_bloc.dart';
import 'package:my_template/injector.dart';
import 'package:my_template/shared/utils/routes/app_routes.dart';
import 'package:my_template/themes/app_colors_style.dart';
import 'package:my_template/themes/theme_cubit.dart';
import 'package:path_provider/path_provider.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final appDocumentDirectory = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(appDocumentDirectory.path);

  injectorSetup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark
        )
    );

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => injector<ThemeCubit>()..initialized()),
        BlocProvider(create: (context) => injector<AuthenticationBloc>()),
      ],
      child: BlocBuilder<ThemeCubit, bool>(
        builder: (context, state){
          return ScreenUtilInit(
            designSize: const Size(393, 852),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (_, child){
              return GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
                child: ConnectivityAppWrapper(
                  app: MaterialApp(
                    navigatorKey: navigatorKey,
                    debugShowCheckedModeBanner: false,
                    theme: state ? AppTheme.light : AppTheme.dark,
                    onGenerateRoute: AppRoutes.onGenerateRoutes,
                    initialRoute: AppRoutes.loginPage,
                    builder: (buildContext, widget) {
                      return ConnectivityWidgetWrapper(
                        disableInteraction: true,
                        height: 80,
                        child: widget!,
                      );
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}