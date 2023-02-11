import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logger/logger.dart';
import 'package:passwordz/cubits/auth/auth_cubit.dart';
import 'package:passwordz/models/account.dart';
import 'package:passwordz/models/user.dart';
import 'package:passwordz/repositories/account_repository.dart';
import 'package:passwordz/repositories/mappers/account_mapper.dart';
import 'package:passwordz/repositories/mappers/sign_in_response_mapper.dart';
import 'package:passwordz/repositories/mappers/sign_up_response_mapper.dart';
import 'package:passwordz/repositories/mappers/user_mapper.dart';
import 'package:passwordz/repositories/user_repository.dart';
import 'package:passwordz/services/network/account_service.dart';
import 'package:passwordz/services/network/auth_service.dart';
import 'package:passwordz/services/network/dto/password_dto.dart';
import 'package:passwordz/services/network/dto/sign_in_response.dart';
import 'package:passwordz/services/network/dto/sign_up_response.dart';
import 'package:passwordz/services/network/interceptors/auth_interceptor.dart';
import 'package:passwordz/theme/cubits/theme_cubit.dart';
import 'package:pine/pine.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

part 'blocs.dart';
part 'mappers.dart';
part 'providers.dart';
part 'repositories.dart';

class DependencyInjector extends StatelessWidget {
  final Widget child;

  const DependencyInjector({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => DependencyInjectorHelper(
        blocs: _blocs,
        mappers: _mappers,
        providers: _providers,
        repositories: _repositories,
        child: child,
      );
}
