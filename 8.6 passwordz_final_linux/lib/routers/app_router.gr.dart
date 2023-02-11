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
import 'package:auto_route/auto_route.dart' as _i7;
import 'package:flutter/material.dart' as _i8;
import 'package:passwordz/models/account.dart' as _i9;
import 'package:passwordz/pages/account_detail_page.dart' as _i5;
import 'package:passwordz/pages/accounts_page.dart' as _i4;
import 'package:passwordz/pages/main_page.dart' as _i1;
import 'package:passwordz/pages/settings_page.dart' as _i6;
import 'package:passwordz/pages/sign_in_page.dart' as _i2;
import 'package:passwordz/pages/sign_up_page.dart' as _i3;

class AppRouter extends _i7.RootStackRouter {
  AppRouter([_i8.GlobalKey<_i8.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i7.PageFactory> pagesMap = {
    MainRoute.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.MainPage(),
      );
    },
    SignInRoute.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i7.WrappedRoute(child: const _i2.SignInPage()),
      );
    },
    SignUpRoute.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i7.WrappedRoute(child: const _i3.SignUpPage()),
      );
    },
    AccountsRoute.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i7.WrappedRoute(child: const _i4.AccountsPage()),
      );
    },
    AccountDetailRoute.name: (routeData) {
      final args = routeData.argsAs<AccountDetailRouteArgs>();
      return _i7.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i5.AccountDetailPage(
          args.account,
          key: args.key,
          onAccountChanged: args.onAccountChanged,
          onAccountDeleted: args.onAccountDeleted,
          masterDetailNavigation: args.masterDetailNavigation,
        ),
      );
    },
    SettingsRoute.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i6.SettingsPage(),
      );
    },
  };

  @override
  List<_i7.RouteConfig> get routes => [
        _i7.RouteConfig(
          MainRoute.name,
          path: '/',
        ),
        _i7.RouteConfig(
          SignInRoute.name,
          path: 'signIn',
        ),
        _i7.RouteConfig(
          SignUpRoute.name,
          path: 'signUp',
        ),
        _i7.RouteConfig(
          AccountsRoute.name,
          path: 'accounts',
        ),
        _i7.RouteConfig(
          AccountDetailRoute.name,
          path: 'details',
        ),
        _i7.RouteConfig(
          SettingsRoute.name,
          path: 'settings',
        ),
      ];
}

/// generated route for
/// [_i1.MainPage]
class MainRoute extends _i7.PageRouteInfo<void> {
  const MainRoute()
      : super(
          MainRoute.name,
          path: '/',
        );

  static const String name = 'MainRoute';
}

/// generated route for
/// [_i2.SignInPage]
class SignInRoute extends _i7.PageRouteInfo<void> {
  const SignInRoute()
      : super(
          SignInRoute.name,
          path: 'signIn',
        );

  static const String name = 'SignInRoute';
}

/// generated route for
/// [_i3.SignUpPage]
class SignUpRoute extends _i7.PageRouteInfo<void> {
  const SignUpRoute()
      : super(
          SignUpRoute.name,
          path: 'signUp',
        );

  static const String name = 'SignUpRoute';
}

/// generated route for
/// [_i4.AccountsPage]
class AccountsRoute extends _i7.PageRouteInfo<void> {
  const AccountsRoute()
      : super(
          AccountsRoute.name,
          path: 'accounts',
        );

  static const String name = 'AccountsRoute';
}

/// generated route for
/// [_i5.AccountDetailPage]
class AccountDetailRoute extends _i7.PageRouteInfo<AccountDetailRouteArgs> {
  AccountDetailRoute({
    required _i9.Account? account,
    _i8.Key? key,
    void Function(_i9.Account)? onAccountChanged,
    void Function()? onAccountDeleted,
    bool masterDetailNavigation = false,
  }) : super(
          AccountDetailRoute.name,
          path: 'details',
          args: AccountDetailRouteArgs(
            account: account,
            key: key,
            onAccountChanged: onAccountChanged,
            onAccountDeleted: onAccountDeleted,
            masterDetailNavigation: masterDetailNavigation,
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
    this.masterDetailNavigation = false,
  });

  final _i9.Account? account;

  final _i8.Key? key;

  final void Function(_i9.Account)? onAccountChanged;

  final void Function()? onAccountDeleted;

  final bool masterDetailNavigation;

  @override
  String toString() {
    return 'AccountDetailRouteArgs{account: $account, key: $key, onAccountChanged: $onAccountChanged, onAccountDeleted: $onAccountDeleted, masterDetailNavigation: $masterDetailNavigation}';
  }
}

/// generated route for
/// [_i6.SettingsPage]
class SettingsRoute extends _i7.PageRouteInfo<void> {
  const SettingsRoute()
      : super(
          SettingsRoute.name,
          path: 'settings',
        );

  static const String name = 'SettingsRoute';
}
