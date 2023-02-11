// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i6;
import 'package:flutter/material.dart' as _i7;
import 'package:passwordz/models/account.dart' as _i8;
import 'package:passwordz/pages/account_detail_page.dart' as _i5;
import 'package:passwordz/pages/accounts_page.dart' as _i4;
import 'package:passwordz/pages/main_page.dart' as _i1;
import 'package:passwordz/pages/sign_in_page.dart' as _i2;
import 'package:passwordz/pages/sign_up_page.dart' as _i3;

class AppRouter extends _i6.RootStackRouter {
  AppRouter([_i7.GlobalKey<_i7.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i6.PageFactory> pagesMap = {
    MainRoute.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.MainPage(),
      );
    },
    SignInRoute.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i6.WrappedRoute(child: const _i2.SignInPage()),
      );
    },
    SignUpRoute.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i6.WrappedRoute(child: const _i3.SignUpPage()),
      );
    },
    AccountsRoute.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i6.WrappedRoute(child: const _i4.AccountsPage()),
      );
    },
    AccountDetailRoute.name: (routeData) {
      final args = routeData.argsAs<AccountDetailRouteArgs>();
      return _i6.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i5.AccountDetailPage(
          args.account,
          key: args.key,
          onAccountChanged: args.onAccountChanged,
          onAccountDeleted: args.onAccountDeleted,
        ),
      );
    },
  };

  @override
  List<_i6.RouteConfig> get routes => [
        _i6.RouteConfig(
          MainRoute.name,
          path: '/',
        ),
        _i6.RouteConfig(
          SignInRoute.name,
          path: 'signIn',
        ),
        _i6.RouteConfig(
          SignUpRoute.name,
          path: 'signUp',
        ),
        _i6.RouteConfig(
          AccountsRoute.name,
          path: 'accounts',
        ),
        _i6.RouteConfig(
          AccountDetailRoute.name,
          path: 'details',
        ),
      ];
}

/// generated route for
/// [_i1.MainPage]
class MainRoute extends _i6.PageRouteInfo<void> {
  const MainRoute()
      : super(
          MainRoute.name,
          path: '/',
        );

  static const String name = 'MainRoute';
}

/// generated route for
/// [_i2.SignInPage]
class SignInRoute extends _i6.PageRouteInfo<void> {
  const SignInRoute()
      : super(
          SignInRoute.name,
          path: 'signIn',
        );

  static const String name = 'SignInRoute';
}

/// generated route for
/// [_i3.SignUpPage]
class SignUpRoute extends _i6.PageRouteInfo<void> {
  const SignUpRoute()
      : super(
          SignUpRoute.name,
          path: 'signUp',
        );

  static const String name = 'SignUpRoute';
}

/// generated route for
/// [_i4.AccountsPage]
class AccountsRoute extends _i6.PageRouteInfo<void> {
  const AccountsRoute()
      : super(
          AccountsRoute.name,
          path: 'accounts',
        );

  static const String name = 'AccountsRoute';
}

/// generated route for
/// [_i5.AccountDetailPage]
class AccountDetailRoute extends _i6.PageRouteInfo<AccountDetailRouteArgs> {
  AccountDetailRoute({
    required _i8.Account? account,
    _i7.Key? key,
    void Function(_i8.Account)? onAccountChanged,
    void Function()? onAccountDeleted,
  }) : super(
          AccountDetailRoute.name,
          path: 'details',
          args: AccountDetailRouteArgs(
            account: account,
            key: key,
            onAccountChanged: onAccountChanged,
            onAccountDeleted: onAccountDeleted,
          ),
        );

  static const String name = 'AccountDetailRoute';
}

class AccountDetailRouteArgs {
  const AccountDetailRouteArgs({
    required this.account,
    this.key,
    this.onAccountChanged,
    this.onAccountDeleted,
  });

  final _i8.Account? account;

  final _i7.Key? key;

  final void Function(_i8.Account)? onAccountChanged;

  final void Function()? onAccountDeleted;

  @override
  String toString() {
    return 'AccountDetailRouteArgs{account: $account, key: $key, onAccountChanged: $onAccountChanged, onAccountDeleted: $onAccountDeleted}';
  }
}
