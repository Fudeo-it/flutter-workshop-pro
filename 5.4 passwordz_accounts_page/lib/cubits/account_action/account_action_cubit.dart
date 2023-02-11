import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passwordz/models/account.dart';

part 'account_action_state.dart';

class AccountActionCubit extends Cubit<AccountActionState> {
  AccountActionCubit() : super(const UnselectedAccountActionState());

  void edit({
    required Account account,
    required int index,
  }) =>
      emit(EditAccountActionState(account: account, index: index));

  void unselect() => emit(const UnselectedAccountActionState());

  void newAccount() => emit(const NewAccountActionState());
}
