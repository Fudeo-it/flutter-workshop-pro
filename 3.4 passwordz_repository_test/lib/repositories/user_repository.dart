import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logger/logger.dart';
import 'package:passwordz/misc/constants.dart';
import 'package:passwordz/models/user.dart';
import 'package:passwordz/services/network/auth_service.dart';
import 'package:passwordz/services/network/dto/sign_in_request.dart';
import 'package:passwordz/services/network/dto/sign_in_response.dart';
import 'package:passwordz/services/network/dto/sign_up_request.dart';
import 'package:passwordz/services/network/dto/sign_up_response.dart';
import 'package:pine/pine.dart';

class UserRepository {
  final AuthService authService;
  final FlutterSecureStorage secureStorage;
  final Mapper<User, String> userMapper;
  final DTOMapper<SignInResponse, User> signInMapper;
  final DTOMapper<SignUpResponse, User> signUpMapper;
  final Logger logger;

  UserRepository({
    required this.authService,
    required this.secureStorage,
    required this.userMapper,
    required this.signInMapper,
    required this.signUpMapper,
    required this.logger,
  });

  Future<User> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final response = await authService.signIn(
        SignInRequest(
          email: email,
          password: password,
        ),
      );

      final user = signInMapper.fromDTO(response);

      await secureStorage.write(
        key: K.userKey,
        value: userMapper.from(user),
      );

      return user;
    } catch (error, stackTrace) {
      logger.e(
        'Error signing in with email: $email and password $password',
        error,
        stackTrace,
      );

      rethrow;
    }
  }

  Future<User> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await authService.signUp(
        SignUpRequest(
          name: name,
          email: email,
          password: password,
        ),
      );

      final user = signUpMapper.fromDTO(response);

      return user;
    } catch (error, stackTrace) {
      logger.e(
        'Error signing up with name: $name, email $email and password $password',
        error,
        stackTrace,
      );

      rethrow;
    }
  }

  Future<void> signOut() => secureStorage.delete(key: K.userKey);

  Future<User?> get currentUser async {
    final json = await secureStorage.read(key: K.userKey);

    if (json != null) {
      return userMapper.to(json);
    }

    return null;
  }
}
