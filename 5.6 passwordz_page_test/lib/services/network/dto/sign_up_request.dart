import 'package:equatable/equatable.dart';
import 'package:pine/pine.dart';

class SignUpRequest extends DTO with EquatableMixin {
  static const _nameKey = 'name';
  static const _emailKey = 'email';
  static const _passwordKey = 'password';

  final String name;
  final String email;
  final String password;

  SignUpRequest({
    required this.name,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
        _nameKey: name,
        _emailKey: email,
        _passwordKey: password,
      };

  @override
  List<Object?> get props => [
        name,
        email,
        password,
      ];
}
