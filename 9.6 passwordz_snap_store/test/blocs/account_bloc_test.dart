import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:passwordz/blocs/account_bloc/account_bloc.dart';
import 'package:passwordz/models/account.dart';
import 'package:passwordz/repositories/account_repository.dart';
import 'package:bloc_test/bloc_test.dart';

import '../fixtures/account_fixture_factory.dart';
import 'account_bloc_test.mocks.dart';

@GenerateMocks([AccountRepository])
void main() {
  late MockAccountRepository accountRepository;
  late List<Account> previousAccounts;
  late List<Account> accounts;
  late Account account;

  setUp(() {
    previousAccounts = AccountFixture.factory().makeMany(3);

    accountRepository = MockAccountRepository();
  });

  group('test fetch account', () {
    blocTest<AccountBloc, AccountState>(
      'fetch accounts successfully',
      setUp: () {
        accounts = AccountFixture.factory().makeMany(3);

        when(accountRepository.accounts).thenAnswer((_) async => accounts);
      },
      build: () => AccountBloc(accountRepository: accountRepository),
      act: (bloc) => bloc.fetchAccounts(),
      expect: () => [
        const FetchingAccountsState(),
        FetchedAccountsState(accounts),
      ],
      verify: (_) => verify(accountRepository.accounts).called(1),
    );

    blocTest<AccountBloc, AccountState>(
      'fetch empty accounts successfully',
      setUp: () {
        accounts = [];

        when(accountRepository.accounts).thenAnswer((_) async => accounts);
      },
      build: () => AccountBloc(accountRepository: accountRepository),
      act: (bloc) => bloc.fetchAccounts(),
      expect: () => [
        const FetchingAccountsState(),
        const NoAccountsState(),
      ],
      verify: (_) => verify(accountRepository.accounts).called(1),
    );

    blocTest<AccountBloc, AccountState>(
      'request accounts with error',
      setUp: () {
        when(accountRepository.accounts).thenThrow(Error());
      },
      build: () => AccountBloc(accountRepository: accountRepository),
      act: (bloc) => bloc.fetchAccounts(),
      expect: () => [
        const FetchingAccountsState(),
        const ErrorAccountsState(),
      ],
      verify: (_) => verify(accountRepository.accounts).called(1),
    );
  });

  group('test save account', () {
    blocTest<AccountBloc, AccountState>(
      'save account successfully with many accounts',
      setUp: () {
        account = AccountFixture.factory().makeSingle();
        accounts = [account];

        when(accountRepository.update(accounts))
            .thenAnswer((_) async => accounts);
      },
      build: () => AccountBloc(accountRepository: accountRepository),
      act: (bloc) => bloc.saveAccount(account),
      expect: () => [
        const FetchingAccountsState(),
        FetchedAccountsState(accounts),
      ],
      verify: (_) => verify(accountRepository.update(accounts)).called(1),
    );

    blocTest<AccountBloc, AccountState>(
      'save account successfully with previous accounts',
      setUp: () {
        account = AccountFixture.factory().makeSingle();
        accounts = [...previousAccounts, account];

        when(accountRepository.update(accounts))
            .thenAnswer((_) async => accounts);
      },
      build: () => AccountBloc(accountRepository: accountRepository),
      act: (bloc) => bloc.saveAccount(account),
      expect: () => [
        const FetchingAccountsState(),
        FetchedAccountsState(accounts),
      ],
      seed: () => FetchedAccountsState(previousAccounts),
      verify: (_) => verify(accountRepository.update(accounts)).called(1),
    );

    blocTest<AccountBloc, AccountState>(
      'save account with unexpected error',
      setUp: () {
        account = AccountFixture.factory().makeSingle();

        when(accountRepository.update(any)).thenThrow(Error());
      },
      build: () => AccountBloc(accountRepository: accountRepository),
      act: (bloc) => bloc.saveAccount(account),
      expect: () => [
        const FetchingAccountsState(),
        const ErrorAccountsState(),
      ],
      verify: (_) => verify(accountRepository.update(any)).called(1),
    );
  });

  group('test update account', () {
    blocTest<AccountBloc, AccountState>(
      'update account successfully with previous accounts',
      setUp: () {
        account = AccountFixture.factory().makeSingle();
        accounts = List.from(previousAccounts)..replaceRange(0, 1, [account]);

        when(accountRepository.update(accounts))
            .thenAnswer((_) async => accounts);
      },
      build: () => AccountBloc(accountRepository: accountRepository),
      act: (bloc) => bloc.updateAccount(account, index: 0),
      expect: () => [
        const FetchingAccountsState(),
        FetchedAccountsState(accounts),
      ],
      seed: () => FetchedAccountsState(previousAccounts),
      verify: (_) => verify(accountRepository.update(accounts)).called(1),
    );

    blocTest<AccountBloc, AccountState>(
      'update account with unexpected error',
      setUp: () {
        account = AccountFixture.factory().makeSingle();

        when(accountRepository.update(any)).thenThrow(Error());
      },
      build: () => AccountBloc(accountRepository: accountRepository),
      act: (bloc) => bloc.updateAccount(account, index: 1),
      expect: () => [
        const FetchingAccountsState(),
        const ErrorAccountsState(),
      ],
      verify: (_) => verify(accountRepository.update(any)).called(1),
    );
  });

  group('test delete account', () {
    blocTest<AccountBloc, AccountState>(
      'delete account successfully with previous accounts',
      setUp: () {
        account = AccountFixture.factory().makeSingle();
        accounts = List.from(previousAccounts)..removeAt(0);

        when(accountRepository.update(accounts))
            .thenAnswer((_) async => accounts);
      },
      build: () => AccountBloc(accountRepository: accountRepository),
      act: (bloc) => bloc.deleteAccount(0),
      expect: () => [
        const FetchingAccountsState(),
        FetchedAccountsState(accounts),
      ],
      seed: () => FetchedAccountsState(previousAccounts),
      verify: (_) => verify(accountRepository.update(accounts)).called(1),
    );

    blocTest<AccountBloc, AccountState>(
      'delete account with unexpected error',
      setUp: () {
        account = AccountFixture.factory().makeSingle();

        when(accountRepository.update(any)).thenThrow(Error());
      },
      build: () => AccountBloc(accountRepository: accountRepository),
      act: (bloc) => bloc.deleteAccount(1),
      expect: () => [
        const FetchingAccountsState(),
        const ErrorAccountsState(),
      ],
      verify: (_) => verify(accountRepository.update(any)).called(1),
    );
  });
}
