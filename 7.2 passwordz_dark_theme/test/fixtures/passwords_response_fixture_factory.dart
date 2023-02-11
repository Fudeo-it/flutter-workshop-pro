import 'package:data_fixture_dart/data_fixture_dart.dart';
import 'package:passwordz/services/network/dto/passwords_response.dart';

import 'password_dto_fixture_factory.dart';

extension PasswordsResponseFixture on PasswordsResponse {
  static PasswordsResponseFixtureFactory factory() =>
      PasswordsResponseFixtureFactory();
}

class PasswordsResponseFixtureFactory
    extends JsonFixtureFactory<PasswordsResponse> {
  @override
  FixtureDefinition<PasswordsResponse> definition() => define(
        (_) => PasswordsResponse(
          PasswordDTOFixture.factory().makeMany(3),
        ),
      );

  @override
  JsonFixtureDefinition<PasswordsResponse> jsonDefinition() =>
      defineJson((object) => {
            'passwords': object.passwords,
          });
}
