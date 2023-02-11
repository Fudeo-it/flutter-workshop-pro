import 'package:equatable/equatable.dart';
import 'package:pine/pine.dart';

class SignInResponse extends DTO with EquatableMixin {
  static const _nameKey = 'name';
  static const _emailKey = 'email';
  static const _tokenKey = 'token';

  final String name;
  final String email;
  final String token;

  SignInResponse({
    required this.name,
    required this.email,
    required this.token,
  });

  factory SignInResponse.fromJson(Map<String, dynamic> json) => SignInResponse(
        name: json[_nameKey],
        email: json[_emailKey],
        token: json[_tokenKey],
      );

  @override
  List<Object?> get props => [
        name,
        email,
        token,
      ];
}
