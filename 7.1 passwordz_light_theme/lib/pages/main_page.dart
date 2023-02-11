import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passwordz/cubits/auth/auth_cubit.dart';
import 'package:passwordz/routers/app_router.gr.dart';
import 'package:passwordz/widgets/loading_widget.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthenticatedState) {
            _replacePage(context, const AccountsRoute());
          } else if (state is NotAuthenticatedState) {
            _replacePage(context, const SignInRoute());
          }
        },
        child: const Scaffold(
          body: LoadingWidget(),
        ),
      );

  Future<void> _replacePage(
    BuildContext context,
    PageRouteInfo route,
  ) async {
    context.router.popUntilRoot();
    await context.pushRoute(route);
  }
}
