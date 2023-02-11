import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passwordz/models/account.dart';
import 'package:passwordz/repositories/account_repository.dart';

part 'account_event.dart';

part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final AccountRepository accountRepository;

  AccountBloc({
    required this.accountRepository,
  }) : super(const FetchingAccountsState()) {
    on<FetchAccountsEvent>(_fetchAccounts);
    on<SaveAccountEvent>(_saveAccount);
    on<UpdateAccountEvent>(_updateAccount);
    on<DeleteAccountEvent>(_deleteAccount);
  }

  void fetchAccounts() => add(const FetchAccountsEvent());

  void saveAccount(Account account) => add(SaveAccountEvent(account));

  void updateAccount(
    Account account, {
    required int index,
  }) =>
      add(UpdateAccountEvent(account, index: index));

  void deleteAccount(int index) => add(DeleteAccountEvent(index));

  FutureOr<void> _fetchAccounts(
      FetchAccountsEvent event, Emitter<AccountState> emit) async {
    emit(const FetchingAccountsState());

    try {
      final accounts = await accountRepository.accounts;
      emit(accounts.isNotEmpty
          ? FetchedAccountsState(accounts)
          : const NoAccountsState());
    } catch (error) {
      emit(const ErrorAccountsState());
    }
  }

  FutureOr<void> _saveAccount(
      SaveAccountEvent event, Emitter<AccountState> emit) async {
    List<Account> accounts = List.from(state is FetchedAccountsState
        ? (state as FetchedAccountsState).accounts
        : []);

    emit(const FetchingAccountsState());

    try {
      accounts.add(event.account);

      accounts = await accountRepository.update(accounts);
      emit(accounts.isNotEmpty
          ? FetchedAccountsState(accounts)
          : const NoAccountsState());
    } catch (error) {
      emit(const ErrorAccountsState());
    }
  }

  FutureOr<void> _updateAccount(
      UpdateAccountEvent event, Emitter<AccountState> emit) async {
    List<Account> accounts = List.from(state is FetchedAccountsState
        ? (state as FetchedAccountsState).accounts
        : []);

    emit(const FetchingAccountsState());

    try {
      if (event.index >= 0 && event.index < accounts.length) {
        accounts.replaceRange(
          event.index,
          event.index + 1,
          [event.account],
        );

        accounts = await accountRepository.update(accounts);
        emit(accounts.isNotEmpty
            ? FetchedAccountsState(accounts)
            : const NoAccountsState());
      }
    } catch (error) {
      emit(const ErrorAccountsState());
    }
  }

  FutureOr<void> _deleteAccount(
      DeleteAccountEvent event, Emitter<AccountState> emit) async {
    List<Account> accounts = List.from(state is FetchedAccountsState
        ? (state as FetchedAccountsState).accounts
        : []);

    emit(const FetchingAccountsState());

    try {
      if (event.index >= 0 && event.index < accounts.length) {
        accounts.removeAt(event.index);
      }

      accounts = await accountRepository.update(accounts);
      emit(accounts.isNotEmpty
          ? FetchedAccountsState(accounts)
          : const NoAccountsState());
    } catch (error) {
      emit(const ErrorAccountsState());
    }
  }
}
