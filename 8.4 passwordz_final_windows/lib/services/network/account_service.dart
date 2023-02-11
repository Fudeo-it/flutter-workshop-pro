import 'package:dio/dio.dart';
import 'package:passwordz/services/network/dto/passwords_response.dart';
import 'package:passwordz/services/network/dto/update_account_request.dart';
import 'package:retrofit/retrofit.dart';

part 'account_service.g.dart';

@RestApi()
abstract class AccountService {
  factory AccountService(
    Dio dio, {
    String baseUrl,
  }) = _AccountService;

  @GET('/passwords')
  Future<PasswordsResponse> all();

  @PATCH('/passwords')
  Future<PasswordsResponse> update(@Body() UpdateAccountRequest request);
}
