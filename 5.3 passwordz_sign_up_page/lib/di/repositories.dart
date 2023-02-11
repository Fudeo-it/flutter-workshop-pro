part of 'dependency_injector.dart';

final List<RepositoryProvider> _repositories = [
  RepositoryProvider<AccountRepository>(
    create: (context) => AccountRepository(
      accountService: context.read(),
      accountMapper: context.read(),
      logger: context.read(),
    ),
  ),
  RepositoryProvider<UserRepository>(create: (context) {
    final userRepository = UserRepository(
      authService: context.read(),
      signUpMapper: context.read(),
      signInMapper: context.read(),
      userMapper: context.read(),
      secureStorage: context.read(),
      logger: context.read(),
    );

    context.read<Dio>().interceptors.insert(
          0,
          AuthInterceptor(
            userRepository: userRepository,
          ),
        );

    return userRepository;
  }),
];
