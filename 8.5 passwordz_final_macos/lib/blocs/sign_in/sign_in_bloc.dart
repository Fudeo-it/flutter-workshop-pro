import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passwordz/models/user.dart';
import 'package:passwordz/repositories/user_repository.dart';

part 'sign_in_event.dart';

part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final UserRepository userRepository;

  SignInBloc({
    required this.userRepository,
  }) : super(const NotSignedInState()) {
    on<SignInEvent>(_onSignIn);
  }

  void signIn({
    required String email,
    required String password,
  }) =>
      add(
        SignInEvent(
          email: email,
          password: password,
        ),
      );

  FutureOr<void> _onSignIn(SignInEvent event, Emitter<SignInState> emit) async {
    emit(const SigningInState());

    try {
      final user = await userRepository.signIn(
        email: event.email,
        password: event.password,
      );
      emit(SignedInState(user));
    } catch (e) {
      emit(const ErrorSignInState());
    }
  }
}
