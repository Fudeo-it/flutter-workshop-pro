import 'package:equatable/equatable.dart';
import 'package:pine/pine.dart';

class PasswordDTO extends DTO with EquatableMixin {
  static const _nameKey = 'name';
  static const _websiteKey = 'website';
  static const _usernameKey = 'email';
  static const _passwordKey = 'password';

  final String name;
  final String website;
  final String username;
  final String password;

  PasswordDTO({
    required this.name,
    required this.website,
    required this.username,
    required this.password,
  });

  factory PasswordDTO.fromJson(Map<String, dynamic> json) => PasswordDTO(
      name: json[_nameKey],
      website: json[_websiteKey],
      username: json[_usernameKey],
      password: json[_passwordKey],
  );

  Map<String, dynamic> toJson() => {
    _nameKey: name,
    _websiteKey: website,
    _usernameKey: username,
    _passwordKey: password,
  };

  @override
  List<Object?> get props => [
    name,
    website,
    username,
    password,
  ];
}
