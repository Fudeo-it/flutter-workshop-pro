import 'package:equatable/equatable.dart';
import 'package:pine/pine.dart';

class SignInRequest extends DTO with EquatableMixin {
  static const _emailKey = 'email';
  static const _passwordKey = 'password';

  final String email;
  final String password;

  SignInRequest({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
        _emailKey: email,
        _passwordKey: password,
      };

  @override
  List<Object?> get props => [
        email,
        password,
      ];
}
