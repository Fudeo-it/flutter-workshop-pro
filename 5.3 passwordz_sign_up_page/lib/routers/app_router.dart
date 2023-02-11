import 'package:auto_route/auto_route.dart';
import 'package:passwordz/pages/accounts_page.dart';
import 'package:passwordz/pages/main_page.dart';
import 'package:passwordz/pages/sign_in_page.dart';
import 'package:passwordz/pages/sign_up_page.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  preferRelativeImports: false,
  routes: [
    AutoRoute(page: MainPage, initial: true),
    AutoRoute(page: SignInPage, path: 'signIn'),
    AutoRoute(page: SignUpPage, path: 'signUp'),
    AutoRoute(page: AccountsPage, path: 'accounts'),
  ],
)
class $AppRouter {}
