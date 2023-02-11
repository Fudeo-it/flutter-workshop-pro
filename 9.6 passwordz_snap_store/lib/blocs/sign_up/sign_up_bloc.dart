import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passwordz/models/user.dart';
import 'package:passwordz/repositories/user_repository.dart';

part 'sign_up_event.dart';

part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final UserRepository userRepository;

  SignUpBloc({
    required this.userRepository,
  }) : super(const NotSignedUpState()) {
    on<SignUpEvent>(_onSignUp);
  }

  void signUp({
    required String name,
    required String email,
    required String password,
  }) =>
      add(
        SignUpEvent(
          name: name,
          email: email,
          password: password,
        ),
      );

  FutureOr<void> _onSignUp(SignUpEvent event, Emitter<SignUpState> emit) async {
    emit(const SigningUpState());

    try {
      final user = await userRepository.signUp(
        name: event.name,
        email: event.email,
        password: event.password,
      );
      emit(SignedUpState(user));
    } catch (e) {
      emit(const ErrorSignUpState());
    }
  }
}
