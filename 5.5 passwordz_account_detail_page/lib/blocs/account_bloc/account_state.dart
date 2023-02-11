part of 'account_bloc.dart';

abstract class AccountState extends Equatable {
  const AccountState();

  @override
  List<Object> get props => [];
}

class FetchingAccountsState extends AccountState {
  const FetchingAccountsState();
}

class FetchedAccountsState extends AccountState {
  final List<Account> accounts;

  const FetchedAccountsState(this.accounts);

  @override
  List<Object> get props => [accounts];
}

class NoAccountsState extends AccountState {
  const NoAccountsState();
}

class ErrorAccountsState extends AccountState {
  const ErrorAccountsState();
}
