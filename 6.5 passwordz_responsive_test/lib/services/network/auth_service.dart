import 'package:dio/dio.dart';
import 'package:passwordz/services/network/dto/sign_in_request.dart';
import 'package:passwordz/services/network/dto/sign_in_response.dart';
import 'package:passwordz/services/network/dto/sign_up_request.dart';
import 'package:passwordz/services/network/dto/sign_up_response.dart';
import 'package:retrofit/retrofit.dart';

part 'auth_service.g.dart';

@RestApi()
abstract class AuthService {
  factory AuthService(
    Dio dio, {
    String baseUrl,
  }) = _AuthService;

  @POST('/login')
  Future<SignInResponse> signIn(@Body() SignInRequest request);

  @POST('/register')
  Future<SignUpResponse> signUp(@Body() SignUpRequest request);
}
