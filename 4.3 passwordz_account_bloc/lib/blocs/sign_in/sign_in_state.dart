part of 'sign_in_bloc.dart';

abstract class SignInState extends Equatable {
  const SignInState();

  @override
  List<Object> get props => [];
}

class NotSignedInState extends SignInState {
  const NotSignedInState();
}

class SigningInState extends SignInState {
  const SigningInState();
}

class SignedInState extends SignInState {
  final User user;

  const SignedInState(this.user);

  @override
  List<Object> get props => [user];
}

class ErrorSignInState extends SignInState {
  const ErrorSignInState();
}
