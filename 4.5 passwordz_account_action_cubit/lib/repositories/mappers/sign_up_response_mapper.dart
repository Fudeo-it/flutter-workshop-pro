import 'package:passwordz/models/user.dart';
import 'package:passwordz/services/network/dto/sign_up_response.dart';
import 'package:pine/pine.dart';

class SignUpResponseMapper extends DTOMapper<SignUpResponse, User> {
  @override
  User fromDTO(SignUpResponse dto) => User(
        name: dto.name,
        email: dto.email,
        token: dto.token,
      );

  @override
  SignUpResponse toDTO(User model) {
    throw UnimplementedError();
  }
}
