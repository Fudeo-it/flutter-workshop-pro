import 'package:equatable/equatable.dart';
import 'package:passwordz/services/network/dto/password_dto.dart';
import 'package:pine/pine.dart';

class UpdateAccountRequest extends DTO with EquatableMixin {
  static const _passwordsKey = 'passwords';

  final List<PasswordDTO> passwords;

  UpdateAccountRequest([this.passwords = const []]);

  Map<String, dynamic> toJson() => {
        _passwordsKey: passwords,
      };

  @override
  List<Object?> get props => [passwords];
}
