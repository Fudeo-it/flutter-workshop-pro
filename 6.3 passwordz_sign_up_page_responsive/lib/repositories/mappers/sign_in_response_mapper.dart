import 'package:passwordz/models/user.dart';
import 'package:passwordz/services/network/dto/sign_in_response.dart';
import 'package:pine/pine.dart';

class SignInResponseMapper extends DTOMapper<SignInResponse, User> {
  @override
  User fromDTO(SignInResponse dto) => User(
        name: dto.name,
        email: dto.email,
        token: dto.token,
      );

  @override
  SignInResponse toDTO(User model) {
    throw UnimplementedError();
  }
}
