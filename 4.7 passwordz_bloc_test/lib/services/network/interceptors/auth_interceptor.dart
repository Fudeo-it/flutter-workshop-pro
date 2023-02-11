import 'dart:io';

import 'package:dio/dio.dart';
import 'package:passwordz/repositories/user_repository.dart';

class AuthInterceptor extends QueuedInterceptor {
  final UserRepository userRepository;

  AuthInterceptor({required this.userRepository});

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final user = await userRepository.currentUser;

    if (user != null) {
      options.headers[HttpHeaders.authorizationHeader] = 'Bearer ${user.token}';
    }

    super.onRequest(options, handler);
  }
}
