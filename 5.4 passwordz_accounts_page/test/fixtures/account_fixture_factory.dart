import 'package:data_fixture_dart/data_fixture_dart.dart';
import 'package:passwordz/models/account.dart';

extension AccountFixture on Account {
  static AccountFixtureFactory factory() => AccountFixtureFactory();
}

class AccountFixtureFactory extends FixtureFactory<Account> {
  @override
  FixtureDefinition<Account> definition() => define(
        (faker) => Account(
          name: faker.company.name(),
          website: faker.internet.httpsUrl(),
          username: faker.internet.email(),
          password: faker.internet.password(),
        ),
      );
}
