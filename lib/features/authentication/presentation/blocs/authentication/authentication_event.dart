part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthenticationRegister extends AuthenticationEvent{
  final String email;
  final String password;

  AuthenticationRegister({required this.email, required this.password});
}

class AuthenticationLogin extends AuthenticationEvent{
  final String email;
  final String password;

  AuthenticationLogin({required this.email, required this.password});
}

class AuthenticationLogout extends AuthenticationEvent{}