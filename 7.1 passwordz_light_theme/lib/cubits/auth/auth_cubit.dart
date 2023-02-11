import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passwordz/models/user.dart';
import 'package:passwordz/repositories/user_repository.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final UserRepository userRepository;

  AuthCubit({required this.userRepository})
      : super(const CheckAuthenticationState());

  void checkAuthenticationState() async {
    final user = await userRepository.currentUser;

    emit(user != null
        ? AuthenticatedState(user)
        : const NotAuthenticatedState());
  }

  void authenticated(User user) => emit(AuthenticatedState(user));

  void signOut() async {
    await userRepository.signOut();

    emit(const NotAuthenticatedState());
  }
}
