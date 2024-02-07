import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_template/features/authentication/domain/repositories/authentication_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRepository authenticationRepository;

  AuthenticationBloc({required this.authenticationRepository}) : super(const AuthenticationState()) {
    on<AuthenticationRegister>(_onAuthenticationRegister);
    on<AuthenticationLogin>(_onAuthenticationLogin);
    on<AuthenticationLogout>(_onAuthenticationLogout);
  }

  Future<void> _onAuthenticationRegister(AuthenticationRegister event, Emitter<AuthenticationState> emit) async {
    emit(state.copyWith(status: AuthenticationStatus.loading));

    final response = await authenticationRepository.register(email: event.email, password: event.password);

    if (response.error) {
      emit(state.copyWith(status: AuthenticationStatus.error));
      return;
    }

    emit(state.copyWith(status: AuthenticationStatus.authenticated));
  }

  Future<void> _onAuthenticationLogin(AuthenticationLogin event, Emitter<AuthenticationState> emit) async {
    emit(state.copyWith(status: AuthenticationStatus.loading));

    final response = await authenticationRepository.login(email: event.email, password: event.password);

    if (response.error) {
      emit(state.copyWith(status: AuthenticationStatus.error));
      return;
    }

    emit(state.copyWith(status: AuthenticationStatus.authenticated));
  }

  Future<void> _onAuthenticationLogout(AuthenticationLogout event, Emitter<AuthenticationState> emit) async {
    emit(state.copyWith(status: AuthenticationStatus.loading));

    await authenticationRepository.logout();

    emit(state.copyWith(status: AuthenticationStatus.unauthenticated));
  }
}
