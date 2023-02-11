part of 'account_bloc.dart';

abstract class AccountEvent extends Equatable {
  const AccountEvent();

  @override
  List<Object?> get props => [];
}

class FetchAccountsEvent extends AccountEvent {
  const FetchAccountsEvent();
}

class SaveAccountEvent extends AccountEvent {
  final Account account;

  const SaveAccountEvent(this.account);

  @override
  List<Object?> get props => [account];
}

class UpdateAccountEvent extends AccountEvent {
  final Account account;
  final int index;

  const UpdateAccountEvent(
    this.account, {
    required this.index,
  });

  @override
  List<Object?> get props => [account, index];
}

class DeleteAccountEvent extends AccountEvent {
  final int index;

  const DeleteAccountEvent(this.index);

  @override
  List<Object?> get props => [index];
}
