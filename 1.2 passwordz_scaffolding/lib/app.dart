import 'package:flutter/material.dart';
import 'package:passwordz/di/dependency_injector.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return DependencyInjector(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateTitle: (context) =>
            AppLocalizations.of(context)?.app_name ?? 'Passwordz',
        supportedLocales: AppLocalizations.supportedLocales,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}
