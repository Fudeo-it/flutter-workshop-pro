import 'dart:convert';

import 'package:passwordz/models/user.dart';
import 'package:pine/pine.dart';

class UserMapper extends Mapper<User, String> {
  static const _nameField = 'name';
  static const _emailField = 'email';
  static const _tokenField = 'token';

  @override
  String from(User from) => jsonEncode(<String, dynamic>{
        _nameField: from.name,
        _emailField: from.email,
        _tokenField: from.token,
      });

  @override
  User to(String to) {
    final json = jsonDecode(to);

    return User(
      name: json[_nameField],
      email: json[_emailField],
      token: json[_tokenField],
    );
  }
}
