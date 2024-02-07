part of 'authentication_bloc.dart';

enum AuthenticationStatus { initial, loading, authenticated, unauthenticated, error }

class AuthenticationState extends Equatable{
  const AuthenticationState({
    this.status = AuthenticationStatus.initial
  });

  final AuthenticationStatus status;

  @override
  List<Object> get props => [status];

  AuthenticationState copyWith({
    AuthenticationStatus? status,
  }) {
    return AuthenticationState(
      status: status ?? this.status
    );
  }
}
