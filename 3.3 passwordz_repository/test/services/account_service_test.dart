import 'package:data_fixture_dart/misc/fixture_tuple.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:passwordz/services/network/account_service.dart';
import 'package:passwordz/services/network/dto/passwords_response.dart';
import 'package:passwordz/services/network/dto/update_account_request.dart';

import '../fixtures/passwords_response_fixture_factory.dart';
import '../fixtures/update_account_request_fixture_factory.dart';

void main() {
  late FixtureTuple<PasswordsResponse> passwordsResponse;
  late FixtureTuple<UpdateAccountRequest> updateAccountRequest;

  late Dio dio;
  late DioAdapter dioAdapter;

  late AccountService service;

  setUp(() {
    passwordsResponse =
        PasswordsResponseFixture.factory().makeSingleWithJsonObject();
    updateAccountRequest =
        UpdateAccountRequestFixture.factory().makeSingleWithJsonObject();

    dio = Dio(BaseOptions());
    dioAdapter = DioAdapter(dio: dio);

    service = AccountService(dio);
  });

  group('testing [GET] /passwords endpoint', () {
    test('get passwords successfully', () async {
      dioAdapter.onGet(
        '/passwords',
        (server) => server.reply(200, passwordsResponse.json),
        data: {},
        headers: {},
        queryParameters: {},
      );

      final response = await service.all();
      expect(response, passwordsResponse.object);
    });

    test('get passwords with unexpected error', () {
      dioAdapter.onGet(
        '/passwords',
        (server) => server.reply(500, null),
        data: {},
        headers: {},
        queryParameters: {},
      );

      expect(() async => await service.all(), throwsException);
    });
  });

  group('testing [PATCH] /passwords endpoint', () {
    test('update passwords successfully', () async {
      dioAdapter.onPatch(
        '/passwords',
        (server) => server.reply(200, passwordsResponse.json),
        data: updateAccountRequest.json,
        headers: {},
        queryParameters: {},
      );

      final response = await service.update(updateAccountRequest.object);
      expect(response, passwordsResponse.object);
    });

    test('update passwords with unexpected error', () {
      dioAdapter.onPatch(
        '/passwords',
        (server) => server.reply(500, null),
        data: updateAccountRequest.json,
        headers: {},
        queryParameters: {},
      );

      expect(() async => await service.update(updateAccountRequest.object),
          throwsException);
    });
  });
}
