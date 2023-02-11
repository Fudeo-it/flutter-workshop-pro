part of 'sign_up_bloc.dart';

abstract class SignUpState extends Equatable {
  const SignUpState();

  @override
  List<Object> get props => [];
}

class NotSignedUpState extends SignUpState {
  const NotSignedUpState();
}

class SigningUpState extends SignUpState {
  const SigningUpState();
}

class SignedUpState extends SignUpState {
  final User user;

  const SignedUpState(this.user);

  @override
  List<Object> get props => [user];
}

class ErrorSignUpState extends SignUpState {
  const ErrorSignUpState();
}
