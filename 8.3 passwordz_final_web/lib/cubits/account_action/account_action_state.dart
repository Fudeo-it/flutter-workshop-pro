part of 'account_action_cubit.dart';

abstract class AccountActionState extends Equatable {
  const AccountActionState();

  @override
  List<Object> get props => [];
}

class UnselectedAccountActionState extends AccountActionState {
  const UnselectedAccountActionState();
}

class NewAccountActionState extends AccountActionState {
  const NewAccountActionState();
}

class EditAccountActionState extends AccountActionState {
  final Account account;
  final int index;

  const EditAccountActionState({
    required this.account,
    required this.index,
  });

  @override
  List<Object> get props => [account, index];
}
