part of 'dependency_injector.dart';

final List<SingleChildWidget> _providers = [
  Provider<Logger>(
    create: (_) => Logger(),
  ),
  if (kDebugMode)
    Provider<PrettyDioLogger>(
      create: (_) => PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        compact: true,
      ),
    ),
  Provider<Dio>(
    create: (context) => Dio()
      ..interceptors.addAll([
        if (kDebugMode) context.read<PrettyDioLogger>(),
      ]),
  ),
  Provider<AuthService>(
    create: (context) => AuthService(
      context.read<Dio>(),
      baseUrl: 'https://servatedb.vercel.app/api/fudeo-flutter-workshop-pro',
    ),
  ),
  Provider<AccountService>(
    create: (context) => AccountService(
      context.read<Dio>(),
      baseUrl: 'https://servatedb.vercel.app/api/fudeo-flutter-workshop-pro',
    ),
  ),
];
