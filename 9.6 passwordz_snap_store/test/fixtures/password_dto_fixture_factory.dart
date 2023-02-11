import 'package:data_fixture_dart/data_fixture_dart.dart';
import 'package:passwordz/services/network/dto/password_dto.dart';

extension PasswordDTOFixture on PasswordDTO {
  static PasswordDTOFixtureFactory factory() => PasswordDTOFixtureFactory();
}

class PasswordDTOFixtureFactory extends JsonFixtureFactory<PasswordDTO> {
  @override
  FixtureDefinition<PasswordDTO> definition() => define(
        (faker) => PasswordDTO(
          name: faker.company.name(),
          website: faker.internet.httpsUrl(),
          username: faker.internet.email(),
          password: faker.internet.password(),
        ),
      );

  @override
  JsonFixtureDefinition<PasswordDTO> jsonDefinition() => defineJson(
        (object) => {
          'name': object.name,
          'website': object.website,
          'email': object.username,
          'password': object.password,
        },
      );
}
