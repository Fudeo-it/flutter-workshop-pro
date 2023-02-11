import 'package:data_fixture_dart/data_fixture_dart.dart';
import 'package:passwordz/services/network/dto/passwords_response.dart';
import 'package:passwordz/services/network/dto/update_account_request.dart';

import 'password_dto_fixture_factory.dart';

extension UpdateAccountRequestFixture on UpdateAccountRequest {
  static UpdateAccountRequestFixtureFactory factory() =>
      UpdateAccountRequestFixtureFactory();
}

class UpdateAccountRequestFixtureFactory
    extends JsonFixtureFactory<UpdateAccountRequest> {
  @override
  FixtureDefinition<UpdateAccountRequest> definition() => define(
        (_) => UpdateAccountRequest(
          PasswordDTOFixture.factory().makeMany(3),
        ),
      );

  @override
  JsonFixtureDefinition<UpdateAccountRequest> jsonDefinition() =>
      defineJson((object) => {
            'passwords': object.passwords,
          });
}
