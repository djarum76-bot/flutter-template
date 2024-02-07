import 'package:my_template/features/authentication/domain/entities/authentication.dart';

class AuthenticationModel extends Authentication{
  AuthenticationModel({required super.email, required super.password});

  AuthenticationModel copyWith({
    String? email,
    String? password,
  }) {
    return AuthenticationModel(
      email: email ?? this.email,
      password: password ?? this.password
    );
  }
}