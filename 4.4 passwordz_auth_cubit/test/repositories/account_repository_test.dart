import 'package:flutter_test/flutter_test.dart';
import 'package:logger/logger.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:passwordz/models/account.dart';
import 'package:passwordz/repositories/account_repository.dart';
import 'package:passwordz/repositories/mappers/account_mapper.dart';
import 'package:passwordz/services/network/account_service.dart';
import 'package:passwordz/services/network/dto/passwords_response.dart';
import 'package:passwordz/services/network/dto/update_account_request.dart';

import '../fixtures/passwords_response_fixture_factory.dart';
import '../fixtures/update_account_request_fixture_factory.dart';
import 'account_repository_test.mocks.dart';

@GenerateMocks([
  AccountService,
  AccountMapper,
  Logger,
])
void main() {
  late MockAccountService accountService;
  late MockAccountMapper accountMapper;
  late MockLogger logger;

  late AccountRepository accountRepository;

  late UpdateAccountRequest updateAccountRequest;
  late PasswordsResponse passwordsResponse;

  setUp(() {
    accountService = MockAccountService();
    accountMapper = MockAccountMapper();
    logger = MockLogger();

    accountRepository = AccountRepository(
      accountService: accountService,
      accountMapper: accountMapper,
      logger: logger,
    );

    updateAccountRequest = UpdateAccountRequestFixture.factory().makeSingle();
    passwordsResponse = PasswordsResponseFixture.factory().makeSingle();
  });

  group('test get accounts', () {
    test('get accounts successfully', () async {
      List<Account> accounts = [];

      when(accountService.all()).thenAnswer((_) async => passwordsResponse);

      for (final fixture in passwordsResponse.passwords) {
        final account = Account(
          name: fixture.name,
          website: fixture.website,
          username: fixture.username,
          password: fixture.password,
        );

        when(accountMapper.fromDTO(fixture)).thenReturn(account);

        accounts.add(account);
      }

      final actual = await accountRepository.accounts;

      expect(actual, accounts);

      verify(accountService.all()).called(1);
      verify(accountMapper.fromDTO(any))
          .called(passwordsResponse.passwords.length);
    });

    test('get accounts return an error from accountService', () async {
      when(accountService.all()).thenThrow(Error());

      try {
        await accountRepository.accounts;
        expect(true, isFalse, reason: 'Expecting an exception"');
      } catch (error) {
        expect(error, isInstanceOf<Error>());
      }

      verify(accountService.all()).called(1);
      verifyNever(accountMapper.fromDTO(any));
    });
  });

  group('test update accounts', () {
    test('update accounts successfully', () async {
      List<Account> inputAccounts = [];
      for (final fixture in updateAccountRequest.passwords) {
        final account = Account(
          name: fixture.name,
          website: fixture.website,
          username: fixture.username,
          password: fixture.password,
        );

        when(accountMapper.toDTO(account)).thenReturn(fixture);

        inputAccounts.add(account);
      }

      List<Account> outputAccounts = [];

      when(accountService.update(updateAccountRequest))
          .thenAnswer((_) async => passwordsResponse);

      for (final fixture in passwordsResponse.passwords) {
        final account = Account(
          name: fixture.name,
          website: fixture.website,
          username: fixture.username,
          password: fixture.password,
        );

        when(accountMapper.fromDTO(fixture)).thenReturn(account);

        outputAccounts.add(account);
      }

      final actual = await accountRepository.update(inputAccounts);

      expect(actual, outputAccounts);

      verify(accountService.update(updateAccountRequest)).called(1);
      verify(accountMapper.toDTO(any))
          .called(updateAccountRequest.passwords.length);
      verify(accountMapper.fromDTO(any))
          .called(passwordsResponse.passwords.length);
    });

    test('update accounts return an error from accountService', () async {
      List<Account> inputAccounts = [];
      for (final fixture in updateAccountRequest.passwords) {
        final account = Account(
          name: fixture.name,
          website: fixture.website,
          username: fixture.username,
          password: fixture.password,
        );

        when(accountMapper.toDTO(account)).thenReturn(fixture);

        inputAccounts.add(account);
      }

      when(accountService.update(updateAccountRequest)).thenThrow(Error());

      try {
        await accountRepository.update(inputAccounts);
        expect(true, isFalse, reason: 'Expecting an exception"');
      } catch (error) {
        expect(error, isInstanceOf<Error>());
      }

      verify(accountService.update(updateAccountRequest)).called(1);
      verifyNever(accountMapper.fromDTO(any));
      verify(accountMapper.toDTO(any))
          .called(updateAccountRequest.passwords.length);
    });
  });
}
