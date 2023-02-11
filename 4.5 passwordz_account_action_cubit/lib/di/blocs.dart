part of 'dependency_injector.dart';

final List<BlocProvider> _blocs = [
  BlocProvider<AuthCubit>(
    create: (context) => AuthCubit(
      userRepository: context.read(),
    )..checkAuthenticationState(),
  )
];
