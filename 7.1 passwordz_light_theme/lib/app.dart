import 'package:flutter/material.dart';
import 'package:passwordz/di/dependency_injector.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:passwordz/routers/app_router.gr.dart';
import 'package:passwordz/theme/models/theme.dart';

class App extends StatelessWidget {
  final _router = AppRouter();

  App({super.key});

  @override
  Widget build(BuildContext context) {
    return DependencyInjector(
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        onGenerateTitle: (context) =>
            AppLocalizations.of(context)?.app_name ?? 'Passwordz',
        supportedLocales: AppLocalizations.supportedLocales,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        routeInformationParser: _router.defaultRouteParser(),
        routerDelegate: _router.delegate(),
        theme: LightTheme.make,
      ),
    );
  }
}
