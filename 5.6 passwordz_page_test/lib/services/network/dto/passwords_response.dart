import 'package:equatable/equatable.dart';
import 'package:passwordz/services/network/dto/password_dto.dart';
import 'package:pine/pine.dart';

class PasswordsResponse extends DTO with EquatableMixin {
  static const _passwordsKey = 'passwords';

  final List<PasswordDTO> passwords;

  PasswordsResponse([this.passwords = const []]);

  factory PasswordsResponse.fromJson(Map<String, dynamic> json) =>
      PasswordsResponse(
        (json[_passwordsKey] as List)
            .map((password) => PasswordDTO.fromJson(password))
            .toList(growable: false),
      );

  @override
  List<Object?> get props => [passwords];
}
