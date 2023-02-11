part of 'dependency_injector.dart';

final List<SingleChildWidget> _mappers = [
  Provider<Mapper<User, String>>(
    create: (_) => UserMapper(),
  ),
  Provider<DTOMapper<SignInResponse, User>>(
    create: (_) => SignInResponseMapper(),
  ),
  Provider<DTOMapper<SignUpResponse, User>>(
    create: (_) => SignUpResponseMapper(),
  ),
  Provider<DTOMapper<PasswordDTO, Account>>(
    create: (_) => AccountMapper(),
  ),
];
