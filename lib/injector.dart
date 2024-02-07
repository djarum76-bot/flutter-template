import 'package:get_it/get_it.dart';
import 'package:my_template/features/authentication/data/repositories/authentication_repository_impl.dart';
import 'package:my_template/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:my_template/features/authentication/presentation/blocs/authentication/authentication_bloc.dart';

final injector = GetIt.instance;

void injectorSetup() {
  /// It use to register any Repository and any State Management

  /// For authentication
  injector.registerLazySingleton<AuthenticationRepository>(() => AuthenticationRepositoryImpl());
  injector.registerSingleton<AuthenticationBloc>(
    AuthenticationBloc(authenticationRepository: injector<AuthenticationRepository>())
  );
}